# config/config.py

import json
import os

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

        # Load configuration values from the environment or use defaults
        self.config = {key: self._get_env_or_error(key, config_data) for key in config_data}

    def _get_env_or_error(self, key, config_data):
        """
        Get the value from environment variables, or default from config.
        Raise an error if the key is not found or the value is empty.
        """
        value = os.getenv(key.upper(), config_data.get(key))
        if not value:
            raise ValueError(f"Configuration value for '{key}' is required but was not found.")
        return value

    def get(self, key):
        """
        Get a value from the configuration.
        """
        if key not in self.config:
            raise KeyError(f"Configuration key '{key}' not found.")
        return self.config[key]
