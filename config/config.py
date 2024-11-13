# config/config.py (Updated)

import json
import os
from utils.github_utils import get_github_repo_url
from utils.git_utils import get_git_config_value, get_latest_git_tag
from utils.interactive_utils import print_config

# Source constants for easy reference
SOURCE_ENV = 'env'
SOURCE_CONFIG = 'config'
SOURCE_GIT = 'git'
SOURCE_GITHUB = 'GitHub'
SOURCE_DEFAULT = 'default'

# Default values and descriptions
DEFAULT_CONFIG_FILENAME = 'config.json'
DEFAULT_GEM_VERSION = '0.1.0'
SOURCE_INCREMENT_VERSION_DESC = '(incr of latest version tag)'
SOURCE_MODEL_SET_DESC = '(set per model)'

# Error messages
ERROR_CONFIG_NOT_FOUND = "Configuration file {} not found."
ERROR_VALUE_NOT_FOUND = "Configuration value for '{}' is required but was not found."

class ConfigDict(dict):
    def __getitem__(self, key):
        """
        Override the default dictionary `__getitem__` to return only the value part.
        """
        if key not in self:
            raise KeyError(f"Configuration key '{key}' not found.")
        return super().__getitem__(key)['value']

    def get_full_entry(self, key):
        """
        Return the full entry (value and source) for a given key.
        """
        if key not in self:
            raise KeyError(f"Configuration key '{key}' not found.")
        return super().__getitem__(key)

class Config:
    _instance = None

    def __new__(cls, config_filename=DEFAULT_CONFIG_FILENAME):
        if cls._instance is None:
            cls._instance = super(Config, cls).__new__(cls)
            cls._instance._initialize(config_filename)
        return cls._instance

    def _initialize(self, config_filename):
        if not os.path.exists(config_filename):
            raise FileNotFoundError(ERROR_CONFIG_NOT_FOUND.format(config_filename))
        
        with open(config_filename, 'r') as file:
            config_data = json.load(file)

        # Initialize the config dictionary that stores both value and source
        self.config = ConfigDict()

        for key in config_data:
            value, source = self._get_value_with_fallback(key, config_data)
            self.config[key] = {'value': value, 'source': source}

        # Set gemVersion dynamically from the latest git tag
        gem_version = get_latest_git_tag() or DEFAULT_GEM_VERSION
        self.config['gemVersion'] = {'value': gem_version, 'source': SOURCE_INCREMENT_VERSION_DESC}

        self.config['moduleName'] = {'value': None, 'source': SOURCE_MODEL_SET_DESC}

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
            return value, SOURCE_ENV

        # 2. Check if it's available in the config data
        value = config_data.get(key, None)
        if value:
            return value, SOURCE_CONFIG

        # 3. Use fallback mechanisms for specific keys
        if key == 'gemAuthor':
            value = get_git_config_value('user.name')
            if value:
                return value, SOURCE_GIT
        elif key == 'gemAuthorEmail':
            value = get_git_config_value('user.email')
            if value:
                return value, SOURCE_GIT
        elif key == 'gemHomepage':
            value = get_github_repo_url()
            if value:
                return value, SOURCE_GITHUB

        raise ValueError(ERROR_VALUE_NOT_FOUND.format(key))

    def get(self, key):
        """
        Get a value from the configuration.

        Args:
            key (str): The key to retrieve from the configuration.

        Returns:
            str: The value corresponding to the given key.
        """
        return self.config[key]

    def get_full_entry(self, key):
        """
        Get the full entry (value and source) for a given key.

        Args:
            key (str): The key to retrieve from the configuration.

        Returns:
            dict: The full entry with 'value' and 'source'.
        """
        return self.config.get_full_entry(key)

    def get_all(self):
        """
        Get all configuration values as a dictionary.
        """
        return {key: self.config[key] for key in self.config}

    def get_all_with_sources(self):
        """
        Get all configuration values and their sources as a full dictionary.
        """
        return dict(self.config)
        
    def print_config(self, format_type: str = 'pretty') -> None:
        """
        Print the current configuration with source information.

        Args:
            format_type (str): The format in which to print the output ('pretty' or 'json').
        """
        # Pass the full config dictionary (including both value and source) to the print_config function
        print_config(self.get_all_with_sources(), format_type=format_type)
