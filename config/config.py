import json
import os
import tempfile
from utils.github_utils import get_github_repo_url
from utils.git_utils import get_git_config_value, get_latest_git_tag
from utils.interactive_utils import print_config

# Constants and default values
SOURCE_ENV = 'env'
SOURCE_CONFIG = 'config'
SOURCE_GIT = 'git'
SOURCE_GITHUB = 'GitHub'
SOURCE_DEFAULT = 'default'
DEFAULT_CONFIG_FILENAME = 'config.json'
DEFAULT_GEM_VERSION = '0.1.0'
SOURCE_INCREMENT_VERSION_DESC = '(incr of latest version tag)'
SOURCE_MODEL_SET_DESC = '(set per model)'
ERROR_CONFIG_NOT_FOUND = "Configuration file {} not found."
ERROR_VALUE_NOT_FOUND = "Configuration value for '{}' is required but was not found."

class ConfigDict(dict):
    def __getitem__(self, key):
        if key not in self:
            raise KeyError(f"Configuration key '{key}' not found.")
        return super().__getitem__(key)['value']

    def get_full_entry(self, key):
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

        self.config = ConfigDict()

        for key in config_data:
            value, source = self._get_value_with_fallback(key, config_data)
            self.config[key] = {'value': value, 'source': source}

        gem_version = get_latest_git_tag() or DEFAULT_GEM_VERSION
        self.config['gemVersion'] = {'value': gem_version, 'source': SOURCE_INCREMENT_VERSION_DESC}
        self.config['moduleName'] = {'value': None, 'source': SOURCE_MODEL_SET_DESC}

    def _get_value_with_fallback(self, key, config_data):
        value = os.getenv(key.upper(), None)
        if value:
            return value, SOURCE_ENV

        value = config_data.get(key, None)
        if value:
            return value, SOURCE_CONFIG

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
        return self.config[key]

    def get_full_entry(self, key):
        return self.config.get_full_entry(key)

    def get_all(self):
        return {key: self.config[key] for key in self.config}

    def get_all_with_sources(self):
        return dict(self.config)

    def print_config(self, format_type: str = 'pretty') -> None:
        print_config(self.get_all_with_sources(), format_type=format_type)

    def create_temp_config_with_module(self, gem_name: str, module_name: str) -> str:
        temp_config = self.get_all()
        temp_config['gemName'] = gem_name
        temp_config['moduleName'] = module_name

        temp_file = tempfile.NamedTemporaryFile(delete=False, suffix='.json')
        with open(temp_file.name, 'w') as file:
            json.dump(temp_config, file, indent=2)

        return temp_file.name
