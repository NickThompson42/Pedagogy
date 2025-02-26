#!/usr/bin/env python3
"""
rearrange_and_setup.py

Usage:
    1. Place this script inside the Pedagogy folder (the same level as 20190415_thompson_GradeCalculatorapp_FINAL.R).
    2. Run: python rearrange_and_setup.py
       (or make it executable: chmod +x rearrange_and_setup.py && ./rearrange_and_setup.py)

What it does:
    - Creates an "Archives" folder (if not present).
    - Moves the following files/folders into "Archives":
         * GradeCalculatorWebApp/ (and its contents)
         * 20190415_thompson_GradeCalculatorapp_FINAL.R
         * calcGrade.R
    - Creates a new folder "GradeCalculatorApp/" with a recommended Python file structure:
         GradeCalculatorApp/
           ├── app/
           │    ├── __init__.py
           │    ├── routes.py
           │    ├── models.py
           │    ├── grade_calculations/
           │    │    └── __init__.py
           │    └── ai_grading/
           │         └── __init__.py
           ├── templates/
           ├── static/
           ├── config.py
           ├── requirements.txt
           └── run.py
    - Optionally, you can place (or regenerate) README.Rmd or any other docs in the top-level as you wish.

"""
import os
import shutil

def main():
    # Name of the new Python folder
    new_app_folder = "GradeCalculatorApp"
    # Archives folder
    archives_folder = "Archives"

    # R-related files/folders we want to archive
    old_items = [
        "GradeCalculatorWebApp",
        "20190415_thompson_GradeCalculatorapp_FINAL.R",
        "calcGrade.R"
    ]

    # 1) Create Archives/ if not present
    if not os.path.exists(archives_folder):
        os.mkdir(archives_folder)
        print(f"Created folder: {archives_folder}")
    else:
        print(f"Folder '{archives_folder}' already exists. Proceeding...")

    # 2) Move old R items to Archives/
    for item in old_items:
        if os.path.exists(item):
            # Destination path
            dest_path = os.path.join(archives_folder, item)

            # If the item is already in Archives or if a name collision might occur, rename
            if os.path.exists(dest_path):
                base_name = os.path.basename(item)
                new_dest_path = os.path.join(
                    archives_folder,
                    f"{base_name}_old_{str(int(os.times()[4]))}"
                )
                print(f"'{dest_path}' already exists, renaming to '{new_dest_path}'...")
                dest_path = new_dest_path

            print(f"Moving '{item}' to '{dest_path}'...")
            shutil.move(item, dest_path)
        else:
            print(f"'{item}' not found, skipping move.")

    # 3) Create the new Python file structure
    if not os.path.exists(new_app_folder):
        os.mkdir(new_app_folder)
        print(f"Created new app folder: {new_app_folder}")
    else:
        print(f"Folder '{new_app_folder}' already exists, skipping creation.")

    # Subfolders under GradeCalculatorApp
    subfolders = [
        "app",
        "templates",
        "static"
    ]
    for sf in subfolders:
        sf_path = os.path.join(new_app_folder, sf)
        if not os.path.exists(sf_path):
            os.mkdir(sf_path)
            print(f"  Created subfolder: {sf_path}")

    # Nested subfolders under app
    deeper_subfolders = [
        os.path.join("app", "grade_calculations"),
        os.path.join("app", "ai_grading")
    ]
    for dsf in deeper_subfolders:
        dsf_path = os.path.join(new_app_folder, dsf)
        if not os.path.exists(dsf_path):
            os.mkdir(dsf_path)
            print(f"    Created nested subfolder: {dsf_path}")

    # Create placeholder files
    placeholder_files = [
        os.path.join(new_app_folder, "app", "__init__.py"),
        os.path.join(new_app_folder, "app", "routes.py"),
        os.path.join(new_app_folder, "app", "models.py"),
        os.path.join(new_app_folder, "config.py"),
        os.path.join(new_app_folder, "requirements.txt"),
        os.path.join(new_app_folder, "run.py"),
    ]
    for pf in placeholder_files:
        if not os.path.exists(pf):
            with open(pf, 'w') as f:
                f.write("# Placeholder\n")
            print(f"    Created placeholder file: {pf}")

    # Create __init__.py in the deeper subfolders
    subfolder_init = [
        os.path.join(new_app_folder, "app", "grade_calculations", "__init__.py"),
        os.path.join(new_app_folder, "app", "ai_grading", "__init__.py"),
    ]
    for sf_init in subfolder_init:
        if not os.path.exists(sf_init):
            with open(sf_init, 'w') as f:
                f.write("# Init for subpackage\n")
            print(f"    Created __init__.py: {sf_init}")

    print("\nAll done! Original R files are archived, and new Python structure is created.")

if __name__ == "__main__":
    main()
