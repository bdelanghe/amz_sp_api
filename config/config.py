# config/config.py (Updated)

import json
import os
from utils.github_utils import get_github_repo_url
from utils.git_utils import get_git_config_value, get_latest_git_tag
from utils.interactive_utils import print_colored

# Global color map for different sources
SOURCE_COLORS = {
    'config': 'cyan',
    'env': 'yellow',
    'git': 'blue',
    'GitHub': 'magenta'
}

# Suffix map for certain configuration keys
SUFFIXES = {
    'moduleName': "(set per model)",
    'gemVersion': "(incr of latest version tag)"
}

# Suffix color
SUFFIX_COLOR = 'green'

class Config:
    _instance = None

    def __new__(cls, config_filename='config.json'):
        if cls._instance is None:
            cls._instance = super(Config, cls).__new__(cls)
            cls._instance._initialize(config_filename)
        return cls._instance

    def _initialize(self, config_filename):
        if not os.path.exists(config_filename):
            raise FileNotFoundError(f"Configuration file {config_filename} not found.")
        
        with open(config_filename, 'r') as file:
            config_data = json.load(file)

        # Load configuration values from environment or other sources with fallbacks
        self.config = {}
        self.source_info = {}  # Track how each value is set

        for key in config_data:
            self.config[key], self.source_info[key] = self._get_value_with_fallback(key, config_data)

        # Set gemVersion dynamically from the latest git tag
        gem_version = get_latest_git_tag() or "0.1.0"
        self.config['gemVersion'] = gem_version
        self.source_info['gemVersion'] = 'git'

    def _get_value_with_fallback(self, key, config_data):
        """
        Get the value from environment variables, config file, GitHub repo URL, or Git config.
        Track how the value was set.

        Args:
            key (str): The configuration key to retrieve.
            config_data (dict): The configuration data from the config file.

        Returns:
            tuple: The value for the given key and its source.

        Raises:
            ValueError: If the configuration value is not found.
        """
        # 1. Check if it's available in the environment variable
        value = os.getenv(key.upper(), None)
        if value:
            return value, 'env'

        # 2. Check if it's available in the config data
        value = config_data.get(key, None)
        if value:
            return value, 'config'

        # 3. Use fallback mechanisms for specific keys
        if key == 'gemAuthor':
            value = get_git_config_value('user.name')
            if value:
                return value, 'git'
        elif key == 'gemAuthorEmail':
            value = get_git_config_value('user.email')
            if value:
                return value, 'git'
        elif key == 'gemHomepage':
            value = get_github_repo_url()
            if value:
                return value, 'GitHub'

        raise ValueError(f"Configuration value for '{key}' is required but was not found.")

    def get(self, key):
        """
        Get a value from the configuration.

        Args:
            key (str): The key to retrieve from the configuration.

        Returns:
            str: The value corresponding to the given key.

        Raises:
            KeyError: If the key is not found in the configuration.
        """
        if key not in self.config:
            raise KeyError(f"Configuration key '{key}' not found.")
        return self.config[key]

    def get_all(self):
        """
        Get all configuration values as a dictionary.
        """
        return self.config

    def print_config(self):
        """
        Print the current configuration with source information.
        """
        def bold_text(text: str) -> str:
            return f"\033[1m{text}\033[0m"

        print_colored("\nConfiguration Information:", color='cyan')
        for key, value in self.config.items():
            # Get suffix if it exists for the given key
            suffix = SUFFIXES.get(key, "")

            # Determine the source of the value and get the color
            source = self.source_info.get(key, 'unknown')
            source_color = SOURCE_COLORS.get(source, 'white')

            # Use bold for key names for better readability
            formatted_key = f"{bold_text(key)}: {value}"
            
            # Print key-value pair
            print_colored(f"  {formatted_key}", color=None, newline=False)

            # Print suffix if it exists with a defined color
            if suffix:
                print_colored(f" {suffix}", color=SUFFIX_COLOR, newline=False)

            # Print source information
            print_colored(f" ({source})", color=source_color)

