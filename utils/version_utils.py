# utils/version_utils.py

import re
import subprocess

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
            # Sort tags based on semantic versioning
            version_tags.sort(key=lambda s: list(map(int, re.findall(r'\d+', s))))
            return version_tags[-1]
        return None
    except subprocess.CalledProcessError:
        return None

def increment_version(current_version: str, prerelease_label: str | None = None) -> str:
    """
    Increment the version number.

    Args:
        current_version: The current version string.
        prerelease_label: The prerelease label (e.g., 'alpha', 'beta').

    Returns:
        The next version string.
    """
    match = re.match(r'^(\d+)\.(\d+)\.(\d+)(?:-(\w+)(?:\.(\d+))?)?$', current_version)
    if not match:
        raise ValueError(f"Invalid version format: {current_version}")
    
    major, minor, patch, label, pre_num = match.groups()
    major, minor, patch = int(major), int(minor), int(patch)
    pre_num = int(pre_num) if pre_num else 0

    if prerelease_label:
        # Increment prerelease version if applicable
        if label == prerelease_label:
            pre_num += 1
        else:
            pre_num = 1
        return f"{major}.{minor}.{patch}-{prerelease_label}.{pre_num}"
    else:
        # Increment patch version
        patch += 1
        return f"{major}.{minor}.{patch}"
