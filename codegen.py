import json
import os
from utils.git_utils import get_git_config_value

class Config:
    _instance = None

    def __new__(cls, config_filename='config.json'):
        if cls._instance is None:
            cls._instance = super(Config, cls).__new__(cls)
            cls._instance._initialize(config_filename)
        return cls._instance

    def _initialize(self, config_filename: str) -> None:
        """
        Initialize configuration by loading from file and overwriting with environment variables.

        Args:
            config_filename: Path to the config.json file.
        """
        # Read the config file
        config_data = self._read_config_file(config_filename)

        # Overwrite with environment variables or fallback logic
        self.config = {
            'GEMNAME': self._get_env_or_raise('GEMNAME', config_data.get('gemName')),
            'MODULENAME': self._get_env_or_default('MODULENAME', config_data.get('moduleName')),
            'GEMVERSION': self._get_env_or_raise('GEMVERSION', config_data.get('gemVersion')),
            'GEMAUTHOR': self._get_env_or_raise('GEMAUTHOR', config_data.get('gemAuthor')) or get_git_config_value('user.name'),
            'GEMAUTHOREMAIL': self._get_env_or_raise('GEMAUTHOREMAIL', config_data.get('gemAuthorEmail')) or get_git_config_value('user.email'),
            'GEMHOMEPAGE': self._get_env_or_raise('GEMHOMEPAGE', config_data.get('gemHomepage')),
            'GEMLICENSE': self._get_env_or_default('GEMLICENSE', config_data.get('gemLicense')),
            'HTTPCLIENTTYPE': self._get_env_or_default('HTTPCLIENTTYPE', config_data.get('httpClientType')),
            'MODELPACKAGE': self._get_env_or_default('MODELPACKAGE', config_data.get('modelPackage')),
            'APIPACKAGE': self._get_env_or_default('APIPACKAGE', config_data.get('apiPackage')),
            'LIBDIRECTORY': self._get_env_or_raise('LIBDIRECTORY', config_data.get('libDirectory')),
            'CONFIG_TEMPLATE_FILENAME': self._get_env_or_raise('CONFIG_TEMPLATE_FILENAME', config_data.get('configTemplateFilename')),
        }

        # Ensure that critical values are not empty after resolving all fallbacks
        self._validate_required_fields()

    def _read_config_file(self, config_filename: str) -> dict:
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

    def _get_env_or_default(self, env_var: str, default_value: str) -> str:
        """
        Get the value from the environment variable or return the default.

        Args:
            env_var: Environment variable name.
            default_value: Default value if the environment variable is not set.

        Returns:
            The value from the environment variable or the default value.
        """
        return os.getenv(env_var, default_value)

    def _get_env_or_raise(self, env_var: str, config_value: str) -> str:
        """
        Get the value from the environment variable, or return the config value.
        If neither exists or the config value is an empty string, raise an error.

        Args:
            env_var: Environment variable name.
            config_value: The value from the configuration file.

        Returns:
            The value from the environment variable or config.

        Raises:
            ValueError: If the value is not provided by either source.
        """
        value = os.getenv(env_var, config_value)
        if not value:
            raise ValueError(f"Configuration value for '{env_var}' is required but not provided.")
        return value

    def _validate_required_fields(self) -> None:
        """
        Ensure that all critical configuration fields have values.
        Raises an error if any required fields are empty.
        """
        required_fields = ['GEMAUTHOR', 'GEMAUTHOREMAIL', 'GEMHOMEPAGE', 'LIBDIRECTORY', 'CONFIG_TEMPLATE_FILENAME']
        for field in required_fields:
            if not self.config.get(field):
                raise ValueError(f"Configuration value for '{field}' is required but is missing or empty.")

    def get(self, key: str) -> str:
        """
        Retrieve a configuration value.

        Args:
            key: The key to retrieve the value for.

        Returns:
            The value corresponding to the key.
        """
        return self.config.get(key)
