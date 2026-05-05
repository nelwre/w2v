# w2v (wav2video)

# What Is That?

* It's a bash script that converts any .wav file into a .mov/.mkv (uncompressed audio) file.

# How do I use it?

* you just need a .wav file (obviously) and ffmpeg installed.

* you can also use images, a animated gif or a black screen.

* and also, you can choose between the .mov format (which has pcm audio) or the .mkv format (which has a flac audio)
* the audio should not be compressed anyways; both are uncompressed audio formats.

* heres a exemple.


```
./w2v --bg [gif, image here or just "black" if you want a black screen.] --fmt [mov or mkv] file.wav
```

# But why?

* I made this with the intention of uploading uncompressed audio videos, to avoid possible loss of quality when uploaded to some video services (YouTube is a good example because it always re-encodes audios from videos to aac or opus).

* Unfortunately, there is no way to prevent this, so the best way is to upload the uncompressed audio to avoid loss of quality "in what is already lost".

# It's useful?

* maybe. (i hope so.)

# important note:
* i didnt actually make the code, claude did. i just tested and published the script.
* so sorry if any error happens.
