import json

def print_colored(message: str, color: str | None = None, newline: bool = True) -> None:
    """
    Print the message in color if the color argument is provided.

    Args:
        message: The message to print.
        color: The color for the text (e.g., 'red', 'green', 'blue').
        newline: Whether to print a new line after the message. Default is True.
    """
    colors = {
        'red': '\033[91m',
        'green': '\033[92m',
        'yellow': '\033[93m',
        'blue': '\033[94m',
        'magenta': '\033[95m',
        'cyan': '\033[96m',
        'white': '\033[97m'
    }
    end_color = '\033[0m'
    colored_message = f"{colors[color]}{message}{end_color}" if color in colors else message
    
    if newline:
        print(colored_message)
    else:
        print(colored_message, end='')


def prompt_confirmation(message: str) -> bool:
    """
    Prompt the user for confirmation.

    Args:
        message: The message to display.

    Returns:
        True if the user confirms, False otherwise.
    """
    while True:
        response = input(f"{message} [y/n]: ").lower()
        if response in ('y', 'yes'):
            return True
        elif response in ('n', 'no'):
            return False

def print_dry_run_report(report: dict) -> None:
    """
    Print the dry-run report based on the provided JSON dictionary.

    Args:
        report: A dictionary summarizing the changes for dry-run purposes.
    """
    print_colored("\nConfiguration Information:", color='cyan')
    for key, value in report["config_info"].items():
        print_colored(f"  {key}: {value}", color='white')

    print_colored("\nSDK Upgrade Summary", color='cyan')
    print_colored("===================", color='cyan')

    if report["sdk_upgrade_summary"]["added"]:
        print_colored("\nNew Models Added:", color='green')
        for model in report["sdk_upgrade_summary"]["added"]:
            print_colored(f"  - API Name: {model['api_name']}, Version: {model['version']}", color='white')
        print_colored(f"Total New Models: {len(report['sdk_upgrade_summary']['added'])}", color='green')
    else:
        print_colored("\nNo New Models Added.", color='green')

    if report["sdk_upgrade_summary"]["updated"]:
        print_colored("\nModels Updated:", color='yellow')
        for model in report["sdk_upgrade_summary"]["updated"]:
            print_colored(f"  - {model['api_name']} Updated to Version {model['version']}", color='white')
        print_colored(f"Total Updated Models: {len(report['sdk_upgrade_summary']['updated'])}", color='yellow')
    else:
        print_colored("\nNo Models Updated.", color='yellow')

    if report["sdk_upgrade_summary"]["removed"]:
        print_colored("\nModels Removed:", color='red')
        for model in report["sdk_upgrade_summary"]["removed"]:
            print_colored(f"  - {model['api_name']} Version {model['version']}", color='white')
        print_colored(f"Total Removed Models: {len(report['sdk_upgrade_summary']['removed'])}", color='red')
    else:
        print_colored("\nNo Models Removed.", color='red')

    print_colored(f"\nGem Version: {report['gem_version']}", color='cyan')
