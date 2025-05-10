# Basic Troubleshooting
## If something goes wrong when trying to run a game, you should follow these basic troubleshooting steps:
1. Enable `Advanced > Safe Mode` option
2. Set `Broadcast` and `Region` according to the game being played
3. Set `Cable` option to `TV Composite`
4. Use a real BIOS and uncheck `Advanced > HLE BIOS`

## If something is not Rendering properly:
1.(Android only) go to settings and advanced, if you have a MALI or ADRENO GPU, then you are most likely out of luck (deff with MALI)
2. Change API's. Try Vulkan or openGL.
3. Use Per Pixel sorting (some games require this for shadows and such, or disable shadows/fog to see if you can remove broken shadows or effects if you can not use Per Pixel)
4. Lower Resolution Settings.
5. Use Frame Skip

# NAOMI/Atomiswave Troubleshooting
## I get an "Cannot load BIOS" error!
Depending of what game you are trying to load, you can get these errors:
* NAOMI/NAOMI GD-ROM games

![](https://github.com/TheArcadeStriker/flycast-wiki/blob/master/screenshots/romverify/missingnaomi.PNG)
* Atomsiwave games

![](https://github.com/TheArcadeStriker/flycast-wiki/blob/master/screenshots/romverify/missingawbios.PNG)
* The House of the Dead 2 [hotd2 and hotd2o]

![](https://github.com/TheArcadeStriker/flycast-wiki/blob/master/screenshots/romverify/missinghod2bios.PNG)
* Ferrari F355 Challenge (twin/deluxe) [f355twin]

![](https://github.com/TheArcadeStriker/flycast-wiki/blob/master/screenshots/romverify/missingf355bios.PNG)

There are only **TWO** possible reasons for this to happen.
1. The corresponding BIOS file is missing/not found on the data folder. Please make sure that the BIOS files are located in the right place.
2. Your BIOS files is outdated/missing files, and you need to get an updated BIOS. The most likely one to happen easily is with Atomiswave games, as said BIOS has **two** files in an updated/proper BIOS, but only one in an old BIOS. Please refer to [this page](https://github.com/TheArcadeStriker/flycast-wiki/wiki/Verifying-your-BIOS-and-Arcade-ROMs#arcade-bios-naomi-and-atomiswave) to check your BIOS files.

## I get an "Cannot find mpr-23193.ic23s" error or similar!
If you do get an error like the following when you try opening an NAOMI or Atomiswave game:

![](https://github.com/TheArcadeStriker/flycast-wiki/blob/master/screenshots/romverify/missingrom-cropped.PNG)

Then it means that the ROM you are trying to load is missing ROMs; and this means that you have an outdated ROM/ZIP; since this case only happens if your ROM is missing certain files. Flycast uses the latest MAME ROMs, which means that this error is because of using an outdated ROM; and you should re-obtain the ROM from another source and compare it with the captures from the [this page](https://github.com/TheArcadeStriker/flycast-wiki/wiki/Verifying-your-BIOS-and-Arcade-ROMs#naomi-cartridge-games). After that, try loading the game again.

# Input/Controller Troubleshooting
## I can't map my keyboard/D-Pad to the Analog Sticks!
Currently, Flycast only allows you to map analog axises to analog sticks (Left Stick and Right Stick), which means you can't map your keyboard, d-pad or buttons to them yet. There's an exception for Left and Right Triggers, which are avaliable to be mapped to digital inputs (buttons and keyboard).

## The controls for most NAOMI/Atomiswave games are messed up!
Most of the games have different button configurations, and the standard Dreamcast mapping often mismatch (are awkward to use or have missing controls) with certain games. This can be solved by using the "Arcade Button names" option in the Controller Mapping screen, and then refer to the specified pages for the corresponding games:

### General mappings (shared with other games)
* [6-button fighters](https://github.com/TheArcadeStriker/flycast-wiki/wiki/Button-mapping-guide-for-NAOMI-&-Atomiswave-games) 
* * Capcom VS SNK 2 - Millionaire Fighting 2001 (cvs2)
* * Street Fighter Zero 3 Upper (sfz3ugd)
* [Racing games](https://github.com/TheArcadeStriker/flycast-wiki/wiki/Button-mapping-guide-for-NAOMI-&-Atomiswave-games#racing-games)
* * Crazy Taxi (crzytaxi)
* * Faster than Speed (ftspeed)
* * Maximum Speed (maxspeed)
* [Light-Gun games](https://github.com/TheArcadeStriker/flycast-wiki/wiki/Button-mapping-guide-for-NAOMI-&-Atomiswave-games#light-gun-games)
* [Keyboard games](https://github.com/TheArcadeStriker/flycast-wiki/wiki/Button-mapping-guide-for-NAOMI-&-Atomiswave-games#keyboard-games)

### Specific mappings (exclusive to certain games/game series)
* [Alien Front (alienfnt)](https://github.com/TheArcadeStriker/flycast-wiki/wiki/Button-mapping-guide-for-NAOMI-&-Atomiswave-games#alien-front)
* [Guilty Gear games (ggx, ggx15, ggxx, etc)](https://github.com/TheArcadeStriker/flycast-wiki/wiki/Button-mapping-guide-for-NAOMI-&-Atomiswave-games#guilty-gear)
* [Gun Survivor 2 (gunsur2)](https://github.com/TheArcadeStriker/flycast-wiki/wiki/Button-mapping-guide-for-NAOMI-&-Atomiswave-games#gun-survivor-2)
* [Melty Blood & Akatsuki Blitzkampf (mbaa, ausfache, etc)](https://github.com/TheArcadeStriker/flycast-wiki/wiki/Button-mapping-guide-for-NAOMI-&-Atomiswave-games#melty-bloodakatsuki-blitzkampf)
* [Wave Runner GP (wrungp)](https://github.com/TheArcadeStriker/flycast-wiki/wiki/Button-mapping-guide-for-NAOMI-&-Atomiswave-games#wave-runner-gp)

## Error Codes (Naomi)
There's an complete list of error codes for NAOMI avaliable [here](https://wiki.arcadeotaku.com/w/Sega_NAOMI_Error_Codes), and here are some few ones that may appear, which can be solved easily.

### ERROR 01:
This means the game's ZIP might be faulty or lacking of a CHD file in the case of GD-ROM games. Try updating your romset to the latest version to avoid this, also make sure the CHD file is on the folder named as the game's ZIP.

For example: Monkey Ball (monkeyba, GDS-0008), its corresponding CHD with the name 'gds-0008' must be in a folder named 'monkeyba'. Note that both the ZIP and the folder must be in the same path.

### ERROR 02:
This means the game wasn't designed for regions outside Japan. To fix this, just change the region to 'Japan' in the options.

### CAUTON 51: 
This means the game is using an incorrect cabinet type. This can be fixed in the Test Mode menu.