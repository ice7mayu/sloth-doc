# Element Locating

UI element locating logics should be encapsulated in `page` modules under `pom` package.

To locate the shutter button of the system camera app.
First create a `CameraPage` to hold the UI elements along with possible actions:

```python
# pom/camerapage.py

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

Then create an instance of the `CameraPage` inside camera task module to perform desired actions:

```python
# task/cameratask.py

from lib.actor import PadActor
from pom.camerapage import CameraPage

def take_picture(actor: PadActor):
    camera_page = CameraPage(actor.app)
    camera_page.click_shutter() 
```

## Other element locating methods

To locate element with class name:

```python
locator = UiSelector().class_name("android.widget.TextView")
```

To locate element with text:

```python
locator = UiSelector().text("ELEMENT DISPLAY TEXT")
```

To locate element with xpath:

```python
locator = UiSelector().xpath("//android.view.ViewGroup/android.widget.TextView")
```

## Wait element state

The `Waiter` class takes care of locating element and waiting until a certain state under the hood.
The `wait` method in `Page` class can be used for this purpose.

To locate an element and wait until it's present:

```python
self.wait().until_element_present(locator)
```

Wait until a checkbox element is checked:

```python
self.wait().until_element_checked(locator)
```
