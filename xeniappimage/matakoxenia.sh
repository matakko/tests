#!/bin/bash
#variables
Xenia_emuName="Xenia"
Xenia_emuType="$emuDeckEmuTypeAppImage"
Xenia_emuPath="$emusFolder/xenia_canary"
Xenia_releaseURL_canary="https://github.com/xenia-canary/xenia-canary-releases/releases/latest/download/xenia_canary_linux.tar.gz"
Xenia_XeniaSettings="$emusFolder/xenia_canary/xenia-canary.config.toml"

#cleanupOlderThings
Xenia_cleanup(){
	echo "NYI"
}

#Install
Xenia_install(){
    echo "Begin xenia_canary Install"
    local showProgress="$1"

    if installEmuAI "$Xenia_emuName" "$Xenia_releaseURL_canary" "" "tar.gz" "$showProgress"; then
        mkdir -p "$Xenia_emuPath"
        tar -xvf "$archivePath" -C "$Xenia_emuPath" && rm -f "$HOME/Applications/xenia_canary_linux.tar.gz"
        chmod +x "$Xenia_emuPath/xenia_canary"
    else
        return 1
    fi
}

#ApplyInitialSettings
Xenia_init(){
	setMSG "Initializing Xenia Config"
	rsync -avhp "$emudeckBackend/configs/xenia/" "$Xenia_emuPath"
	mkdir -p "$romsPath/xbox360/roms/xbla"
	Xenia_setupSaves
	#SRM_createParsers
  Xenia_flushEmulatorLauncher
}

#update
Xenia_update(){
	echo "NYI"
	Xenia_setupSaves
	Xenia_flushEmulatorLauncher
}

#ConfigurePaths
Xenia_setEmulationFolder(){
	echo "NYI"
}

#SetupSaves
Xenia_setupSaves(){
	mkdir -p "$Xenia_emuPath/content"
#	linkToSaveFolder xenia saves "$Xenia_emuPath/content"
}


#SetupStorage
Xenia_setupStorage(){
	echo "NYI"
}


#WipeSettings
Xenia_wipeSettings(){
	echo "NYI"
}


#Uninstall
Xenia_uninstall(){
	echo "NYI"
}

#setABXYstyle
Xenia_setABXYstyle(){
	echo "NYI"
}

#Migrate
Xenia_migrate(){
	echo "NYI"
}

#WideScreenOn
Xenia_wideScreenOn(){
	echo "NYI"
}

#WideScreenOff
Xenia_wideScreenOff(){
	echo "NYI"
}

#BezelOn
Xenia_bezelOn(){
	echo "NYI"
}

#BezelOff
Xenia_bezelOff(){
	echo "NYI"
}

#finalExec - Extra stuff
Xenia_finalize(){
	Xenia_cleanup
}

Xenia_IsInstalled(){
	if [ -e "$Xenia_emuPath" ]; then
		echo "true"
	else
		echo "false"
	fi
}

Xenia_resetConfig(){
	mv  "$Xenia_XeniaSettings" "$Xenia_XeniaSettings.bak" &>/dev/null
	Xenia_init &>/dev/null && echo "true" || echo "false"
}

Xenia_setResolution(){
	$xeniaResolution
	echo "NYI"
}

Xenia_cleanESDE(){

	# These files/folders make it so if you have no ROMs in xbox360, it still shows up as an "active" system.
	echo "NYI"
}

Xenia_flushEmulatorLauncher(){
	flushEmulatorLaunchers "xenia"
}
