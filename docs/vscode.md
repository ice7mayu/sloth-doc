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
      "label": "clear",
      "type": "shell",
      "command": "./bin/clear.sh",
      "group": "test",
      "problemMatcher": []
    },
    {
      "label": "cov",
      "type": "shell",
      "command": "source .venv/bin/activate && bin/cov.sh && deactivate",
      "group": "test",
      "problemMatcher": []
    },
    {
      "label": "allure-report",
      "type": "shell",
      "command": "./bin/allure-report.sh",
      "group": "test",
      "problemMatcher": []
    }
  ]
}
```
