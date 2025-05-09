# Enter your path here.
# $emusPath is for your /Emulators folder that can be in %APPDATA%/EmuDeck/Emulators or directly in EmulationStation-DE/Emulators
# $emulationPath is for your /Emulation folder where you will have the /save folder

$emusPath = "D:\Emulation\Emulators"
$emulationPath = "D:\Emulation"

function createSaveLink($target, $linkPath) {
    if (Test-Path $linkPath) {
        Remove-Item -Path $linkPath -Force
    }

    New-Item -ItemType SymbolicLink -Path $linkPath -Target $target
	
}
#Azahar - 3DS 
function Azahar_setupSaves(){

	#testing path
	mkdir "$emusPath\azahar\user\states"  -ErrorAction SilentlyContinue
	$simLinkPath = "$emusPath\azahar\user\sdmc"
	$emuSavePath = "$emulationPath\saves\azahar\saves"
	createSaveLink $simLinkPath $emuSavePath
 
	$simLinkPath = "$emusPath\azahar\user\states"
	$emuSavePath = "$emulationPath\saves\azahar\states"
	createSaveLink $simLinkPath $emuSavePath
	#cloud_sync_save_hash "$savesPath\citra"
}

#Cemu - WiiU

#Citra - 3DS

#Citron - Switch	

#Dolphin - Gamecube

#Dolpin - Wii

#Duckstation - PS1

#Flycast - Dreamcast

#lime3ds - 3DS

#m2emulator - Sega Model 2

#MelonDS - DS

#mGBA - GBA

#PCSX2 - PS2

#Primehack - Wii Metroid

#PPSSPP - PSP

#Retroarch - Multi system 

#RPCS3 - PS3

#ryujinx - switch 

#Scummvm - Scummvm

#Shadps4 - PS4

#supermodel - SEGA Model 3 

#VITA3k - PSVita

#Xemu - Xbox

#Xenia - Xbox 360 

#yuzu - Switch 

Azahar_setupSaves
