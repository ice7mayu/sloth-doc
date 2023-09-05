# 语音引擎

Sloth 提供了一个TTS语音引擎 `assistant` 来播放语音指令, 可以用来测试语音助手相关功能.

唤醒语音助手并执行语音指令:

```python
from lib.assistant import assistant

# wake up voice assistant
assistant.wake_up()

# play audio command
assistant.say("TEXT COMMAND")
```

调整语音播放速度:

```python
assistant.rate = 200
```
