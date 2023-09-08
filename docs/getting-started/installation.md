# 搭建环境

系统开发环境

- Python 3.10
- Poetry
- Android SDK
- Open JDK
- Appium Inspector
- Allure Report plugin

进入到项目根目录安装项目依赖:

```shell
poetry install --no-root
```

安装 Git 检查工具:

```shell
poetry run pre-commit install
```

配置 VSCode 编辑器:

```json
{
  "files.eol": "\n",
  "files.autoSave": "afterDelay",
  "files.exclude": {
    "**/.pytest_cache": true,
    "**/.mypy_cache": true,
    "**/__pycache__": true,
  },
  "python.testing.pytestEnabled": true,
  "[python]": {
    "editor.defaultFormatter": "ms-python.python",
    "editor.formatOnType": true
  },
}
```

设置默认启动 `.venv` 虚拟环境:

打开 VSCode 命令板, 输入 **Python: Select Interpretor**, 选择: `./.venv/bin/python`.
启动内置终端后默认自动激活项目虚拟环境.

至此环境配置完成.
