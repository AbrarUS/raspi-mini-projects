# Smart Audio Recorder 🎤

A professional terminal-based audio recording script for Raspberry Pi (or Linux), designed for **maximum control** and **studio-like experience** — entirely through the command line.

- ✅ Record audio on demand
- ✅ Pause and resume recording anytime
- ✅ Stop and save recording with clean file naming
- ✅ Auto-detects PulseAudio or ALSA
- ✅ Supports blinking recording indicator
- ✅ Saves recordings to `/home/abrar/Music/audio_test/`
- ✅ Automatically names files like `Audio-YYYYMMDD-HHMMSS.wav`

---

## 🚀 Features

| Feature | Description |
|:---|:---|
| Start/Stop/Pause/Resume recording | Full interactive control |
| PulseAudio Detection | Automatically uses `parecord` if PulseAudio is available |
| ALSA Fallback | Falls back to `arecord` if PulseAudio is not running |
| Blinking "● Recording..." Indicator | Professional studio feeling in terminal |
| Timestamped Filenames | Automatically saves with timestamp for easy organization |
| Auto Playback | Plays recorded file immediately after stop |

---

## 🎯 Usage

1. **Run from anywhere**:
   
```bash
audio-record
```

(If installed using symbolic link to `/usr/local/bin/audio-record`.)

2. **Control keys** inside the script:

| Key | Action |
|:---|:---|
| `s` | Start recording |
| `p` | Pause recording |
| `r` | Resume recording |
| `q` | Stop recording and save file |

✅ After stopping, the recorded audio automatically plays back.

---

## 📂 Where Are Recordings Saved?

All recordings are saved inside:

```
/home/abrar/Music/audio_test/
```

Each file is named like:

```
Audio-YYYYMMDD-HHMMSS.wav
```

Example:

```
Audio-20250426-234512.wav
```

---

## 🛠 Installation (Optional Shortcut Setup)

1. Save the script as `~/smart-audio-record.sh`
2. Create a symbolic link:

```bash
sudo ln -s /home/abrar/smart-audio-record.sh /usr/local/bin/audio-record
```

✅ Now you can run it simply with:

```bash
audio-record
```
from any terminal window.

---

## ⚡ Requirements

- Raspberry Pi OS (or any modern Debian/Linux)
- `alsa-utils` (`arecord`, `aplay`)
- `pulseaudio-utils` (`parecord`, optional)
- Working microphone (USB, Bluetooth, etc.)
- Working speakers or headphones for playback

---

## 🧠 Advanced Ideas

- Add automatic upload to cloud after recording
- Stream live mic input over network
- Add multi-format export (WAV, MP3)
- Schedule auto-recording sessions with `cron`

---

## 👨‍💻 Author

- **Abrar Shaikh**  
  Custom-built for Raspberry Pi audio projects 🚀

---

## 📜 License

MIT License – free to use, modify, and share.  
(Just give credit when reusing!)

---

# 🎉 Happy Recording!

---