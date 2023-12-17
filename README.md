# PyEnvPoetryShell
Tailored for developers in authenticated proxy environments, especially those in Japan using Windows PCs, this tool optimizes Python project setup and dependency handling using pyenv and poetry, complete with VSCode settings for a seamless development process.

## Required Extensions for Visual Studio Code

To fully utilize the development environment and ensure code consistency and quality, the following extensions for Visual Studio Code (VSCode) are recommended:

- **Python**: The official extension for Python, providing rich support for the Python language, including features such as IntelliSense, linting, debugging, and more.

- **Black Formatter**: An extension that integrates the Black formatter into VSCode, automatically formatting Python code to conform to the Black code style guidelines.

- **Flake8**: This extension integrates Flake8 into VSCode, providing Python code linting to catch coding errors, enforce coding standards, and more.

- **isort**: isort is a Python utility to sort imports alphabetically and automatically separates them into sections. It provides a seamless way to organize imports in your Python files.

- **Jupyter**: An extension for interactive data science and scientific computing, enabling the creation and editing of Jupyter Notebooks within VSCode.

- **Mypy**: Integrates the Mypy static type checker into VSCode. Mypy can check your Python code for type errors, aiding in maintaining a clean and error-free codebase.

- **Pylance**: Pylance supercharges your Python IntelliSense experience with rich type information, auto-imports, type checking, and much more.

Please ensure these extensions are installed in your VSCode environment to take advantage of their features.

## Basic Usage

1. Initialize a New Project:
   - Run 'Execute-PsScript.bat'.
   - Select 'Initialize-PoetryProject.ps1' from the popup.
   - This script initializes your project.

2. Enhanced Poetry Command Support:
   - Execute various poetry commands via 'Prepare-PoetryCommands.ps1'.
   - Run this script by selecting it after running 'Execute-PsScript.bat'.
   - Provides flexibility and control over Poetry-managed Python projects.

## Upcoming Features

1. Poetry Environment Setup:
   - Upcoming feature to setup environment using 'poetry install'.
   - Streamlines configuring dependencies and settings for existing projects.

