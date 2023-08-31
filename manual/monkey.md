# Monkey Test

## 执行脚本

进入zwatch项目robust目录

```bash
cd zwatch/robust
```

执行 `run-monkey-watch.sh`:

```bash
./run-monkey-watch.sh <UDID> <EVENTS=20> <BATCHES=2>
```

例如: 在*601012203010000800*设备上发送*500*个事件(单个case), 重复执行*10*个批次. 可执行以下脚本:

```bash
caffeinate ./run-monkey.sh 601012203010000800 500 10
```

其中`caffeinate`工具用于阻止Mac电脑进入休眠.

或者后台执行:

```bash
nohup ./run-monkey.sh 601012203010000800 500 10 > 601012203010000800.log &
```

## 停止脚本

先中断`run-monkey.sh`进程, 然后执行:

```bash
./stop-monkey.sh <UDID>
```

## 导入结果

Monkey 脚本的执行结果和crash日志, 按执行日期分批次存储在**robust/log**目录下.

进入项目根目录:

```bash
cd zwatch
```

编辑 *tests/test_monkey.py*, 修改`test_insert_watch_crash`中的执行日期.

例如, 执行日期为**2022-11-14**:

```python
def test_insert_watch_crash():
    top = "robust/log/watch-2022-11-14"
    epoch = _extract_epoch_date(top)
    crashes = WatchMonkeyCrash.collect_crash(top)
    _insert_crash(crashes=crashes, epoch=epoch)
```

执行完毕后, 撤销对`test_monkey.py`的修改:

```bash
git restore tests/test_monkey.py
```

查看monkey结果

<http://192.168.237.161:89/#/monkeydata>

Done
