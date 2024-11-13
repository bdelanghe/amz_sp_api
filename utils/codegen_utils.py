# utils/codegen_utils.py

import subprocess
import shutil
import tempfile
from utils.interactive_utils import print_info, print_error, prompt_confirmation, print_dry_run_info

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

def generate_model(api_file_path: str, config_file_path: str, output_directory: str, module_name: str, dry_run: bool = False) -> None:
    """
    Generate the API model.

    Args:
        api_file_path: Path to the API JSON file.
        config_file_path: Path to the config file.
        output_directory: Output directory for generated files.
        module_name: Name of the module for display.
        dry_run: If True, only simulate the generation without creating files.
    """
    if dry_run:
        print_dry_run_info(api_file_path, config_file_path, module_name, output_directory)
        return

    run_swagger_codegen(api_file_path, config_file_path, output_directory)

def generate_versioned_model(
    api_name: str,
    version: str,
    version_info: dict[str, any],
    config: any,
    temp_dir: str,
    is_dry_run: bool,
    is_interactive: bool
) -> bool:
    """Generate a versioned model."""
    module_name = version_info['module_name']
    config_path = config.create_temp_config_with_module(version_info['gem_name'], module_name)

    print_info(f"Generating model for API {api_name} Version V{version}")
    generate_model(
        api_file_path=version_info["api_file"],
        config_file_path=config_path,
        output_directory=temp_dir,
        module_name=module_name,
        dry_run=is_dry_run
    )

    if is_interactive:
        return prompt_confirmation(f"Model for API {api_name} Version V{version} generated. Proceed to the next?")
    return True

def generate_unversioned_model(
    api_name: str,
    version: str,
    version_info: dict[str, any],
    config: any,
    temp_dir: str,
    is_dry_run: bool,
    is_interactive: bool
) -> bool:
    """Generate an unversioned model."""
    unversioned_module_name = version_info['module_name'].rsplit("::V", 1)[0]  # Remove the version suffix
    config_path = config.create_temp_config_with_module(version_info['gem_name'], unversioned_module_name)

    print_info(f"Generating unversioned model for API {api_name} (latest version V{version})")
    generate_model(
        api_file_path=version_info["api_file"],
        config_file_path=config_path,
        output_directory=temp_dir,
        module_name=unversioned_module_name,
        dry_run=is_dry_run
    )

    if is_interactive:
        return prompt_confirmation(f"Unversioned model for API {api_name} generated. Proceed to the next?")
    return True

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

def process_and_generate_models(
    models_overview: dict[str, any],
    config: any,
    is_dry_run: bool = False,
    is_interactive: bool = False,
    process_unversioned: bool = True
) -> None:
    """
    Process and generate models based on the overview data.

    Args:
        models_overview: The dictionary containing an overview of models to generate.
        config: The configuration object.
        is_dry_run: If True, simulate the generation without actually creating files.
        is_interactive: If True, prompt the user for confirmation between steps.
        process_unversioned: If True, generate unversioned models; otherwise, skip unversioned model generation.
    """
    with tempfile.TemporaryDirectory() as temp_dir:
        for api_name, api_details in models_overview["api_details"].items():
            print_info(f"Processing API: {api_name}")
            for version, version_info in api_details["versions"].items():
                # Generate versioned model
                if not generate_versioned_model(api_name, version, version_info, config, temp_dir, is_dry_run, is_interactive):
                    return  # Exit if operation is cancelled

                # Generate unversioned model if applicable
                if process_unversioned and version_info['is_latest']:
                    if not generate_unversioned_model(api_name, version, version_info, config, temp_dir, is_dry_run, is_interactive):
                        return  # Exit if operation is cancelled

                # After successful generation, move files to their final output directory
                final_output_dir = version_info["lib_dir"]
                if not is_dry_run:
                    shutil.move(temp_dir, final_output_dir)
                    print_info(f"Files for API {api_name} Version V{version} moved to {final_output_dir}")
