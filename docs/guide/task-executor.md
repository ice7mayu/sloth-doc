# Task Executor

An `Actor` attempts to perform different tasks. A task can be put inside an `executor` to be executed multiple times.

```python
from lib.actor import PadActor
from sloth.benchmark import Benchmark
from sloth.dec import executor
from task import cameratask

def test_take_pictures(camera_app):
    loop = Benchmark(1, 100).value
    actor = PadActor(app=camera_app)
    actor.attempt_to(
        cameratask.clear_media,
        executor(loop=loop)(cameratask.take_pictures),
    )
    actor.should(cameratask.see_photos)
```

The actor first clears the media data then takes multiple pictures and finally should see all those photos.

Also the executor can be used as decorators for functions:

```python
from sloth.dec import executor

@executor(loop=3)
def demo():
    """This function will be called 3 times"""
```
