# What Is It And Why Do I Care?

[DreamPicoPort](https://github.com/OrangeFox86/DreamPicoPort) offers VMU and Rumble support using [Flycast](https://github.com/flyinghead/flycast) on Windows, MacOS and Linux. You can even use your VMU as a memory card in Flycast!

![IMG_3281](https://github.com/user-attachments/assets/67826626-f89e-4b31-8cfa-329b92515d48)

## Showcases
[Barebone Setup for 1 Player](https://youtu.be/Nj4dRMZ_jB0)

[Original Dreamcast controller board for up to 4 Players](https://youtu.be/cNRGM1di1Js)

## General Disclaimer

Proceed at your own risk! None of the authors are liable for any damage that may occur due to the use of any provided schematics, firmware, or any other recommendations made within this project (see [LICENSE](https://github.com/OrangeFox86/DreamPicoPort/blob/main/LICENSE.md)). There is risk of damage to any attached hardware (ex: USB port, Dreamcast peripheral, or Dreamcast) if circuitry is improperly handled.

# HowTo (Full)
- For a simplified description, scroll down to the section [HowTo (Simplified)](https://github.com/TheArcadeStriker/flycast-wiki/wiki/DreamPicoPort-Support#howto-simplified)
- However, it is advised to continue here

### Step 1: Hardware Setup
- Wire up a [Raspberry Pi Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/) or [Raspberry Pi Pico 2](https://www.raspberrypi.com/products/raspberry-pi-pico-2/) for [Host Mode](https://github.com/OrangeFox86/DreamPicoPort/wiki/Installation-Guide#for-host-mode)
- You can wire up for any amount of Controllers - DreamPicoPort and Flycast support up to 4
- Pay special attention to [Socket Reference](https://github.com/OrangeFox86/DreamPicoPort/wiki/Installation-Guide#socket-reference) and [Configuration](https://github.com/OrangeFox86/DreamPicoPort/wiki/Installation-Guide#simple-configuration)
- Once the hardware is setup, deploy the [appropriate binary](https://github.com/OrangeFox86/DreamPicoPort/wiki/Installation-Guide#selecting-the-appropriate-binary)
- Perform a first test: Plugin the microcontroller with at least one controller connected. VMU LCD should show a QR-Code as well as the Player Identifier (A, B, C, or D)
- If this doesn't work:
    - Something went wrong in the wiring; you should revisit [Host Mode](https://github.com/OrangeFox86/DreamPicoPort/wiki/Installation-Guide#for-host-mode), [Socket Reference](https://github.com/OrangeFox86/DreamPicoPort/wiki/Installation-Guide#socket-reference) and [Configuration](https://github.com/OrangeFox86/DreamPicoPort/wiki/Installation-Guide#simple-configuration)
    - Your Controller, VMU, and/or Rumble pack may be faulty; verify on original hardware

### Step 2: Software Setup
- Download the latest [build of Flycast](https://flyinghead.github.io/flycast-builds/). Make sure your version is at least 2.5
- Startup Flycast
- Plugin the microcontroller with at least one controller connected. VMU LCD should show a QR-Code as well as the Player Identifier (A, B, C, or D). If not, go back to Step 1
- If you want to use your VMU as a memory card in Flycast, make sure to enable the `Use Physical VMU Memory` checkbox in `Settings -> Controls`
- You are done! Fire up a game, and enjoy VMU and Rumble support
- If this isn't working and you verified Step 1, go to Troubleshooting
- In game, hit `Start + Right Trigger + Left Trigger` at the same time to open the Flycast menu


### Troubleshooting
- Issue 1: VMU and / or Rumble are not working
    - Make sure to check Step 1 again, and verify hardware functionality
    - If you are on Linux, try starting Flycast with superuser permissions
    - While DreamPicoPort is plugged in, check your OS if the USB serial device shows up:
        - Windows: Open `Device Manager -> Ports`. Note down the `COM*` serial device name of `USB Serial Device` (e.g., `COM3`)
        - MacOS: Open `Terminal` and input `ls /dev/tty.usbmodem*`. Note down the name of the serial device port (e.g., `/dev/tty.usbmodem1123`)
        - Linux: Open `Terminal` and input `ls /dev/ttyACM*`. Note down the name of the serial device port (e.g., `/dev/ttyACM0`)
    - If no serial device shows up:
        - check Step 1 again, and verify hardware functionality
    - If exactly one serial device shows up, add the following line to Flycast's `emu.cfg` file in the `[input]` section:
        - `DreamPicoPortSerialDevice = <YourSerialDevicePortName>`
    - If more than one serial device shows up:
        - Check which one has the VID `1209` and the PID `2F07`, and use this one in `emu.cfg` (see previous step), or
        - try and error all devices
    - Make sure to relaunch Flycast after every modification of `emu.cfg`
- Issue 2: Stick/Buttons/Triggers are not working
    - In Flycast, open `Settings -> Controls`. Click `Map` next to `DreamPicoPort`
    - Map the missing Stick/Buttons/Triggers


# HowTo (Simplified)

### Wire Guide For Dummies

* **For Use With Simple Basic Protection method which is 2 different 100 ohm resistors and where to exactly connect each of the 5 wires from your controller cable**
* * Pin 1>>> 100 ohm resistor>>Pi pin 14
* * Pin 2>>>> Pi Pin 39
* * Pins 3 and 4 >>>>>> Pi Pin 38
* * Pin 5 >>>> 100 ohm resistor>>>>> Pi Pin 15

**NOTE: DO NOT ALLOW WIRES TO CROSS MULTIPLE PINS. THIS COULD INSTANTLY BURN OUT YOUR PICO. ENSURE THE PINS GET WIRED TO ONLY THE SPECIFIC PINS STATED HERE. TRIPPLE CHECK BEFORE POWERING ON THE PI FOR THE FIRST TIME.**

* **Pin Guide for controller port looking straight in to the plug on the controller, where the 3 contacts are the top row, and the 2 are the bottom**

* * Pin 1 Top Left
* * Pin 2 Top Middle
* * Pin 3 Top Right
* * Pin 4 Bottom Left
* * Pin 5 Bottom right

### Pi Setup For Dummies

* **[CLICK HERE](https://github.com/OrangeFox86/DreamPicoPort/wiki/Installation-Guide#selecting-the-appropriate-binary)** and ensure you grab the proper release. 1, 2, or 4 players, and pico 1, pico 2, or RP2040-Zero

* Simply copy and move file to the Pi, which should show up in File browser as a removeable drive

* Verify in windows "USB CONTROLLER" page that you not only see the Dreamcast controller, but you verify inputs from the controller on the Properties tab

* You are good to go. In game, hit `Start + Right Trigger + Left Trigger` at the same time to open the Flycast menu