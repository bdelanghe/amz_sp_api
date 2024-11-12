# utils/git_utils.py

import subprocess
import re

def get_git_config_value(key: str) -> str | None:
    """
    Get a value from git config.

    Args:
        key: The git config key.

    Returns:
        The value of the git config key, or None if not found.
    """
    try:
        return subprocess.check_output(['git', 'config', '--get', key]).decode('utf-8').strip()
    except subprocess.CalledProcessError:
        return None

def get_latest_git_tag() -> str | None:
    """
    Get the latest Git tag that matches semantic versioning.

    Returns:
        The latest Git tag, or None if no tags are found.
    """
    try:
        tags = subprocess.check_output(['git', 'tag']).decode('utf-8').strip().split('\n')
        version_tags = [tag for tag in tags if re.match(r'^v\d+\.\d+\.\d+(-\w+(\.\d+)?)?$', tag)]
        if version_tags:
            version_tags.sort(key=lambda s: list(map(int, re.findall(r'\d+', s))))
            return version_tags[-1]
        return None
    except subprocess.CalledProcessError:
        return None
