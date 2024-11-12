# Constants for suffixes and colors
SUFFIXES = {
    'moduleName': "(set per model)",
    'gemVersion': "(dynamically set from latest Git tag)"
}
SOURCE_COLORS = {
    'config': 'cyan',
    'env': 'yellow',
    'git': 'blue',
    'GitHub': 'magenta'
}
SUFFIX_COLOR = 'magenta'

# ANSI escape codes for text styles
TEXT_STYLES = {
    'bold': '\033[1m',
    'end': '\033[0m'
}

def bold_text(text: str) -> str:
    """
    Make the given text bold.

    Args:
        text: The text to make bold.

    Returns:
        The formatted bold text.
    """
    return f"{TEXT_STYLES['bold']}{text}{TEXT_STYLES['end']}"

def print_colored(message: str, color: str | None = None, newline: bool = True, indent: int = 0) -> None:
    """
    Print the message in color if the color argument is provided, with optional indentation.

    Args:
        message: The message to print.
        color: The color for the text (e.g., 'red', 'green', 'blue').
        newline: Whether to print a new line after the message. Default is True.
        indent: Number of spaces to indent the message.
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
    indented_message = ' ' * indent + colored_message
    
    if newline:
        print(indented_message)
    else:
        print(indented_message, end='')

def print_section_title(title: str, color: str = 'cyan', underline: str = '=') -> None:
    """
    Print a section title with an underline for clarity.

    Args:
        title: The section title to print.
        color: The color for the title.
        underline: The character to use for underlining the title.
    """
    print_colored(f"\n{title}", color=color)
    print_colored(underline * len(title), color=color)

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
    print_section_title("Configuration Information")

    for key, value in config.items():
        formatted_key = format_key_value_pair(key, value, source_info)
        print_colored(formatted_key, color=None, indent=2)

def print_dry_run_report(report: dict) -> None:
    """
    Print the dry-run report based on the provided JSON dictionary.

    Args:
        report: A dictionary summarizing the changes for dry-run purposes.
    """
    # Print the summary at the top
    print_section_title("SDK Upgrade Summary")

    # Extract summaries
    added_models = report["sdk_upgrade_summary"]["added"]
    updated_models = report["sdk_upgrade_summary"]["updated"]
    removed_models = report["sdk_upgrade_summary"]["removed"]

    # Print summaries using a helper
    print_summary_section("Added Models", added_models, 'green')
    print_summary_section("Updated Models", updated_models, 'yellow')
    print_summary_section("Removed Models", removed_models, 'red')

    # Gem version summary
    print_colored(f"Gem Version: {report['gem_version']}", color='cyan')

    # Print detailed information for added, updated, and removed models
    print_detailed_model_section("New Models Added", added_models, 'green')
    print_detailed_model_section("Models Updated", updated_models, 'yellow', True)
    print_detailed_model_section("Models Removed", removed_models, 'red', True)

def print_summary_section(title: str, items: list, color: str) -> None:
    """
    Helper function to print the summary section.

    Args:
        title: Title of the summary section.
        items: List of items to summarize.
        color: Color to use for printing.
    """
    count = len(items)
    if count:
        print_colored(f"{title}: {count}", color=color)
    else:
        print_colored(f"No {title}.", color=color)

def print_detailed_model_section(title: str, models: list, color: str, show_version: bool = False) -> None:
    """
    Helper function to print detailed information for models in a section.

    Args:
        title: Title of the section.
        models: List of models to print details for.
        color: Color to use for printing.
        show_version: Whether to display the model version.
    """
    if models:
        print_colored(f"\n{title}:", color=color)
        for model in models:
            version_str = f" v{model['version']}" if show_version else ""
            print_colored(f"  {model['api_name']}{version_str}", color='white', indent=2)

def format_key_value_pair(key: str, value: str, source_info: dict) -> str:
    """
    Helper function to format key-value pairs for printing.

    Args:
        key: The key to format.
        value: The value associated with the key.
        source_info: Dictionary containing the source of each configuration value.

    Returns:
        A formatted string representing the key-value pair.
    """
    suffix = SUFFIXES.get(key, "")
    source = source_info.get(key, 'unknown')
    source_color = SOURCE_COLORS.get(source, 'white')

    # Bold the key for better readability
    formatted_key = f"{bold_text(key)}: {value}"

    # Append the suffix if it exists
    if suffix:
        formatted_key += f" {colored_suffix(suffix)}"

    # Append the source information
    formatted_key += f" {_colored_source(source, source_color)}"

    return formatted_key

def colored_suffix(suffix: str) -> str:
    """
    Helper function to format suffixes with a consistent color.

    Args:
        suffix: The suffix to color.

    Returns:
        A colored string representing the suffix.
    """
    return f"\033[95m{suffix}\033[0m"  # magenta color

def _colored_source(source: str, color: str) -> str:
    """
    Helper function to format source strings with a consistent color.

    Args:
        source: The source string to color.
        color: The color code to use for the source.

    Returns:
        A formatted and colored source string.
    """
    return f"\033[{color}m{source}{TEXT_STYLES['end']}"
