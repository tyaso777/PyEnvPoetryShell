# PyEnvPoetryShell
Tailored for developers in authenticated proxy environments, this tool optimizes Python project setup and dependency handling using pyenv and poetry, complete with VSCode settings for a seamless development process.

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

To initialize a new project, simply run the `Execute-PsScript.bat` file. Upon execution, a popup will appear, from which you should select `Initialize-PoetryProject.ps1`. This will perform the necessary steps to initialize your project.

## Upcoming Features

There are several additional features planned for future updates:

1. **Poetry Environment Setup**:
   The ability to set up an existing project environment using `poetry install`. This feature will streamline the process of configuring the necessary dependencies and settings for existing projects.

2. **Enhanced Poetry Command Support**:
   Support for executing various poetry commands in the context of existing projects. This will provide users with more flexibility and control over their Poetry-managed Python projects.

## Note on Proxy Settings

Please note that while the current version does not include configurations for working behind a proxy, this is a high-priority update and will be implemented shortly. Stay tuned for these improvements, aimed at enhancing usability for users in restricted network environments.
