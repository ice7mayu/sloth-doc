# Monkey Test

## 执行脚本

进入tanyang项目robust目录

```shell
cd tanyang/robust
```

执行 `run-monkey.sh`:

```shell
./run-monkey.sh <UDID> <EVENTS=20> <BATCHES=2>
```

例如: 在*601012203010000800*设备上发送*500*个事件(单个case), 重复执行*10*个批次. 可执行以下脚本:

```shell
caffeinate ./run-monkey.sh 601012203010000800 500 10
```

其中`caffeinate`工具用于阻止Mac电脑进入休眠.

或者后台执行:

```shell
nohup ./run-monkey.sh 601012203010000800 500 10 > 601012203010000800.log &
```

## 停止脚本

先中断`run-monkey.sh`进程, 然后执行:

```shell
./stop-monkey.sh <UDID>
```

## 导入结果

Monkey 脚本的执行结果和crash日志, 按执行日期分批次存储在**robust/log**目录下.

进入tanyang项目目录:

```shell
cd tanyang
```

编辑 *tests/test_monkey.py*, 修改`get_batch_date`中的执行日期. 例如, 执行日期为**2022-08-31**:

```python
@pytest.fixture(scope="module", name="batch_date")
def get_batch_date():
    return "2022-08-31"
```

先导入Crash日志:

```shell
poetry run pytest tests/test_monkey.py::test_insert_crash_detail
```

手动刷新数据统计页面, 确保能看到当天的结果

<http://192.168.237.161:89/#/monkeydata>

再统计Crash发生的概率:

```shell
poetry run pytest tests/test_monkey.py::test_insert_crash_rate
```

撤销对`get_batch_date`的修改:

```shell
git restore tests/test_monkey.py
```

## Monkey Usage

```text
usage: monkey [-p ALLOWED_PACKAGE [-p ALLOWED_PACKAGE] ...]
              [-c MAIN_CATEGORY [-c MAIN_CATEGORY] ...]
              [--ignore-crashes] [--ignore-timeouts]
              [--ignore-security-exceptions]
              [--monitor-native-crashes] [--ignore-native-crashes]
              [--kill-process-after-error] [--hprof]
              [--match-description TEXT]
              [--pct-touch PERCENT] [--pct-motion PERCENT]
              [--pct-trackball PERCENT] [--pct-syskeys PERCENT]
              [--pct-nav PERCENT] [--pct-majornav PERCENT]
              [--pct-appswitch PERCENT] [--pct-flip PERCENT]
              [--pct-anyevent PERCENT] [--pct-pinchzoom PERCENT]
              [--pct-permission PERCENT]
              [--pkg-blacklist-file PACKAGE_BLACKLIST_FILE]
              [--pkg-whitelist-file PACKAGE_WHITELIST_FILE]
              [--wait-dbg] [--dbg-no-events]
              [--setup scriptfile] [-f scriptfile [-f scriptfile] ...]
              [--port port]
              [-s SEED] [-v [-v] ...]
              [--throttle MILLISEC] [--randomize-throttle]
              [--profile-wait MILLISEC]
              [--device-sleep-time MILLISEC]
              [--randomize-script]
              [--script-log]
              [--bugreport]
              [--periodic-bugreport]
              [--permission-target-system]
              COUNT
```
