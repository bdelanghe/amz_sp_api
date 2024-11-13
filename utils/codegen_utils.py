# utils/codegen_utils.py

import subprocess
import shutil
import os
import tempfile
from utils.interactive_utils import print_info, print_error, prompt_confirmation

SWAGGER_CODEGEN_COMMAND = 'swagger-codegen'

def check_dependencies() -> None:
    """
    Check if external dependencies are available.
    """
    if not shutil.which(SWAGGER_CODEGEN_COMMAND):
        raise EnvironmentError(f"{SWAGGER_CODEGEN_COMMAND} is not installed or not found in PATH.")
    if not shutil.which('git'):
        raise EnvironmentError("git is not installed or not found in PATH.")
    if not shutil.which('gh'):
        raise EnvironmentError("GitHub CLI 'gh' is not installed or not found in PATH.")

def generate_model(api_file_path: str, config_file_path: str, output_directory: str, dry_run: bool = False) -> None:
    """
    Generate the API model.

    Args:
        api_file_path: Path to the API JSON file.
        config_file_path: Path to the config file.
        output_directory: Output directory for generated files.
        dry_run: If True, only simulate the generation without creating files.
    """
    if dry_run:
        print_info(f"Dry run: Would generate model from {api_file_path} with config {config_file_path} to {output_directory}")
        return

    run_swagger_codegen(api_file_path, config_file_path, output_directory)

def run_swagger_codegen(input_spec_path: str, config_file_path: str, output_directory: str) -> None:
    """
    Run the swagger-codegen command.

    Args:
        input_spec_path: Path to the input specification (API JSON file).
        config_file_path: Path to the configuration file.
        output_directory: Output directory for generated code.
    """
    subprocess.run([
        SWAGGER_CODEGEN_COMMAND, 'generate',
        '-i', input_spec_path,
        '-l', 'ruby',
        '-c', config_file_path,
        '-o', output_directory
    ], check=True)

def create_swagger_codegen_ignore(destination_path: str) -> None:
    """
    Create or update the .swagger-codegen-ignore file with specified patterns.

    Args:
        destination_path: The path where the .swagger-codegen-ignore file should be placed.
    """
    ignore_patterns = [
        'Gemfile',
        'LICENSE',
        'README.md',
        'Rakefile',
        'amz_sp_api.gemspec.erb',
        'codegen.py',
        'config.json',
        'git_push.sh',
        '*.gemspec',
        '*.md',
        'lib/**/*_spec.rb',
        'spec/',
        'test/'
    ]

    ignore_file_content = '\n'.join(ignore_patterns)

    with open(destination_path, 'w') as ignore_file:
        ignore_file.write(ignore_file_content)

def process_and_generate_models(models_overview: dict, config, is_dry_run: bool = False, is_interactive: bool = False) -> None:
    """
    Process and generate models based on the overview data.

    Args:
        models_overview: The dictionary containing an overview of models to generate.
        config: The configuration object.
        is_dry_run: If True, simulate the generation without actually creating files.
        is_interactive: If True, prompt the user for confirmation between steps.
    """
    with tempfile.TemporaryDirectory() as temp_dir:
        for api_name, api_details in models_overview["api_details"].items():
            print_info(f"Processing API: {api_name}")
            for version, version_info in api_details["versions"].items():
                # Generate the versioned model
                print_info(f"Generating model for API {api_name} Version V{version}")
                output_dir = version_info["lib_dir"]

                generate_model(
                    api_file_path=version_info["api_file"],
                    config_file_path=config.get('configTemplateFilename'),
                    output_directory=output_dir,
                    dry_run=is_dry_run
                )

                if is_interactive:
                    if not prompt_confirmation(f"Model for API {api_name} Version V{version} generated. Proceed to the next?"):
                        print_error("Operation cancelled by user.")
                        return

                # Check if the current version is the latest and generate an unversioned model
                if version_info['is_latest']:
                    unversioned_output_dir = os.path.join(config.get('libDirectory'), api_name)
                    print_info(f"Generating unversioned model for API {api_name} (latest version V{version})")

                    generate_model(
                        api_file_path=version_info["api_file"],
                        config_file_path=config.get('configTemplateFilename'),
                        output_directory=unversioned_output_dir,
                        dry_run=is_dry_run
                    )

                    if is_interactive:
                        if not prompt_confirmation(f"Unversioned model for API {api_name} generated. Proceed to the next?"):
                            print_error("Operation cancelled by user.")
                            return
