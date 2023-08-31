# Sloth Project Structure

This page provides an overview of the file and folder structure of sloth test project.
It covers top-level files and folders with descriptions.

## Top-level folders

| Folder Name   | Description  |
|---|---|
| `sloth`  | Sloth core modules  |
| `pom`  | Page object modules  |
| `task`  | Screenplay tasks  |
| `lib`  | Common modules and helper functions  |
| `tests`  | All test cases  |
| `data`  | Stores test data in YAML format  |
| `bin`  | Shell scripts  |
| `output`  | Artifact and report output direcotry  |
| `temp`  | The temp direcotry  |

## Top-level files

| File Name   | Description  |
|---|---|
| `pyproject.toml`  | Poetry project management file  |
| `conftest.py`  | Pytest global test config file  |
| `pytest.ini`  | Pytest CLI config file  |
| `run.py`  | Sloth runner entry point  |
| `sloth.yaml`  | Sloth config file  |
| `.pre-commit-config.yaml`  | Git pre commit hooks & linters  |
