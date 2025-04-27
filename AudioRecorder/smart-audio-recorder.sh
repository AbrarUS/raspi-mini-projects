#!/bin/bash

# === Smart Audio Recording Script ===
# - Uses a simple command-line interface
# - User-friendly prompts and instructions
# - Uses parecord or arecord for recording
# - Detects if PulseAudio is running
# - Falls back to ALSA default if not
# - Saves to ~/Music/audio_test in the format Audio-YYYYMMDD-HHMMSS.wav
# - Provides colorful output for user feedback
# - Beep feedback for start/stop/pause
# - Blinking indicator during recording
# - User can pause/resume recording
# - Playback recorded audio after stopping

# === Settings ===
SAVE_DIR="$HOME/Music/audio_test" # Use the current user's home directory
mkdir -p "$SAVE_DIR"
NOW=$(date +"%Y%m%d-%H%M%S")
FILENAME="Audio-$NOW.wav"
FULLPATH="$SAVE_DIR/$FILENAME"

# === COLORS ===
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
RESET="\033[0m"

# === Check if PulseAudio is running ===
echo -e "${BLUE}Checking for PulseAudio service...${RESET}"
if pactl info >/dev/null 2>&1; then
    echo -e "${GREEN}✅ PulseAudio detected. Using PulseAudio recording (parecord).${RESET}"
    RECORD_CMD="parecord --device=$(pactl list short sources | grep RUNNING | awk '{print $2}' | head -n1) --rate=44100 --channels=2 \"$FULLPATH\""
else
    echo -e "${YELLOW}⚠️ PulseAudio not detected. Falling back to ALSA (arecord).${RESET}"
    RECORD_CMD="arecord -D default -f cd \"$FULLPATH\""
fi

# === Beep Function ===
beep() {
    echo -ne "\a"
}

# === Start Recording ===
start_recording() {
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
}

# === Blinking Recording Indicator ===
start_blinking_indicator() {
    (while true; do echo -ne "${RED}\r● Recording...${RESET}"; sleep 0.5; echo -ne "\r               "; sleep 0.5; done) &
    BLINK_PID=$!
}

# === Pause Recording ===
pause_recording() {
    kill -STOP "$RECORD_PID" 2>/dev/null
    kill "$BLINK_PID" 2>/dev/null
    beep
    echo -e "${YELLOW}⏸️ Recording paused. Press [p] to resume.${RESET}"
    STATE="paused"
}

# === Resume Recording ===
resume_recording() {
    kill -CONT "$RECORD_PID" 2>/dev/null
    start_blinking_indicator
    beep
    echo -e "${GREEN}▶️ Recording resumed.${RESET}"
    STATE="recording"
}

# === Stop Recording ===
stop_recording() {
    kill "$RECORD_PID" 2>/dev/null
    kill "$BLINK_PID" 2>/dev/null
    beep
    beep
    echo -e "${RED}🛑 Recording stopped.${RESET}"
}

# === Main Script Execution ===
start_recording
start_blinking_indicator

# === Controls Loop ===
STATE="recording"
while true; do
    echo -e "${BLUE}🔘 Press [p] + [Enter] to pause/resume, [q] + [Enter] to stop.${RESET}"
    read -r ACTION
    case "$ACTION" in
        p)
            if [ "$STATE" = "recording" ]; then
                pause_recording
            else
                resume_recording
            fi
            ;;
        q)
            stop_recording
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
aplay "$FULLPATH"

# === Done ===
echo -e "${GREEN}✅ Recording complete: $FULLPATH${RESET}"