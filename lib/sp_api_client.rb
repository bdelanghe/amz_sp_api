require 'uri'
require 'securerandom'

require 'typhoeus'
require 'aws-sigv4'

require 'api_error'
require 'api_client'

module AmzSpApi
  class SpApiClient < ApiClient

    ACCESS_TOKEN_URL = 'https://api.amazon.com/auth/o2/token'.freeze
    SERVICE_NAME = 'execute-api'.freeze

    def initialize(config = SpConfiguration.default)
      super(config)
    end

    def call_api(http_method, path, opts = {})
      unsigned_request = build_request(http_method, path, opts)
      aws_headers = auth_headers(http_method, unsigned_request.url, unsigned_request.encoded_body)
      signed_opts = opts.merge(:header_params => aws_headers.merge(opts[:header_params] || {}))
      super(http_method, path, signed_opts)
    end

    private

    def retrieve_lwa_access_token
      return request_lwa_access_token['access_token'] unless config.get_access_token
      stored_token = config.get_access_token.call(client_id)
      if stored_token.nil?
        new_token = request_lwa_access_token
        config.save_access_token.call(client_id, new_token) if config.save_access_token
        return new_token['access_token']
      else
        return stored_token
      end
    end

    def request_lwa_access_token
      body = {
        grant_type: 'refresh_token',
        refresh_token: config.refresh_token,
        client_id: config.client_id,
        client_secret: config.client_secret
      }
      response = Typhoeus.post(
        ACCESS_TOKEN_URL,
        body: URI.encode_www_form(body),
        headers: {
          'Content-Type' => 'application/x-www-form-urlencoded;charset=UTF-8'
        }
      )
      parsed = JSON.parse(response.body)
      fail ApiError.new("can't get LWA access token #{response.inspect}") unless parsed['access_token']
      parsed
    end

    def signed_request_headers(http_method, url, body)
      request_config = {
        service: SERVICE_NAME,
        region: config.aws_region
      }
      if config.credentials_provider
        request_config[:credentials_provider] = config.credentials_provider
      else
        request_config[:access_key_id] = config.aws_access_key_id
        request_config[:secret_access_key] = config.aws_secret_access_key
      end
      signer = Aws::Sigv4::Signer.new(request_config)
      signer.sign_request(http_method: http_method.to_s, url: url, body: body).headers
    end

    def auth_headers(http_method, url, body)
      signed_request_headers(http_method, url, body).merge({
        'x-amz-access-token' => retrieve_lwa_access_token
      })
    end
  end
end
