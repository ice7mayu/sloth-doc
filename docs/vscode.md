# Setup VSCode

## Tasks

Add below content to **.vscode/tasks.json** then **Command Palette** -> **Run Test Task**.

```json title='.vscode/tasks.json'
{
  // See https://go.microsoft.com/fwlink/?LinkId=733558
  // for the documentation about the tasks.json format
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Coverage",
      "type": "shell",
      "command": "source .venv/bin/activate && coverage run; coverage html && deactivate",
      "group": "test"
    },
    {
      "label": "Format",
      "type": "shell",
      "command": "source .venv/bin/activate && black sloth tests; isort sloth tests && deactivate",
      "group": "test"
    },
    {
      "label": "Clear",
      "type": "shell",
      "command": "bin/clear.sh",
      "group": "test"
    },
    {
      "label": "Allure",
      "type": "shell",
      "command": "allure serve output/allure-results",
      "group": "test"
    },
  ]
}
```
