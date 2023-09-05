# 编写第一条测试用例

以测试系统相机为例来实现以下几个测试步骤:

1. 清空系统相册
2. 启动系统相机应用
3. 点击拍摄按钮进行拍照
4. 验证系统相册中有一张照片

## 第一步: 创建相机应用

首先创建一个 `CameraApp` 类型, 继承于 `PadApp` 类型, 来作为一个上下文管理器, 提供有关 Appium server 和设备相关的信息和数据:

```python
class CameraApp(PadApp):
    name = "System Camera App"
    app_package = "com.mediatek.camera"
    app_activity = ".CameraLauncher"
```

## 第二步: 创建页面对象(POM)

然后创建一个 `CameraPage` 类型, 用来封装对元素的定位和执行一些基础的动作, 例如: 点击事件等:

```python
from sloth.locator import UiSelector
from sloth.log import log


class CameraPage(PadPage):
    """Camera page object"""
    app_id = "com.mediatek.camera"

    def click_shutter(self):
        """Click the shutter button"""
        locator = UiSelector().resource_id(f"{self.app_id}:id/shutter_button")
        self.wait().until_element_present(locator).click()
        log.info("Click the shutter button")
        return self
```

## 第三步: 定义任务

任务用来描述和映射用户需要完成的动作, 这些任务不仅局限于UI上的操作, 例如, 启动应用, 拍摄照片等.
也包括一些非UI类的操作. 例如, 调用后台接口, 执行 shell 脚本等.

在任务模块中, 首先定一个清除相册的任务 `clear_media`:

```python
# cameratask.py

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

```python
def take_pictures(actor: PadActor):
    """take pictures"""
    
    camera_page = CameraPage(actor.app)
    camera_page.click_shutter()
```

最后再定义一个检验任务, 用来验证相册中是否存在一张照片 `see_photos`:

```python
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

## 第四步: 组装测试用例

定义一个 pytest 测试方法, 创建一个 `Actor` 作为整个用例的上下文管理者, 尝试执行预定义的任务, 并验证执行结果是否符合预期:

```python
# test_camera.py

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

## 第五步: 执行测试用例

编写完测试用例后就可以使用 `pytest` 命令行工具来执行用例了:

```shell
pytest tests/test_camera.py
```

## 第六步: 查看 Allure 报告

Sloth 框架已经集成了 Allure 报告, 可以直接使用 `allure serve` 命令行来查看报告:

```shell
allure serve
```

至此一条UI自动化测试用例就完成了.
