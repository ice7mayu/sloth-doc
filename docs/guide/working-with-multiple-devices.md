# Working with Multiple Devices

To acquire any connected devices from `DevicePool`:

```python
from sloth.device import DevicePool

device = DevicePool().acquire()

# access device related properties
assert device.udid
```

Or use a DeviceLoader to acquire specific devices defined in `sloth.yaml` file:

```yaml
# content of sloth.yaml

devices: ["UDID_2", "UDID_1"]
```

Then pull these devices from `DeviceLoader` in sequential order:

```python
from sloth.device import DeviceLoader

loader = DeviceLoader()
device0 = loader.devices[0]
device1 = loader.devices[1]
```
