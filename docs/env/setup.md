# 智能硬件UI自动化

## 配置项目环境

1. [Homebrew](https://brew.sh) - Mac 包管理工具
2. [Git](https://git-scm.com) - 代码版本管理
3. [Python 3.10.2](https://www.python.org) - 项目的运行环境
4. [Poetry](https://python-poetry.org) - Python 项目管理工具
5. [Open JDK 17.0](https://openjdk.java.net) - Allure Report 依赖的 Java 运行环境
6. [Allure Report](https://docs.qameta.io/allure/) - 测试报告插件
7. [Android SDK](https://developer.android.com) - Android 开发环境
8. [Appium Inspector](https://github.com/appium/appium-inspector/releases) - Appium 元素查看器

2 ~ 6 可以通过 Homebrew 安装.

```shell
brew install git
brew install python@3.10
brew install poetry
brew install openjdk
brew install allure
brew install node
```

安装 Appium Server:

```shell
npm install -g appium
```

## 安装项目依赖

修改 [poetry][poetry-venv-in-project] 虚拟环境目录配置项:

```shell
poetry config virtualenvs.in-project true
```

此项配置生效后, poetry 会在项目的根目录下创建虚拟环境 `.venv` 目录.

进入项目根目录并安装项目依赖, 例如: zwatch 项目

```shell
cd zwatch && poetry install --no-root
```

安装 git 提交检查工具:

```shell
poetry run pre-commit install
```

## 配置 VSCode

安装 VSCode 插件

```bash
code --install-extension aaron-bond.better-comments
code --install-extension alefragnani.Bookmarks
code --install-extension be5invis.toml
code --install-extension bungcip.better-toml
code --install-extension DavidAnson.vscode-markdownlint
code --install-extension eamodio.gitlens
code --install-extension emilast.LogFileHighlighter
code --install-extension foxundermoon.shell-format
code --install-extension Gruntfuggly.todo-tree
code --install-extension mhutchie.git-graph
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension njpwerner.autodocstring
code --install-extension ritwickdey.LiveServer
code --install-extension shd101wyy.markdown-preview-enhanced
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension vscode-icons-team.vscode-icons
code --install-extension yzane.markdown-pdf
code --install-extension yzhang.markdown-all-in-one
```

添加 User Setting:

```json
{
    "cSpell.enabled": true,
    "files.eol": "\n",
    "files.autoSave": "afterDelay",
    "editor.bracketPairColorization.enabled": true,
    "output.smartScroll.enabled": false,
    "security.workspace.trust.untrustedFiles": "open",
    "workbench.iconTheme": "vscode-icons",
    "[python]": {
        "editor.defaultFormatter": "ms-python.python"
    },
    "files.exclude": {
        "**/__pycache__": true,
        "**/.pytest_cache": true
    },
    "python.testing.pytestEnabled": true,
    "python.formatting.provider": "black",
    "python.linting.flake8Enabled": true,
    "python.linting.mypyEnabled": true,
    "python.linting.pylintEnabled": true,
    "markdown-preview-enhanced.previewTheme": "one-dark.css",
    "[markdown]": {
        "editor.defaultFormatter": "yzhang.markdown-all-in-one"
    }
}
```

## 配置Python解释器

使用 VSCode 打开项目, 调出命令板(快捷键 `cmd+shift+p`).

搜索 **Python: Select Interpreter**. 选择当前目录下的虚拟环境 `./.venv/bin/python`

## 项目结构

- **data** - 数据文件目录
- **lib** - 基础类库
- **pom** - POM相关模块
- **task** - 任务模块
- **tests** - 测试用例目录
- **output** - 报告, 结果等输出目录

[poetry-venv-in-project]: https://python-poetry.org/docs/configuration/#virtualenvsin-project

## 升级依赖

执行以下步骤为碳氧项目升级 `sloth` 框架:

从 `main` 分支获取最新的代码

```shell
git checkout main && git pull
```

升级框架

```shell
poetry update sloth
```

## 执行测试用例

执行碳氧App登录模块所有测试用例:

```bash
poetry run python run.py tests/test_login.py
```

执行碳氧App登录模块中学生模式登录测试用例(单条):

```bash
poetry run python run.py tests/test_login.py::test_login_as_student
```

本地查看Allure报告

```bash
allure serve output/allure-results
```

上传Allure报告

```bash
poetry run python run.py --upload
```

## 编写用例分支流程

从最新的 `main` 分支创建自己的 `<feature>` 分支

```shell
git fetch --prune
git checkout main && git pull
git checkout -b <feature-branch>
poetry update sloth && poetry run pre-commit run --all-files
```

编写完用例后提交自己的 feature 分支到远程.

```shell
git push -u origin <feature-branch>
```

然后在 <https://git.zuoyebang.cc> 提交 Merge Request 到 `main` 分支

## 配置文件

框架执行时会加载 *sloth.yaml* 配置文件. 如果同时存在 *sloth.dev.yaml* 则会优先使用 *sloth.dev.yaml* 中的配置项.
其中 *sloth.dev.yaml* 中按需调整自己在编写用例时想要覆盖的配置项即可.
