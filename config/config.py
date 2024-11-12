# config/config.py

import json
import os

def read_config_file(config_filename: str) -> dict[str, str]:
    """
    Read configuration from config.json file.

    Args:
        config_filename: Path to the config.json file.

    Returns:
        Configuration dictionary.
    """
    if not os.path.exists(config_filename):
        raise FileNotFoundError(f"Configuration file {config_filename} not found.")
    with open(config_filename, 'r') as file:
        return json.load(file)

def get_env_or_default(env_var: str, default_value: str) -> str:
    """
    Get the value from environment variable or return default.

    Args:
        env_var: Environment variable name.
        default_value: Default value if the environment variable is not set.

    Returns:
        The value from the environment variable or the default value.
    """
    return os.getenv(env_var, default_value)
