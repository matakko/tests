This page will have most if not all the information you need to getting started with using flycast.

# Requisites and important files
Flycast has builds avaliable for Ubuntu, Mac OSX, Android and Windows x64, all of which can be downloaded [right here](https://flyinghead.github.io/flycast-builds/) (because of course you need to download the emulator in first place, and extract it in its own folder). So about hardware/software requirements, you'd need any of these operating systems (sorry 32-bit Windows users), and a GPU that supports OpenGL 3.0 or Open GL ES 2.0. A Dreamcast BIOS file is optional but NAOMI and Atomiswave BIOS files are required. Of course you'll also need the game media. Homebrew and Indie games are also supported.

### Dreamcast main files
The Dreamcast BIOS file, if present, should be named "dc_boot.bin" and located inside a folder named "data" inside Flycast's folder. The following is a table of Dreamcast files, all of which (except dc_boot.bin) are generated and used by the emulator (so, for example, it is recommended that you only have a dc_boot.bin file inside if you are starting, unless you are importing your stuff from another setup):

| File       | Function       |
| ------------- |---------------|
| dc_boot.bin       | Main BIOS       |
| dc_nvmem.bin       | Console internal memory data; like clock, language      |
| VMU_save_XY.bin    | VMU save files; X for controller port and Y for slot (for example, A1, C1, D2)       |

For the dc_boot.bin file, any bios file from any region is compatible; but it also works with an devkit BIOS (which has an alternate boot sequence) and with the Custom 1.031.00 bios (jc-bootROM-retail-v1.031.bin or jc-bootROM-devkit-v1.031.bin); the only requirement being that the bios file is named "dc_boot.bin".

### NAOMI/Atomiswave BIOS files
To run SEGA NAOMI and Sammy Atomiswave games, you also need the corresponding BIOS files, that should be placed either in the aforementioned data folder, or in the content folder (where you have your games). Note that these _should_ be from the latest MAME romset in order to work, and it is **highly** recommended that you check [this page](https://github.com/TheArcadeStriker/flycast-wiki/wiki/Verifying-your-BIOS-and-Arcade-ROMs) to verify the required files for each BIOS archive.

| File       | Function       |
| ------------- |---------------|
| naomi.zip | Almost all NAOMI games   |
| hod2bios.zip | The House of the Dead 2   |
| awbios.zip | All Atomiswave games   |
| f355bios.zip | Ferrari F355 Challenge (twin/deluxe) |

# Main Interface
After you have added the BIOS file for Dreamcast (and NAOMI/Atomiswave if going to use that), you can open the emulator, and you should be greeted by this screen:

![](https://github.com/TheArcadeStriker/flycast-wiki/blob/master/screenshots/screenshot-FirstTime.png)

This is where all your games will be displayed on a list after you point it to your content folder. If you want, you can test if your Dreamcast BIOS was added properly by loading the "Dreamcast BIOS", which boots to...the Dreamcast BIOS, where you can manage your console settings and VMUs, among other things.

Clicking the 'Settings' button gets you to another screen; but the first important option here is "Content Location", where it will have an 'Add' button. Clicking it will prompt you to select a folder where all your games are located; it will use its own UI instead of opening a dialog, so if you wonder how to go back an folder, just click the ".." among other folders. Once you have got to the folder you want to use (you should be inside it), click "Select Current Directory" and voilá! Your games should appear in the list. 

You can also add as many folders as you want; this is useful to keep an order between Dreamcast and Arcade games, though all recognized file formats found will be shown in the same list (this means that it won't be categorized by folders), and adding folders is recursive (which means that it will search inside folders of the selected folders).

# Now what's next?
At this point, the only thing remaining is to tweak/configure the emulator to your liking, configure the controls to your taste, and then enjoy your games! An rundown about the settings, about what does each one do and how to configure controls, will be added on a separate page dedicated to the Settings sub-menu.

## Note for NAOMI & Atomiswave games
Flycast has support for MAME roms; both .zip and .7z, which means that you should use these rather than the legacy .DAT/.LST ROMs. In the case of NAOMI GD-ROMS, the .CHD needs to be in a folder with the same name and in the same location as the ROM. For example, if you have Monkey Ball in a `games` folder, you should have `games/monkeyba.zip` or `games/monkeyba.7z`; and the CHD should be in `games/monkeyba`; which would look like `games/monkeyba/gds-0008.chd`.

I hope that you enjoy!