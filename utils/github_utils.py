# utils/github_utils.py

import subprocess

def get_github_repo_url() -> str | None:
    """
    Get the GitHub repository URL using git.

    Returns:
        The GitHub repository URL, or None if not found.
    """
    try:
        url = subprocess.check_output(['git', 'config', '--get', 'remote.origin.url']).decode('utf-8').strip()
        if url.startswith('git@'):
            url = url.replace(':', '/')
            url = url.replace('git@', 'https://')
        return url.rstrip('.git')
    except subprocess.CalledProcessError:
        return None

def get_github_repo_description() -> str | None:
    """
    Get the GitHub repository description using gh CLI.

    Returns:
        The GitHub repository description, or None if not found.
    """
    try:
        return subprocess.check_output(
            ['gh', 'repo', 'view', '--json', 'description', '--jq', '.description']
        ).decode('utf-8').strip()
    except (subprocess.CalledProcessError, FileNotFoundError):
        return None

def is_no_reply_email(email: str) -> bool:
    """
    Check if the email is a GitHub no-reply email.

    Args:
        email (str): The email address to check.

    Returns:
        bool: True if it's a no-reply email, False otherwise.
    """
    return 'noreply' in email
