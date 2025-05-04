# This is a simple GUI application using guizero
# It creates a window with the title "Hello World" and dimensions 200x100 pixels
# The app.display() method starts the GUI event loop, allowing the window to be displayed

from guizero import App

app = App(title="Hello World")
app.display()
