#!/usr/bin/env python3

import os
import tempfile
from config.config import read_config_file, get_env_or_default
from utils.git_utils import get_git_config_value
from utils.github_utils import get_github_repo_url
from utils.codegen_utils import check_dependencies, generate_model
from utils.models_utils import collect_api_files
from utils.version_utils import get_latest_git_tag, increment_version
from utils.interactive_utils import print_colored, prompt_confirmation

def main() -> None:
    """
    Main function to orchestrate code generation and model tracking.
    """
    # Ensure dependencies are installed
    check_dependencies()

    # Load configuration from config.json
    config_data = read_config_file('config.json')

    # Collect available API files from the models directory
    api_files_dict = collect_api_files('selling-partner-api-models/models')

    # Determine the GEMVERSION using the latest Git tag
    latest_git_tag = get_latest_git_tag()
    current_version = latest_git_tag.lstrip('v') if latest_git_tag else '0.1.0'
    gem_version = increment_version(current_version)

    # Get author and email information from environment or git config
    gem_author = get_env_or_default('GEMAUTHOR', config_data.get('gemAuthor')) or get_git_config_value('user.name')
    gem_author_email = get_env_or_default('GEMAUTHOREMAIL', config_data.get('gemAuthorEmail')) or get_git_config_value('user.email')

    # Verify that both author and email are set, and neither are no-reply addresses
    if not gem_author or not gem_author_email:
        print_colored("Git user.name and user.email are not set. Please configure them or set environment variables.", color='red')
        return

    if is_no_reply_email(gem_author_email):
        print_colored("Your git email is a no-reply email. Please set a valid email.", color='red')
        return

    # Get GitHub repo URL, use default if not found
    github_repo_url = get_github_repo_url() or 'https://github.com/yourusername/yourrepo'

    # Prepare configuration information for the gem
    config_info = {
        'GEMNAME': get_env_or_default('GEMNAME', config_data.get('gemName')),
        # 'MODULENAME' will be determined per model later
        'GEMVERSION': get_env_or_default('GEMVERSION', gem_version),
        'GEMAUTHOR': gem_author,
        'GEMAUTHOREMAIL': gem_author_email,
        'GEMHOMEPAGE': get_env_or_default('GEMHOMEPAGE', github_repo_url),
        'GEMLICENSE': get_env_or_default('GEMLICENSE', config_data.get('gemLicense')),
        'HTTPCLIENTTYPE': get_env_or_default('HTTPCLIENTTYPE', config_data.get('httpClientType')),
        'MODELPACKAGE': get_env_or_default('MODELPACKAGE', config_data.get('modelPackage')),
        'APIPACKAGE': get_env_or_default('APIPACKAGE', config_data.get('apiPackage'))
    }

    # Display configuration for confirmation
    print_colored("\nConfiguration Information:", color='cyan')
    for key, value in config_info.items():
        if key != 'MODULENAME':
            print_colored(f"{key}: {value}", color='white')

    # Confirm to proceed
    if not prompt_confirmation("Proceed with this configuration?"):
        print_colored("Operation cancelled by user.", color='red')
        return

    # Generate models using configuration
    with tempfile.TemporaryDirectory() as temp_dir:
        for api_name, api_files in api_files_dict.items():
            # Setting up the module name dynamically based on API name
            config_info['MODULENAME'] = f"{api_name.capitalize()}Module"

            # Generate the model for each API file
            print_colored(f"\nGenerating model for API: {api_name}", color='blue')
            generate_model(api_files[0], 'config/config.json', os.path.join(temp_dir, 'output'))

if __name__ == '__main__':
    main()
