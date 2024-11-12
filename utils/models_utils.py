# utils/models_utils.py

import os
import re
from glob import glob

LIB_DIRECTORY = 'lib'

def collect_api_files(models_directory: str) -> dict[str, list[str]]:
    """
    Collect JSON files grouped by API name.

    Args:
        models_directory: Path to the models directory.

    Returns:
        A dictionary mapping API names to lists of JSON file paths.
    """
    json_file_paths = glob(os.path.join(models_directory, '**', '*.json'), recursive=True)
    api_files = {}
    for json_file_path in json_file_paths:
        api_name = extract_api_name_from_path(json_file_path)
        if api_name is None:
            continue
        api_files.setdefault(api_name, []).append(json_file_path)
    return api_files

def extract_api_name_from_path(file_path: str) -> str | None:
    """
    Extract the API name from the file path.

    Args:
        file_path: The path to the JSON file.

    Returns:
        The extracted API name, or None if not found.
    """
    path_parts = file_path.split(os.sep)
    if 'models' not in path_parts:
        return None
    models_index = path_parts.index('models')
    if models_index + 1 >= len(path_parts):
        return None
    return path_parts[models_index + 1]

def extract_module_name(api_name: str) -> str:
    """
    Convert the API name to a module name.

    Args:
        api_name: The API name.

    Returns:
        The module name.
    """
    return ''.join(word.capitalize() for word in re.split('[-_]', api_name))
