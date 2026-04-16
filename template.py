import os

# Root folder name (optional — current directory তেও করতে পারো)
ROOT = "project"

# Folder structure
folders = [
    "scripts"
]

# Files inside scripts
script_files = [
    "mobile_tools.sh",
    "setup_shizuku.sh"
]

# Root level files
root_files = [
    "README.md",
    "pc_push_install.ps1",
    "termux_setup.sh",
    "windows_setup.bat"
]


def create_structure():
    # Create root folder
    if not os.path.exists(ROOT):
        os.makedirs(ROOT)

    # Create folders
    for folder in folders:
        path = os.path.join(ROOT, folder)
        os.makedirs(path, exist_ok=True)

    # Create files inside scripts/
    for file in script_files:
        file_path = os.path.join(ROOT, "scripts", file)
        with open(file_path, "w") as f:
            f.write("")  # empty file

    # Create root files
    for file in root_files:
        file_path = os.path.join(ROOT, file)
        with open(file_path, "w") as f:
            f.write("")

    print("✅ Project structure created successfully!")


if __name__ == "__main__":
    create_structure()