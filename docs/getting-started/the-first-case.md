# 编写第一条测试用例

以测试系统相机为例来实现以下几个测试步骤:

1. 清空系统相册
2. 启动系统相机应用
3. 点击拍摄按钮进行拍照
4. 验证系统相册中有一张照片

## 第一步: 创建应用

首先创建一个 `CameraApp` 类型, 继承于 `PadApp` 类型, 来作为一个上下文管理器, 提供有关 Appium server 和设备相关的信息和数据:

```python title="camera_app.py"
class CameraApp(PadApp):
    name = "System Camera App"
    app_package = "com.mediatek.camera"
    app_activity = ".CameraLauncher"
```

## 第二步: 创建页面对象

然后创建一个 `CameraPage` 类型, 用来封装对元素的定位和执行一些基础的动作, 例如 `click` 事件等:

```python title="camerapage.py"
from sloth.locator import UiSelector
from sloth.log import log


class CameraPage(PadPage):
    """Camera page object"""
    app_id = "com.mediatek.camera"

    def click_shutter(self):
        """Click the shutter button"""
        locator = UiSelector().resource_id(f"{self.app_id}:id/shutter_button") # (1)
        self.wait().until_element_present(locator).click() # (2)
        log.info("Click the shutter button")
        return self
```

1. 🙋‍♂️ 定位元素
2. 🙋‍♂️ 操作元素 `click` 事件

## 第三步: 定义任务

任务用来描述和映射用户需要完成的动作, 这些任务不仅局限于UI上的操作, 例如, 启动应用, 拍摄照片等.
也包括一些非UI类的操作. 例如, 调用后台接口, 执行 shell 脚本等.

在任务模块中, 首先定一个清除相册的任务 `clear_media`:

```python title="cameratask.py"

from lib.actor import PadActor
from sloth import adbutil


def clear_media(actor: PadActor):
    """clear media files"""
    
    adbutil.clear_media(
        udid=actor.app.device.udid,
        media_dir="/sdcard/DCIM/Camera/",
        ext=".jpg",
    )
```

然后定义一个拍摄照片的任务 `take_pictures`:

```python title="cameratask.py"
def take_pictures(actor: PadActor):
    """take pictures"""
    
    camera_page = CameraPage(actor.app)
    camera_page.click_shutter()
```

最后再定义一个检验任务, 用来验证相册中是否存在一张照片 `see_photos`:

```python title="cameratask.py"
def see_photos(actor: PadActor):
    """should see photos in the gallery"""
    
    jpegs = adbutil.get_media_files(
        udid=actor.app.device.udid,
        media_dir="/sdcard/DCIM/Camera/",
        ext=".jpg",
    )
    photos = len(jpegs)
    assert photo == 1, "Gallery has more than 1 photo"
    log.info(f"There should be only 1 photo in the gallery {EMOJI_CHECK}")
```

## 第四步: 组装用例

将 `CameraApp` 转化为一个 pytest fixture 测试套件:

```python title="test_camera.py"
import pytest

@pytest.fixture(scope="function", name="camera_app")
def get_pad_app(pool: DevicePool):
    device = pool.acquire()

    with CameraApp(device) as app:
        yield app
```

定义一个 pytest 测试方法, 创建一个 `Actor` 作为系统用户, 尝试执行预定义的任务, 并验证执行结果是否符合预期:

```python title="test_camera.py"

from task import cameratask


def test_take_pictures(camera_app):
    loop = Benchmark(1, 100).value
    log.info(f"Total execution: {loop}")

    actor = PadActor(app=camera_app)
    actor.attempt_to(
        cameratask.clear_media,
        executor(loop=loop, counter=counter)(cameratask.take_pictures),
    )
    actor.should(cameratask.see_photos)
```

## 第五步: 执行用例

编写完测试用例后就可以使用 `pytest` 命令行工具来执行用例了:

```shell
pytest tests/test_camera.py
```

## 第六步: 查看报告

Sloth 框架已经集成了 Allure 报告, 可以直接使用 `allure serve` 命令行来查看报告:

```shell
allure serve
```

至此一条UI自动化测试用例就完成了.
