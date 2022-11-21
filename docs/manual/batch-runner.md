# Batch Runner Script

批量执行单条case, 并按单条case上传报告

在tanyang项目根目录下创建 runner.sh 脚本, 如下:

```Bash
poetry run python run.py tests/watch/test_camera.py::test_01 --run --upload
sleep 60
poetry run python run.py tests/watch/test_camera.py::test_02 --run --upload
sleep 60
poetry run python run.py tests/watch/test_camera.py::test_03 --run --upload
```

给runner.sh脚本执行权限

```Bash
chmod 755 runner.sh
```

执行runner.sh脚本并重定向console输出到 runner.log 日志文件中

```Bash
caffeinate ./runner.sh > runner.log
```

等待所有case执行结束后, 从runner.log中过滤出上传的报告链接

```Bash
grep "Upload report" runner.log
```
