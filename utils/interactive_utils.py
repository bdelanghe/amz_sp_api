# Public functions to be exported when using `from module import *`
__all__ = [
    'prompt_confirmation',
    'print_config',
    'print_dry_run_report',
    'print_error',
    'print_info',
    'print_warning'
]

# Constants for suffixes and colors with actual ANSI codes
SOURCE_COLORS = {
    'config': '\033[96m',   # cyan
    'env': '\033[93m',      # yellow
    'git': '\033[94m',      # blue
    'GitHub': '\033[95m',   # magenta
    'unknown': '\033[92m'   # green 
}

# ANSI escape codes for text styles
TEXT_STYLES = {
    'bold': '\033[1m',
    'end': '\033[0m'
}

# Public methods

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

def print_config(config: dict, source_info: dict) -> None:
    """
    Print the configuration information with appropriate formatting.

    Args:
        config: Dictionary containing the configuration values.
        source_info: Dictionary containing the source of each configuration value.
    """
    _print_section_title("Configuration Information")

    for key, value in config.items():
        formatted_key = _format_key_value_pair(key, value, source_info)
        _print_colored(formatted_key, color=None, indent=2)

def print_dry_run_report(report: dict) -> None:
    """
    Print the dry-run report based on the provided JSON dictionary.

    Args:
        report: A dictionary summarizing the changes for dry-run purposes.
    """
    # Print the summary at the top
    _print_section_title("SDK Upgrade Summary")

    # Extract summaries
    added_models = report["sdk_upgrade_summary"]["added"]
    updated_models = report["sdk_upgrade_summary"]["updated"]
    removed_models = report["sdk_upgrade_summary"]["removed"]

    # Print summaries using a helper
    _print_summary_section("Added Models", added_models, 'green')
    _print_summary_section("Updated Models", updated_models, 'yellow')
    _print_summary_section("Removed Models", removed_models, 'red')

    # Gem version summary
    _print_colored(f"Gem Version: {report['gem_version']}", color='\033[96m')

    # Print detailed information for added, updated, and removed models
    _print_detailed_model_section("New Models Added", added_models, 'green')
    _print_detailed_model_section("Models Updated", updated_models, 'yellow', True)
    _print_detailed_model_section("Models Removed", removed_models, 'red', True)

def print_error(message: str) -> None:
    """
    Print an error message in red.

    Args:
        message: The error message to display.
    """
    _print_colored(f"Error: {message}", color='red')

def print_info(message: str) -> None:
    """
    Print an info message in blue.

    Args:
        message: The info message to display.
    """
    _print_colored(message, color='blue')

def print_warning(message: str) -> None:
    """
    Print a warning message in yellow.

    Args:
        message: The warning message to display.
    """
    _print_colored(f"Warning: {message}", color='yellow')

# Private methods

def _print_colored(message: str, color: str | None = None, newline: bool = True, indent: int = 0) -> None:
    """
    Print the message in color with optional indentation.
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
    end_color = TEXT_STYLES['end']
    indented_message = ' ' * indent + message
    colored_message = f"{colors.get(color, '')}{indented_message}{end_color}" if color else indented_message
    
    if newline:
        print(colored_message)
    else:
        print(colored_message, end='')

def _print_section_title(title: str, color: str = '\033[96m', underline: str = '=') -> None:
    """
    Print a section title with an underline for clarity.
    """
    _print_colored(f"\n{title}", color=color)
    _print_colored(underline * len(title), color=color)

def _print_summary_section(title: str, items: list, color: str) -> None:
    """
    Helper function to print the summary section.
    """
    count = len(items)
    if count:
        _print_colored(f"{title}: {count}", color=color)
    else:
        _print_colored(f"No {title}.", color=color)

def _print_detailed_model_section(title: str, models: list, color: str, show_version: bool = False) -> None:
    """
    Helper function to print detailed information for models in a section.
    """
    if models:
        _print_colored(f"\n{title}:", color=color)
        for model in models:
            version_str = f" v{model['version']}" if show_version else ""
            _print_colored(f"  {model['api_name']}{version_str}", color='white', indent=2)

def _format_key_value_pair(key: str, value: str, source_info: dict) -> str:
    """
    Format key-value pairs with color and source information.
    """
    source = source_info.get(key, 'unknown')
    source_color = SOURCE_COLORS.get(source)

    # Bold the key for better readability
    formatted_key = f"{_bold_text(key)}: {value}"
    formatted_key += f" {_colored_source(source, source_color)}"

    return formatted_key

def _bold_text(text: str) -> str:
    """
    Make the given text bold.
    """
    return f"{TEXT_STYLES['bold']}{text}{TEXT_STYLES['end']}"

def _colored_source(source: str, color_code: str) -> str:
    """
    Format source strings with color.
    """
    return f"{color_code}{source}{TEXT_STYLES['end']}"
