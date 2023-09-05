# 任务执行器

通常 `Actor` 尝试执行某些任务并验证结果是否符合预期. 如果某项任务需要被执行多次, 可以使用 `executor` 装饰器来完成这项工作.
例如, 重复执行 `cameratask.take_pictures` 这项任务:

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

此外 `executor` 装饰器也可以用在函数定义阶段:

```python
from sloth.dec import executor

@executor(loop=3)
def demo():
    """This function will be called 3 times"""
```
