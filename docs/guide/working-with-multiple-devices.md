# 连接多设备

`device` 模块提供了两种获取连接设备的方式:

1. `DevicePool`: 获取任意一个可用的连接设备.
2. `DeviceLoader`: 获取一个或多个(配置文件中)指定的连接设备.

使用 `DevicePool` 可以获取任意一个当前可用的(未执行测试用例)连接设备, 例如:

```python
from sloth.device import DevicePool

device = DevicePool().acquire()

# access device related properties
assert device.udid
```

如果想获取特定的设备, 首先需要在 `sloth.yaml` 中配置设备UDID:

```yaml
# content of sloth.yaml

devices: ["UDID_0", "UDID_1"]
```

然后使用 `DeviceLoader` 按配置顺序获取设备:

```python
from sloth.device import DeviceLoader

loader = DeviceLoader()

device0 = loader.devices[0]
device1 = loader.devices[1]

assert device0.udid == "UDID_0"
assert device1.udid == "UDID_1"
```
