import RPi.GPIO as GPIO
import time

LED_PIN = 17  # You can change this to the GPIO pin you want to use

GPIO.setmode(GPIO.BCM)
GPIO.setup(LED_PIN, GPIO.OUT)

print("Blinking on GPIO", LED_PIN)

try:
    while True:
        GPIO.output(LED_PIN, GPIO.HIGH)
        time.sleep(1)
        GPIO.output(LED_PIN, GPIO.LOW)
        time.sleep(1)
except KeyboardInterrupt:
    print("\nExiting...")
finally:
    GPIO.cleanup()
