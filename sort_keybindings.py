################################################################################
###                      File Name: sort_keybindings.py                      ###
###                          Author: Huaxiao Liang                           ###
###                         Mail: 1184903633@qq.com                          ###
###                         01/28/2025-Tue-22:36:51                          ###
################################################################################

import json


def load_json(file_path):
    """Load JSON data from a file."""
    try:
        with open(file_path, 'r') as file:
            data = json.load(file)
        return data
    except json.JSONDecodeError as e:
        print(f"Error decoding JSON: {e}")
        return None
    except FileNotFoundError as e:
        print(f"File not found: {e}")
        return None


def save_json(file_path, data):
    """Save sorted JSON data back to the file."""
    try:
        with open(file_path, 'w') as file:
            json.dump(data, file, indent=4)
        print(f"File sorted successfully and saved to {file_path}")
    except Exception as e:
        print(f"Error saving file: {e}")


def sort_keybindings(data):
    """Sort the JSON data by the 'key' field."""
    return sorted(data, key=lambda x: x.get("key", ""))


def main():
    file_path = "/home/banana/wsl_shared_folder/configuration_file/keybindings.json"

    # Step 1: Load JSON data
    data = load_json(file_path)

    if data is None:
        print("Failed to load data. Exiting...")
        return

    # Step 2: Sort the data by the 'key' field
    sorted_data = sort_keybindings(data)

    # Step 3: Save the sorted data back to the file
    save_json(file_path, sorted_data)


if __name__ == "__main__":
    main()
