import os
import re
import json
from glob import glob

class Models:
    _instance = None

    def __new__(cls, models_directory: str, lib_directory: str, config_template_filename: str):
        if cls._instance is None:
            cls._instance = super(Models, cls).__new__(cls)
            cls._instance._initialize(models_directory, lib_directory, config_template_filename)
        return cls._instance

    def _initialize(self, models_directory: str, lib_directory: str, config_template_filename: str):
        self.models_directory = models_directory
        self.lib_directory = lib_directory
        self.config_template_filename = config_template_filename
        self.api_files = self._collect_api_files()
        self.overview, self.models_to_generate = self._generate_model_overview()

    def _collect_api_files(self) -> dict[str, list[str]]:
        json_file_paths = glob(os.path.join(self.models_directory, '**', '*.json'), recursive=True)
        api_files = {}
        for json_file_path in json_file_paths:
            api_name = self._extract_api_name_from_path(json_file_path)
            if api_name is not None:
                api_files.setdefault(api_name, []).append(json_file_path)
        return api_files

    def _generate_model_overview(self) -> tuple[dict, list[dict]]:
        overview = {
            "total_apis": len(self.api_files),
            "duplicates": [],
            "api_details": []
        }
        models_to_generate = []
        seen_versions = {}

        for api_name, api_file_list in self.api_files.items():
            module_name = self._extract_module_name(api_name)
            api_detail = {
                "api_name": api_name,
                "file_count": len(api_file_list),
                "versions": [],
                "processed_versions": set()
            }

            for api_file in api_file_list:
                file_name = os.path.basename(api_file)
                version = self._extract_version_from_filename(file_name)

                if version in api_detail["processed_versions"]:
                    overview["duplicates"].append({
                        "api_name": api_name,
                        "duplicate_version": version,
                        "file_names": [f for f in api_file_list if version in f]
                    })
                    continue

                if (api_name, version) in seen_versions:
                    overview["duplicates"].append({
                        "api_name": api_name,
                        "duplicate_version": version,
                        "file_names": [seen_versions[(api_name, version)], api_file]
                    })
                else:
                    seen_versions[(api_name, version)] = api_file

                api_detail["versions"].append({
                    "version": version,
                    "file_name": file_name
                })

                api_detail["processed_versions"].add(version)  # Keep as a set for internal use

                models_to_generate.append({
                    "api_file": api_file,
                    "gem_name": f"{api_name}_V{version}",
                    "module_name": f"AmzSpApi::{module_name}::V{version}",
                    "lib_dir": os.path.join(self.lib_directory, api_name, f"v{version}"),
                    "config_path": os.path.join(self.lib_directory, api_name, f"v{version}", self.config_template_filename),
                    "version": version,
                    "api_name": api_name,
                    "is_latest": False,
                    "has_multiple_versions": len(api_file_list) > 1
                })

            # Convert processed_versions set to a list for JSON serialization
            api_detail["processed_versions"] = list(api_detail["processed_versions"])
            overview["api_details"].append(api_detail)

        return overview, models_to_generate

    def _extract_api_name_from_path(self, file_path: str) -> str | None:
        path_parts = file_path.split(os.sep)
        if 'models' not in path_parts:
            return None
        models_index = path_parts.index('models')
        if models_index + 1 >= len(path_parts):
            return None
        return path_parts[models_index + 1]

    def _extract_module_name(self, api_name: str) -> str:
        return ''.join(word.capitalize() for word in re.split('[-_]', api_name))

    def _extract_version_from_filename(self, file_name: str) -> str:
        match_version = re.search(r'V(\d+)', file_name, re.IGNORECASE)
        if match_version:
            return match_version.group(1)
        match_date = re.search(r'(\d{4}-\d{2}-\d{2})', file_name)
        if match_date:
            return match_date.group(1).replace('-', '')
        return '0'

    def get_overview(self) -> dict:
        return self.overview
