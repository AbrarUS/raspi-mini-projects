#!/bin/bash

# === CONFIG ===
SAVE_DIR="/home/abrar/Music/audio_test"
mkdir -p "$SAVE_DIR"

# === COLORS ===
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# === FILENAME ===
NOW=$(date +"%Y%m%d-%H%M%S")
FILENAME="Audio-$NOW.wav"
FULLPATH="$SAVE_DIR/$FILENAME"

# === CHECK PULSEAUDIO ===
if pactl info &>/dev/null; then
    RECORD_CMD="parecord --file-format=wav --rate=44100 --channels=2 \"$FULLPATH\""
    echo -e "${GREEN}[INFO] PulseAudio detected. Using parecord.${NC}"
else
    RECORD_CMD="arecord -D default -f cd \"$FULLPATH\""
    echo -e "${YELLOW}[INFO] PulseAudio NOT detected. Falling back to arecord.${NC}"
fi

# === FUNCTIONS ===
function blink_recording {
    while true; do
        echo -ne "${RED}● Recording...${NC}\r"
        sleep 0.5
        echo -ne "               \r"
        sleep 0.5
    done
}

function start_recording {
    eval $RECORD_CMD &
    RECORD_PID=$!
    blink_recording &
    BLINK_PID=$!
}

function pause_recording {
    kill -STOP $RECORD_PID
    kill $BLINK_PID
    echo -e "${YELLOW}[PAUSED] Recording paused.${NC}"
}

function resume_recording {
    kill -CONT $RECORD_PID
    blink_recording &
    BLINK_PID=$!
    echo -e "${GREEN}[RESUMED] Recording resumed.${NC}"
}

function stop_recording {
    kill $RECORD_PID
    kill $BLINK_PID
    wait $RECORD_PID 2>/dev/null
    echo -e "${BLUE}[STOPPED] Recording saved to:${NC} $FULLPATH"
}

# === CONTROL ===
clear
echo -e "${BLUE}Recording Controller:${NC}"
echo -e "${GREEN}[s] Start recording${NC}"
echo -e "${YELLOW}[p] Pause recording${NC}"
echo -e "${GREEN}[r] Resume recording${NC}"
echo -e "${RED}[q] Stop and Save${NC}"

while true; do
    read -n1 -s KEY
    case "$KEY" in
        s)
            if [ -z "$RECORD_PID" ]; then
                start_recording
            else
                echo -e "${RED}[ERROR] Already recording.${NC}"
            fi
            ;;
        p)
            if [ -n "$RECORD_PID" ]; then
                pause_recording
            fi
            ;;
        r)
            if [ -n "$RECORD_PID" ]; then
                resume_recording
            fi
            ;;
        q)
            if [ -n "$RECORD_PID" ]; then
                stop_recording
            fi
            break
            ;;
    esac
done

# === PLAYBACK ===
echo -e "${GREEN}[INFO] Playing back the recording...${NC}"
aplay "$FULLPATH"
