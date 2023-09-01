# Voice Engine

Sloth provides a global `assistant` TTS helper instance to play voice audio which can be used againt voice assistant related tests.

To wake up the voice assistant and play a voice command:

```python
from lib.assistant import assistant

# wake up voice assistant
assistant.wake_up()

# play audio command
assistant.say("TEXT COMMAND")
```

To adjust speech rate to a suitable value before playing:

```python
assistant.rate = 200
```
