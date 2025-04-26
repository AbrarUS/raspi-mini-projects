#!/bin/bash

# === Smart Audio Recording Script (Fancy Interactive Version with Blinking Indicator and Beeps) ===
# - Detects if PulseAudio is running
# - Falls back to ALSA default if not
# - Saves to /home/abrar/Music/audio_test/[audio][reverse_date][timestamp].wav
# - Start/Stop/Pause control by user with colorful output, blinking indicator, and beep feedback

# === Settings ===
SAVE_DIR="/home/abrar/Music/audio_test"
REVERSE_DATE=$(date +%Y%m%d | tac -s '' | tr -d '\n')
TIMESTAMP=$(date +-%H%M%S-)
FILENAME="Audio${REVERSE_DATE}${TIMESTAMP}.wav"
FULL_PATH="$SAVE_DIR/$FILENAME"

# === Create target directory if missing ===
mkdir -p "$SAVE_DIR"

# === Colors ===
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
RESET="\033[0m"

# === Beep Function ===
beep() {
    echo -ne "\a"
}

# === Check if PulseAudio is running ===
echo -e "${BLUE}Checking for PulseAudio service...${RESET}"
if pactl info >/dev/null 2>&1; then
    echo -e "${GREEN}✅ PulseAudio detected. Using PulseAudio recording (parecord).${RESET}"
    RECORD_CMD="parecord --device=$(pactl list short sources | grep RUNNING | awk '{print $2}' | head -n1) --rate=44100 --channels=2 \"$FULL_PATH\""
else
    echo -e "${YELLOW}⚠️ PulseAudio not detected. Falling back to ALSA (arecord).${RESET}"
    RECORD_CMD="arecord -D default -f cd \"$FULL_PATH\""
fi

# === Start Recording ===
echo -e "${BLUE}🎙️ Press [s] + [Enter] to start recording${RESET}"
read -r START
if [ "$START" != "s" ]; then
    echo -e "${RED}Recording cancelled.${RESET}"
    exit 0
fi

# Start recording in background
bash -c "$RECORD_CMD" &
RECORD_PID=$!
beep
beep

echo -e "${GREEN}🎙️ Recording started. Press [p] to pause/resume, [q] to stop.${RESET}"

# === Blinking Recording Indicator ===
(while true; do echo -ne "${RED}\r● Recording...${RESET}"; sleep 0.5; echo -ne "\r               "; sleep 0.5; done) &
BLINK_PID=$!

# === Controls Loop ===
STATE="recording"
while true; do
    echo -e "${BLUE}🔘 Press [p] + [Enter] to pause/resume, [q] + [Enter] to stop.${RESET}"
    read -r ACTION
    case "$ACTION" in
        p)
            if [ "$STATE" = "recording" ]; then
                kill -STOP "$RECORD_PID" 2>/dev/null
                kill "$BLINK_PID" 2>/dev/null
                beep
                echo -e "${YELLOW}⏸️ Recording paused. Press [p] to resume.${RESET}"
                STATE="paused"
            else
                kill -CONT "$RECORD_PID" 2>/dev/null
                (while true; do echo -ne "${RED}\r● Recording...${RESET}"; sleep 0.5; echo -ne "\r               "; sleep 0.5; done) &
                BLINK_PID=$!
                beep
                echo -e "${GREEN}▶️ Recording resumed.${RESET}"
                STATE="recording"
            fi
            ;;
        q)
            kill "$RECORD_PID" 2>/dev/null
            kill "$BLINK_PID" 2>/dev/null
            beep
            beep
            echo -e "${RED}🛑 Recording stopped.${RESET}"
            break
            ;;
        *)
            echo -e "${RED}❗ Invalid input. Press [p] to pause/resume or [q] to stop.${RESET}"
            ;;
    esac
    sleep 0.5
done

# === Playback Recorded Audio ===
echo -e "${BLUE}🎵 Playing back your recording...${RESET}"
aplay "$FULL_PATH"

# === Done ===
echo -e "${GREEN}✅ Recording complete: $FULL_PATH${RESET}"
