import os
import configparser
from collections import defaultdict

# Define a function to parse config.ini files
def parse_config(file_path):
    # Disable interpolation to avoid issues with placeholders like %(asctime)s
    config = configparser.ConfigParser(interpolation=None)
    config.read(file_path)
    entries = {}
    for section in config.sections():
        for key, value in config.items(section):
            entries[f"{section}.{key}"] = value
    return entries

# Define a function to compare entries
def analyze_configs(configs):
    all_keys = set(key for config in configs for key in config.keys())
    common_entries = {}
    unique_entries = defaultdict(list)

    for key in all_keys:
        values = [config.get(key) for config in configs]
        if all(value == values[0] for value in values if value is not None):
            common_entries[key] = values[0]
        else:
            for idx, value in enumerate(values):
                if value is not None:
                    unique_entries[key].append((idx, value))

    return common_entries, unique_entries

# Main script
if __name__ == "__main__":
    base_path = os.getcwd()
    config_files = []
    configs = []

    # Locate config.ini files
    for repo in os.listdir(base_path):
        repo_path = os.path.join(base_path, repo)
        if os.path.isdir(repo_path):
            config_path = os.path.join(repo_path, "config.ini")
            if os.path.isfile(config_path):
                config_files.append(config_path)

    # Parse config.ini files
    for file in config_files:
        configs.append(parse_config(file))

    # Analyze common and unique entries
    common_entries, unique_entries = analyze_configs(configs)

    # Output the results
    print("\nCommon Entries Across All Config Files:")
    for key, value in common_entries.items():
        print(f"{key} = {value}")

    print("\nUnique Entries:")
    for key, values in unique_entries.items():
        print(f"{key}:")
        for repo_idx, value in values:
            print(f"  Repo {config_files[repo_idx]}: {value}")
