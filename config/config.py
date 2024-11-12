# config/config.py

import json
import os
from utils.github_utils import get_github_repo_url
from utils.git_utils import get_git_config_value
from utils.interactive_utils import print_colored

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
            return value, 'environment variable'

        # 2. Check if it's available in the config data
        value = config_data.get(key, None)
        if value:
            return value, 'config file'

        # 3. Use fallback mechanisms for specific keys
        if key == 'gemAuthor':
            value = get_git_config_value('user.name')
            if value:
                return value, 'git config user.name'
        elif key == 'gemAuthorEmail':
            value = get_git_config_value('user.email')
            if value:
                return value, 'git config user.email'
        elif key == 'gemHomepage':
            value = get_github_repo_url()
            if value:
                return value, 'GitHub repo URL'

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
        print_colored("\nCurrent Configuration Information:", color='cyan')
        for key, value in self.config.items():
            suffix = ""
            if key == 'moduleName':
                suffix = " (dynamically set per model)"
            elif key == 'gemVersion':
                suffix = " (dynamically set from latest Git tag)"
            source = self.source_info.get(key, 'unknown source')
            print_colored(f"{key}: {value}{suffix} [set from: {source}]", color='white')
