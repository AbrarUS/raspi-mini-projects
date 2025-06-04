# LED Blinker 💡

A minimal Python script to learn basic GPIO control on Raspberry Pi.
This project toggles an LED on and off every second using the `RPi.GPIO` library.

## Wiring

1. Connect a 330Ω resistor to GPIO17 (pin 11 on the header).
2. Attach an LED between the resistor and a ground pin (pin 6).

![Wiring Diagram](https://i.imgur.com/qr2gYxG.png)

## Usage

```bash
python3 blink.py
```

Stop with `Ctrl+C` and the script will clean up the GPIO state.

## Requirements

- Raspberry Pi OS
- `RPi.GPIO` library (`sudo apt install python3-rpi.gpio`)

## License

MIT License – feel free to modify and share.
