# What Is It And Why Do I Care?

If you want to upcycle your dusty old Dreamcast, or if you are up for an investment into a preowned one, you can use the original controller board to expose all 4 Controller Ports with [DreamPicoPort](https://github.com/OrangeFox86/DreamPicoPort). You can also buy a new standalone controller board - but this may end up being more expensive depending on your market.

This HowTo elaborates the wiring of a Raspberry Pi Pico running [DreamPicoPort](https://github.com/OrangeFox86/DreamPicoPort) to original Dreamcast controller boards. You can use this, e.g., for building a dedicated Dreamcast emulation device, [like the one I build in a Dreamcast shell](https://www.youtube.com/watch?v=cNRGM1di1Js).

![IMG_3454](https://github.com/user-attachments/assets/35b99aee-048d-45cf-9222-db46f829202b)

## General Disclaimer

Proceed at your own risk! None of the authors are liable for any damage that may occur due to the use of any provided schematics, firmware, or any other recommendations made within this project (see [LICENSE](https://github.com/OrangeFox86/DreamPicoPort/blob/main/LICENSE.md)). There is risk of damage to any attached hardware (ex: USB port, Dreamcast peripheral, or Dreamcast) if circuitry is improperly handled.

### Step 0: Prerequisites
- Get an Original Dreamcast Controller board
- Get a 20 pin 1mm ribbon cable breakout board [like this one](https://www.amazon.com/uxcell-Converter-Couple-Extend-Adapter/dp/B07RT6YNBC/ref=pd_vtp_h_pd_vtp_h_d_sccl_1/135-8650732-7859712?pd_rd_w=8pFgp&content-id=amzn1.sym.e56a2492-63c9-43e2-8ff2-0f40df559930&pf_rd_p=e56a2492-63c9-43e2-8ff2-0f40df559930&pf_rd_r=C7EP1HNJKMVXD2BS8GED&pd_rd_wg=eIxxS&pd_rd_r=119fcd30-373b-4793-b253-1e53eafb9fd8&pd_rd_i=B07RT6YNBC&psc=1)
- The following documentation is based on the linked board. I.e., Pin identifiers may be different if you use a different board

### Step 1: Hardware Setup
- Wire up a [Raspberry Pi Pico](https://www.raspberrypi.com/products/raspberry-pi-pico/) or [Raspberry Pi Pico 2](https://www.raspberrypi.com/products/raspberry-pi-pico-2/) according to the scheme below
- Make sure that you take the pin numbers from the 0.5mm side, despite the ribbon cable being connected to the 1mm side
- As for GND and +5V, you can use any one of the pins. I decided to use those which have a Pico Pin No. assigned in the scheme
- Make sure that the SDCKA/B Pins of A,B,C,D are wired from the breakout board to the Pi Pico using a resistor of ~50ohms - you need 8 resistors in total

<img width="500" alt="Screenshot 2025-03-24 at 18 01 26" src="https://github.com/user-attachments/assets/ea90bcc3-27f0-495e-84e5-02ee6b05704d" />
<img width="300" alt="Screenshot 2025-03-07 at 10 25 50" src="https://github.com/user-attachments/assets/40ef213f-305f-4691-ba41-c65c733ce1ea" />

- Once the hardware is setup, deploy the [appropriate binary](https://github.com/OrangeFox86/DreamPicoPort/wiki/Installation-Guide#selecting-the-appropriate-binary)
- Perform a first test: Plugin the microcontroller with at least one controller connected. VMU LCD should show a QR-Code as well as the Player Identifier (A, B, C, or D)
- If this doesn't work:
    - Something went wrong in the wiring; you should revisit the scheme above
    - Your Controller or VMU may be faulty; verify on original hardware
- Make sure to checkout the [DreamPicoPort Installation Guide](https://github.com/OrangeFox86/DreamPicoPort/wiki/Installation-Guide) if you run into any trouble

### Step 2: Software Setup
- [Described here](https://github.com/TheArcadeStriker/flycast-wiki/wiki/DreamPicoPort-Support#step-2-software-setup)

### Troubleshooting
- [Described here](https://github.com/TheArcadeStriker/flycast-wiki/wiki/DreamPicoPort-Support#troubleshooting)