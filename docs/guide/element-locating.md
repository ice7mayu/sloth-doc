# 定位元素

定位元素的代码逻辑通常被封装在 `Page` 类型的模块里.

以定位系统相机应用中的拍照按钮为例, 首先创建一个 `CameraPage` 类型来定位按钮元素并执行 `click` 事件:

```python title="pom/camerapage.py"
from sloth.locator import UiSelector
from sloth.log import log
from . import PadPage

class CameraPage(PadPage):
    """The cameara page object"""
    def click_shutter(self):
        """The click action for the shutter button"""
        locator = UiSelector().resource_id("com.mediatek.camera:id/shutter_button")
        self.wait().until_element_present(locator).click()
        log.info("Click shutter button")
        return self
```

然后在对应的任务模块中实例化 `CameraPage` 类型来完成拍照任务:

```python title="task/cameratask.py"

from lib.actor import PadActor
from pom.camerapage import CameraPage

def take_picture(actor: PadActor):
    camera_page = CameraPage(actor.app)
    camera_page.click_shutter()
```

## 常用的定位元素方法

使用 `resource_id` 定位元素:

```python
locator = UiSelector().resource_id("com.android.settings:id/tv_pet_name")
```

使用 `class_name` 定位元素:

```python
locator = UiSelector().class_name("android.widget.TextView")
```

使用 `text` 定位元素:

```python
locator = UiSelector().text("ELEMENT DISPLAY TEXT")
```

使用 `xpath` 定位元素:

```python
locator = UiSelector().xpath("//android.view.ViewGroup/android.widget.TextView")
```

使用 `xpath` 定位多个元素:

```python
locator = UiSelector().xpath("//android.widget.TextView")
self.wait().until_elements_present(locator, exp=3)
```

## 等待元素状态

在定位元素时, 有时需要等待元素变为特定的状态后再返回预期的结果. `Page` 类型中的 `wait` 方法提供了一系列等待元素状态的方式.
例如, 等待元素出现:

```python
self.wait().until_element_present(locator)
```

等待元素变为可见状态:

```python
self.wait().until_element_shown(locator)
```

等待元素变为可点击状态:

```python
self.wait().until_element_clickable(locator)
```

等待复选框元素变为选中状态:

```python
self.wait().until_element_checked(locator)
```

等待元素文本变为预期文本:

```python
self.wait().until_element_text_to_be(locator, "EXPECTED_TEXT")
```
