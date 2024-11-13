import json

# Public functions to be exported when using `from module import *`
__all__ = [
    'prompt_confirmation',
    'print_config',
    'print_error',
    'print_info',
    'print_warning',
    'print_model_overview'
]

# ANSI escape codes for colors and text styles
SOURCE_COLORS = {
    'config': '\033[96m',  # cyan
    'env': '\033[93m',     # yellow
    'git': '\033[94m',     # blue
    'GitHub': '\033[95m',  # magenta
    'unknown': '\033[92m'  # green
}

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
        print(json.dumps(config, indent=2))
    else:
        _print_header("Configuration Information")
        for key, entry in config.items():
            value = entry['value']
            source = entry['source']
            formatted_entry = _format_config_entry(key, value, source)
            _print_colored(formatted_entry, color=None, indent=2)
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
        _print_header("Model Overview", indent=indent)
        _print_colored(_format_config_entry("Total APIs", overview['total_apis']), color='cyan', indent=indent)

        if overview['duplicates']:
            _print_colored("Duplicates found:", color='red', indent=indent)
            for duplicate in overview['duplicates']:
                _print_colored(
                    f"API: {duplicate['api_name']} - Duplicate version: V{duplicate['duplicate_version']} - Files: {', '.join(duplicate['file_names'])}",
                    color='yellow',
                    indent=indent + 2
                )

        for api_name, api_details in overview["api_details"].items():
            _print_colored(_format_config_entry("API Name", api_name), color='cyan', indent=indent)

            for version, version_info in api_details["versions"].items():
                # Colorize the version number based on the "is_latest" flag
                is_latest_color = 'green' if version_info['is_latest'] else 'red'
                _print_colored(_format_config_entry("Version", f"V{version}"), color=is_latest_color, indent=indent + 4)
                _print_colored(_format_config_entry("File", version_info['api_file']), color='white', indent=indent + 6)

                # No colors for these details, but keys are bold
                _print_colored(_format_config_entry("Generated Gem Name", version_info['gem_name']), color=None, indent=indent + 6)
                _print_colored(_format_config_entry("Module Name", version_info['module_name']), color=None, indent=indent + 6)
                _print_colored(_format_config_entry("Library Directory", version_info['lib_dir']), color='white', indent=indent + 6)
                _print_colored(_format_config_entry("Config Path", version_info['config_path']), color='white', indent=indent + 6)

def print_error(message: str) -> None:
    """Print an error message in red."""
    _print_colored(f"Error: {message}", color='red')

def print_info(message: str) -> None:
    """Print an info message in blue."""
    _print_colored(message, color='blue')

def print_warning(message: str) -> None:
    """Print a warning message in yellow."""
    _print_colored(f"Warning: {message}", color='yellow')

# Private methods

def _print_colored(message: str, color: str | None = None, newline: bool = True, indent: int = 0) -> None:
    """
    Print a message in color with optional indentation.
    
    Args:
        message: The message to print.
        color: The color code to use.
        newline: Whether to print a newline at the end.
        indent: Number of spaces to indent the printed output.
    """
    colors = _get_color_codes()
    end_color = TEXT_STYLES['end']
    indented_message = ' ' * indent + message
    colored_message = f"{colors.get(color, '')}{indented_message}{end_color}" if color else indented_message

    print(colored_message, end='' if not newline else '\n')

def _print_header(title: str, color: str = '\033[96m', underline_char: str = '=', indent: int = 0) -> None:
    """
    Print a header with an underline for better visibility.
    
    Args:
        title: The title text.
        color: The color code for the title.
        underline_char: The character to use for the underline.
        indent: Number of spaces to indent the printed output.
    """
    _print_colored(title, color=color, indent=indent)
    _print_colored(underline_char * len(title), color=color, indent=indent)

def _format_config_entry(key: str, value: str, source: str | None = None) -> str:
    """
    Format a key-value pair for output with optional source information.

    Args:
        key: The key to format.
        value: The value associated with the key.
        source: The source of the value (optional).

    Returns:
        str: The formatted key-value pair string.
    """
    formatted_key = _make_bold(key)
    if source:
        source_color = SOURCE_COLORS.get(source, SOURCE_COLORS['unknown'])
        return f"{formatted_key}: {value} {_format_source(source, source_color)}"
    else:
        return f"{formatted_key}: {value}"

def _make_bold(text: str) -> str:
    """Return the text formatted in bold."""
    return f"{TEXT_STYLES['bold']}{text}{TEXT_STYLES['end']}"

def _format_source(source: str, color_code: str) -> str:
    """Return a formatted source string with the specified color."""
    return f"{color_code}{source}{TEXT_STYLES['end']}"

def _get_color_codes() -> dict[str, str]:
    """Return a dictionary of color codes for formatting."""
    return {
        'red': '\033[91m',
        'green': '\033[92m',
        'yellow': '\033[93m',
        'blue': '\033[94m',
        'magenta': '\033[95m',
        'cyan': '\033[96m',
        'white': '\033[97m'
    }
