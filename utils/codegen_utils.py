# utils/codegen_utils.py

import subprocess
import shutil
import os

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

def generate_model(api_file_path: str, config_file_path: str, output_directory: str) -> None:
    """
    Generate the API model.

    Args:
        api_file_path: Path to the API JSON file.
        config_file_path: Path to the config file.
        output_directory: Output directory for generated files.
    """
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
