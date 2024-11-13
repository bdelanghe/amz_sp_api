import json

# Public functions to be exported when using `from module import *`
__all__ = [
    'prompt_confirmation',
    'print_config',
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

def print_config(config: dict, format_type: str = 'pretty') -> None:
    """
    Print the configuration information with appropriate formatting or as JSON.

    Args:
        config: Dictionary containing the configuration values and their sources.
        format_type: The format in which to print the output ('pretty' or 'json').
    """
    if format_type == 'json':
        # Print as JSON, including both value and source
        print(json.dumps(config, indent=2))
    else:
        _print_section_title("Configuration Information")
        for key, entry in config.items():
            value = entry['value']
            source = entry['source']
            formatted_key = _format_key_value_pair(key, value, source)
            _print_colored(formatted_key, color=None, indent=2)

def print_model_overview(overview: dict, format_type: str = 'pretty', indent: int = 0) -> None:
    """
    Print a detailed model overview in a readable format or as JSON.

    Args:
        overview: The overview dictionary containing model details.
        format_type: The format in which to print the output ('pretty' or 'json').
        indent: Number of spaces to indent the printed output.
    """
    if format_type == 'json':
        print(json.dumps(overview, indent=2))
    else:
        _print_section_title("Model Overview", indent=indent)
        _print_colored(f"Total APIs: {overview['total_apis']}", color='cyan', indent=indent)

        if overview['duplicates']:
            _print_colored("Duplicates found:", color='red', indent=indent)
            for duplicate in overview['duplicates']:
                _print_colored(
                    f"  API: {duplicate['api_name']} - Duplicate version: V{duplicate['duplicate_version']} - Files: {', '.join(duplicate['file_names'])}",
                    color='yellow',
                    indent=indent + 2
                )

        for api in overview["api_details"]:
            _print_colored(f"\nAPI Name: {api['api_name']}", color='green', indent=indent)
            _print_colored(f"  File count: {api['file_count']}", color='white', indent=indent + 2)
            for version_info in api["versions"]:
                _print_colored(f"    Version: V{version_info['version']} - File: {version_info['file_name']}", color='white', indent=indent + 4)
                if version_info['params']:
                    _print_colored(f"      Params: {', '.join(version_info['params'])}", color='white', indent=indent + 6)
                else:
                    _print_colored("      Params: None", color='white', indent=indent + 6)

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

    Args:
        title: Title of the section.
        models: List of models to print details for.
        color: Color to use for printing.
        show_version: Whether to display the model version.
    """
    if models:
        _print_colored(f"\n{title}:", color=color)
        for model in models:
            version_str = f" (V{model.get('version', 'N/A')})" if show_version else ""
            _print_colored(f"  {model['api_name']}{version_str}", color='white', indent=2)

def _format_key_value_pair(key: str, value: str, source: str) -> str:
    """
    Format key-value pairs with color and source information.

    Args:
        key: The key to format.
        value: The value associated with the key.
        source: The source of the value.

    Returns:
        str: The formatted key-value pair string.
    """
    source_color = SOURCE_COLORS.get(source, SOURCE_COLORS['unknown'])

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
