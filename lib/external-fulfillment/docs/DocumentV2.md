# AmzSpApi::ExternalFulfillment::DocumentV2

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**url** | **String** | A presigned URL to fetch the ship label file using an HTTP GET request. To determine file type, use the &#x60;contentType&#x60; header of the file response. The file retrieved will be in one of the following supported formats:  - **ZPL**: &#x60;x.application/zpl&#x60; - **PDF**: &#x60;application/pdf&#x60; - **PNG**: &#x60;image/png&#x60; - **Plain Text**: &#x60;text/plain&#x60; | 

