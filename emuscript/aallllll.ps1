$Azahar_configFile="$emusPath\azahar\user\config\qt-config.ini"

function Azahar_install(){
	setMSG "Downloading Azahar"
	$url_azahar = getLatestReleaseURLGH "azahar-emu/azahar" "zip" "windows-msvc"
	#$url_azahar = "https://github.com/azahar-emu/azahar/releases/download/2120-rc3/azahar-2120-rc3-windows-msvc.zip"
	download $url_azahar "azahar.zip"
	$oldName = Get-ChildItem -Path "$temp/azahar" -Directory -Filter "azahar-*-windows-msvc" | Select-Object -First 1
	$newName = Join-Path -Path "$temp/azahar" -ChildPath "azahar"
	Rename-Item -Path $oldName.FullName -NewName $newName
	moveFromTo "$temp/azahar/azahar" "$emusPath/azahar"
	rm -r -fo "$temp/azahar"
	createLauncher "azahar"

}
function Azahar_init(){

	setMSG "Azahar - Configuration"

	$destination="$emusPath\azahar\user"
	mkdir $destination -ErrorAction SilentlyContinue

	$destination="$emusPath\azahar\user\config"
	mkdir $destination -ErrorAction SilentlyContinue
	copyFromTo "$env:APPDATA\EmuDeck\backend\configs\azahar\config" "$destination"

	sedFile "$Azahar_configFile" "C:/Emulation" "$emulationPath"
	sedFile "$Azahar_configFile" ":\Emulation" ":/Emulation"

	mkdir "$emusPath\azahar\user\sysdata"  -ErrorAction SilentlyContinue
	$simLinkPath = "$emusPath\azahar\user\sysdata"
	$emuSavePath = "$biosPath\azahar"
	createSaveLink $simLinkPath $emuSavePath

	Azahar_setupSaves

	Azahar_migrate

	ESDE_refreshCustomEmus

	ESDE_setEmu 'Azahar (Standalone)' n3ds

	SRM_createParsers

}
function Azahar_update(){
	Write-Output "NYI"
}
function Azahar_setEmulationFolder(){
	Write-Output "NYI"
}
function Azahar_setupSaves(){
	setMSG "Azahar - Saves Links"

	#Saves migration
	$test=Test-Path -Path "$emulationPath\saves\citra"
	if($test){
		Rename-Item -Path "$emulationPath\saves\citra" -NewName "$emulationPath\saves\azahar"
	}


	mkdir "$emusPath\azahar\user"  -ErrorAction SilentlyContinue
	$simLinkPath = "$emusPath\azahar\user\sdmc"
	$emuSavePath = "$emulationPath\saves\azahar\saves"
	createSaveLink $simLinkPath $emuSavePath

	$simLinkPath = "$emusPath\azahar\user\states"
	$emuSavePath = "$emulationPath\saves\azahar\states"
	createSaveLink $simLinkPath $emuSavePath
	#cloud_sync_save_hash "$savesPath\citra"
}
function Azahar_setupStorage(){
	Write-Output "NYI"
}

function Azahar_setResolution($resolution){
	switch ( $resolution )
	{
		"720P" { $multiplier = 3 }
		"1080P" { $multiplier = 5 }
		"1440P" { $multiplier = 6 }
		"4K" { $multiplier = 9 }
	}

	setConfig "resolution_factor" $multiplier "$Azahar_configFile"
}

function Azahar_wipe(){
	Write-Output "NYI"
}
function Azahar_uninstall(){
	Remove-Item -path "$emusPath\azahar" -recurse -force
	if($?){
		Write-Output "true"
	}
}
function Azahar_migrate(){

	# Launcher
	rm -fo -r "$toolsPath/launchers/citra.ps1"
	rm -fo -r "$toolsPath/launchers/lime3ds.ps1"

	$simLinkPath = "$toolsPath/launchers/lime3ds.ps1"
	$emuSavePath = "$toolsPath/launchers/azahar.ps1"
	createSaveLink $simLinkPath $emuSavePath

	$simLinkPath = "$toolsPath/launchers/citra.ps1"
	$emuSavePath = "$toolsPath/launchers/azahar.ps1"
	createSaveLink $simLinkPath $emuSavePath
}

function Azahar_setABXYstyle(){
	Write-Output "NYI"
}
function Azahar_wideScreenOn(){
	Write-Output "NYI"
}
function Azahar_wideScreenOff(){
	Write-Output "NYI"
}
function Azahar_bezelOn(){
	Write-Output "NYI"
}
function Azahar_bezelOff(){
	Write-Output "NYI"
}
function Azahar_finalize(){
	Write-Output "NYI"
}
function Azahar_IsInstalled(){
	$test=Test-Path -Path "$emusPath\azahar\azahar.exe"
	if($test){
		Write-Output "true"
	}else{
		Write-Output "false"
	}
}
function Azahar_resetConfig(){
	Azahar_init
	if($?){
		Write-Output "true"
	}
}$BigPEmu_configFile="$env:APPDATA/BigPEmu/BigPEmuConfig.bigpcfg"
$BigPEmu_appData="$env:APPDATA/BigPEmu"
function BigPEmu_install(){
    setMSG "Downloading BigPEmu"
    $url_BigPEmu = "https://www.richwhitehouse.com/jaguar/builds/BigPEmu_v117.zip"
    download $url_BigPEmu "bigpemu.zip"
    moveFromTo "$temp\bigpemu" "$emusPath\BigPEmu"
    createLauncher "BigPEmu"
}

function BigPEmu_init(){
    copyFromTo "$env:APPDATA\EmuDeck\backend\configs\bigpemu" "$BigPEmu_appData"
    BigPEmu_setEmulationFolder
    BigPEmu_setupSaves
    BigPEmu_setupStorage
}

function BigPEmu_update(){
    Write-Output "true"
}

function BigPEmu_setEmulationFolder(){
    $jsonContent = Get-Content -Path $BigPEmu_configFile | ConvertFrom-Json
    $jsonContent.BigPEmuConfig.ROMPath = "$emulationPath\roms\atarijaguar"
    $jsonContent | ConvertTo-Json -Depth 100 | Set-Content -Path $BigPEmu_configFile
}

function BigPEmu_setupSaves(){

    setMSG "BigPEmu - Saves Links"

    mkdir $BigPEmu_appData -ErrorAction SilentlyContinue

    $simLinkPath = "$BigPEmu_appData"
    $emuSavePath = "$emulationPath\saves\BigPEmu\saves"
    createSaveLink $simLinkPath $emuSavePath

}

function BigPEmu_setupStorage {

    mkdir "$storagePath/BigPEmu/screenshots" -ErrorAction SilentlyContinue
    createSymlink "$BigPEmu_appData/screenshots" "$storagePath/BigPEmu/screenshots"

}



function BigPEmu_uninstall(){
    rm -fo -r "$emusPath\BigPEmu"
    if($?){
        Write-Output "true"
    }
}

function BigPEmu_IsInstalled(){
    $test=Test-Path -Path "$emusPath\BigPEmu\BigPEmu.exe"
    if($test){
        Write-Output "true"
    }else{
        Write-Output "false"
    }
}

function BigPEmu_resetConfig(){
    BigPEmu_init
    if($?){
        Write-Output "true"
    }
}function Cemu_install(){
	setMSG "Downloading Cemu"
	$url_cemu = getReleaseURLGH 'cemu-project/Cemu' 'zip' 'windows-x64' "ubuntu"
	download $url_cemu "cemu.zip"

	$folderPath = "$temp/cemu"
	$subfolders = Get-ChildItem -Path $folderPath -Directory

	foreach ($subfolder in $subfolders) {
		$subfolderName = $subfolder.Name
		moveFromTo "$temp/cemu/$subfolderName" "$emusPath\cemu"
	}

	Remove-Item -Recurse -Force cemu -ErrorAction SilentlyContinue
	createLauncher "Cemu"

}
function Cemu_init(){
	setMSG "Cemu - Configuration"
	copyFromTo "$env:APPDATA\EmuDeck\backend\configs\cemu" "$emusPath\cemu"
	sedFile "$emusPath\cemu\controllerProfiles\controller0.xml" "DSUController" "XInput"
	#sedFile "$emusPath\cemu\controllerProfiles\Deck-Gamepad-Gyro.xml" "DSUController" "XInput"
	sedFile "$emusPath\cemu\settings.xml" "C:\Emulation" "$emulationPath"

	Cemu_setupSaves



}
function Cemu_update(){
	Write-Output "NYI"
}
function Cemu_setEmulationFolder(){
	Write-Output "NYI"
}

function Cemu_setupSaves(){
	setMSG "Cemu - Saves Links"
	mkdir "$emusPath\cemu\mlc01\usr\" -ErrorAction SilentlyContinue
	$simLinkPath = "$emusPath\cemu\mlc01\usr\save"
	$emuSavePath = "$emulationPath\saves\Cemu\saves"
	createSaveLink $simLinkPath $emuSavePath
	#cloud_sync_save_hash "$savesPath\Cemu"
}

function Cemu_setResolution($resolution){
	Write-Output $resolution
}

function Cemu_setupStorage(){
	Write-Output "NYI"
}
function Cemu_wipe(){
	Write-Output "NYI"
}
function Cemu_uninstall(){
	Remove-Item -path "$emusPath\Cemu" -recurse -force
	if($?){
		Write-Output "true"
	}
}
function Cemu_migrate(){
	Write-Output "NYI"
}
function Cemu_setABXYstyle(){
	Write-Output "NYI"
}
function Cemu_wideScreenOn(){
	Write-Output "NYI"
}
function Cemu_wideScreenOff(){
	Write-Output "NYI"
}
function Cemu_bezelOn(){
	Write-Output "NYI"
}
function Cemu_bezelOff(){
	Write-Output "NYI"
}
function Cemu_finalize(){
	Write-Output "NYI"
}
function Cemu_IsInstalled(){
	$test=Test-Path -Path "$emusPath\cemu"
	if($test){
		Write-Output "true"
	}else{
		Write-Output "false"
	}
}
function Cemu_resetConfig(){
	Cemu_init
	if($?){
		Write-Output "true"
	}
}$Citron_configFile="${emusPath}\citron\user\config\qt-config.ini"

function Citron_install(){
	setMSG "Downloading Citron"
	winget install Microsoft.VCRedist.2015+.x64 --accept-package-agreements --accept-source-agreements
	$url_citron = getLatestReleaseURLGH "citron-emu/citron-mainline" "7z" "windows"
	#$url_citron = "https://github.com/citron-emu/citron-mainline/releases/download/mainline-0-1476/citron-windows-msvc-20230621-e3122c5b4.7z"
	download $url_citron "citron.7z"
	moveFromTo "$temp/citron/citron-windows-msvc" "$emusPath\citron"
	Remove-Item -Recurse -Force citron -ErrorAction SilentlyContinue
	createLauncher "citron"
}
function Citron_init(){

	setMSG "Citron - Configuration"
	mkdir "$emusPath\citron\user\nand\system\Contents\registered" -ErrorAction SilentlyContinue
	mkdir "$emusPath\citron\user\keys" -ErrorAction SilentlyContinue

	$destination="$emusPath\citron\user\config"
	mkdir $destination -ErrorAction SilentlyContinue
	copyFromTo "$env:APPDATA\EmuDeck\backend\configs\citron\config" "$destination"

	#SDL fix
	Copy-Item "$env:APPDATA\EmuDeck\backend\configs\citron\SDL2.dll" -Destination "$emusPath\citron\" -ErrorAction SilentlyContinue -Force

	sedFile $destination\qt-config.ini "C:/Emulation" $emulationPath

	Citron_setupStorage
	Citron_setupSaves
	Citron_setResolution $citronResolution
	createLauncher "Citron"

	ESDE_refreshCustomEmus

}
function Citron_update(){
	Write-Output "NYI"
}
function Citron_setEmulationFolder(){
	Write-Output "NYI"
}
function Citron_setupSaves(){

	setMSG "Citron - Creating Keys & Firmware Links"
	#Firmware
	mkdir "$emusPath\citron\user\nand\system\Contents"  -ErrorAction SilentlyContinue
	$simLinkPath = "$emusPath\citron\user\nand\system\Contents\registered"
	$emuSavePath = "$emulationPath\bios\citron\firmware"
	createSaveLink $simLinkPath $emuSavePath

	#DLCs
	mkdir "$emusPath\citron\user\nand\user\Contents"  -ErrorAction SilentlyContinue
	$simLinkPath = "$emusPath\citron\user\nand\user\Contents\registered"
	$emuSavePath = "$storagePath\citron\storage"
	createSaveLink $simLinkPath $emuSavePath

	#Keys
	$simLinkPath = "$emusPath\citron\user\keys"
	$emuSavePath = "$emulationPath\bios\citron\keys"
	createSaveLink $simLinkPath $emuSavePath

	setMSG "Citron - Saves Links"
	mkdir "$emusPath\citron\user\nand\user"  -ErrorAction SilentlyContinue
	$simLinkPath = "$emusPath\citron\user\nand\user\save"
	$emuSavePath = "$emulationPath\saves\citron\saves"
	createSaveLink $simLinkPath $emuSavePath

	mkdir $emusPath\citron\user\nand\system\save\8000000000000010\su\  -ErrorAction SilentlyContinue
	$simLinkPath = "$emusPath\citron\user\nand\system\save\8000000000000010\su\avators"
	$emuSavePath = "$emulationPath\saves\citron\profiles"
	createSaveLink $simLinkPath $emuSavePath
	#cloud_sync_save_hash "$savesPath\citron"


}
function Citron_setResolution($resolution){
	switch ( $resolution )
	{
		"720P" { $multiplier = 2;  $docked="false"}
		"1080P" { $multiplier = 2; $docked="true"   }
		"1440P" { $multiplier = 3;  $docked="false" }
		"4K" { $multiplier = 3; $docked="true" }
	}

	setConfig "resolution_setup" $multiplier "$emusPath\citron\user\config\qt-config.ini"
	setConfig "use_docked_mode" $docked "$emusPath\citron\user\config\qt-config.ini"

}
function Citron_setupStorage(){
	mkdir "$emulationPath\storage\citron\screenshots" -ErrorAction SilentlyContinue
	mkdir "$emulationPath\storage\citron\dump" -ErrorAction SilentlyContinue
	mkdir "$emulationPath\storage\citron\load" -ErrorAction SilentlyContinue
	mkdir "$emulationPath\storage\citron\nand" -ErrorAction SilentlyContinue
	mkdir "$emulationPath\storage\citron\sdmc" -ErrorAction SilentlyContinue
	mkdir "$emulationPath\storage\citron\tas" -ErrorAction SilentlyContinue
}
function Citron_wipe(){
	Write-Output "NYI"
}
function Citron_uninstall(){
	Remove-Item -path "$emusPath\citron" -recurse -force
	if($?){
		Write-Output "true"
	}
}
function Citron_migrate(){
	Write-Output "NYI"
}
function Citron_setABXYstyle(){
	Write-Output "NYI"
}
function Citron_wideScreenOn(){
	Write-Output "NYI"
}
function Citron_wideScreenOff(){
	Write-Output "NYI"
}
function Citron_bezelOn(){
	Write-Output "NYI"
}
function Citron_bezelOff(){
	Write-Output "NYI"
}
function Citron_finalize(){
	Write-Output "NYI"
}
function Citron_IsInstalled(){
	$test=Test-Path -Path "$emusPath\citron"
	if($test){
		Write-Output "true"
	}else{
		Write-Output "false"
	}
}
function Citron_resetConfig(){
	Citron_init
	if($?){
		Write-Output "true"
	}
}


### Citron EA
function CitronEA_install($tokenValue) {
	$jwtHost = "https://api.citron-emu.org/jwt/installer/"
	$citronEaHost = "https://api.citron-emu.org/downloads/earlyaccess/"
	$user = $null
	$auth = $null

	$length = $tokenValue.Length
	$remainder = $length % 4
	if ($remainder -eq 1) {
		$tokenValue += "==="
	} elseif ($remainder -eq 2) {
		$tokenValue += "=="
	} elseif ($remainder -eq 3) {
		$tokenValue += "="
	}

	$decodedData = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("$tokenValue"))
	$user, $auth = $decodedData.Split(':')

	if ($user -ne $null -and $auth -ne $null) {

		$citronEaMetadata = curl  "https://api.citron-emu.org/downloads/earlyaccess/" | ConvertFrom-Json

		$url_citronEA = ($citronEaMetadata.files | Where-Object { $_.name -match ".*\.7z" }).url

		$jwtHost = "https://api.citron-emu.org/jwt/installer/"

		$headers = @{
			"X-Username" = $user
			"X-Token" = $auth
			"User-Agent" = "EmuDeck"
		}

		$response = Invoke-WebRequest -Uri $jwtHost -Method Post -Headers $headers
		$BEARERTOKEN = $response.Content


		rm -r -fo "$temp/citronEA"-ErrorAction SilentlyContinue > $null
		download $url_citronEA "citronEA.7z" $BEARERTOKEN > $null
		xcopy "$temp\citronEA\citron-windows-msvc-early-access\" "$emusPath\citron\" /H /E /Y > $null
		rm -r -fo "$temp/citronEA" -ErrorAction SilentlyContinue > $null
		#createLauncher "citron"

		#SDL fix
		Copy-Item "$env:APPDATA\EmuDeck\backend\configs\citron\SDL2.dll" -Destination "$emusPath\citron\" -ErrorAction SilentlyContinue -Force

		Write-Host "true"

	} else {
		Write-Host "invalid"
	}

}

function CitronEA_addToken($tokenValue){
	CitronEA_install $tokenValue
}

function CitronEA_IsInstalled() {
	$test=Test-Path -Path "$emusPath\citron"
	if($test){
		Write-Output "true"
	}else{
		Write-Output "false"
	}
}

function CitronEA_uninstall() {
	echo "Begin Citron EA uninstall"
	Write-Output "NYI"
}$Dolphin_emuName="Dolphin"
$Dolphin_emuType="FlatPak"
$Dolphin_emuPath="org.DolphinEmu.dolphin-emu"
$Dolphin_releaseURL=""
$Dolphin_configFile="$emusPath\Dolphin-x64\User\Config\Dolphin.ini"

function Dolphin_install(){
	setMSG "Downloading Dolphin"
	download $url_dolphin "dolphin.7z"
	moveFromTo "$temp/dolphin/Dolphin-x64" "$emusPath\Dolphin-x64"
	Remove-Item -Recurse -Force dolphin -ErrorAction SilentlyContinue
	createLauncher "dolphin"

}
function Dolphin_init(){
	setMSG "Dolphin - Configuration"
	New-Item -Path "$emusPath\Dolphin-x64\portable.txt" -ErrorAction SilentlyContinue
	$destination="$emusPath\Dolphin-x64"
	mkdir $destination -ErrorAction SilentlyContinue

	$destination="$emusPath\Dolphin-x64"
	copyFromTo "$env:APPDATA\EmuDeck\backend\configs\Dolphin" "$destination"
	#Bios Path
	sedFile "$Dolphin_configFile" "/run/media/mmcblk0p1/Emulation/" "$emulationPath"
	sedFile "$Dolphin_configFile" "/run/media/mmcblk0p1/Emulation/roms/gamecube" "$emulationPath\roms\gamecube"
	sedFile "$Dolphin_configFile" "/run/media/mmcblk0p1/Emulation/roms/wii" "$emulationPath\roms\wii"

	sedFile "$Dolphin_configFile" "Emulation" "Emulation\"

	sedFile "$Dolphin_configFile" "/" "\"

	Dolphin_setupSaves
	Dolphin_DynamicInputTextures
	Dolphin_setResolution $dolphinResolution


	if ( "$arDolphin" -eq 169 ){
		Dolphin_wideScreenOn
	}else{
		Dolphin_wideScreenOff
	}

}
function Dolphin_update(){
	Write-Output "NYI"
}
function Dolphin_setEmulationFolder(){
	Write-Output "NYI"
}
function Dolphin_setupSaves(){
	setMSG "Dolphin - Creating Saves Links"
	#Saves GC
	mkdir "$emusPath\Dolphin-x64\User\"  -ErrorAction SilentlyContinue
	$simLinkPath = "$emusPath\Dolphin-x64\User\GC"
	$emuSavePath = "$emulationPath\saves\dolphin\GC"
	createSaveLink $simLinkPath $emuSavePath

	#Saves Wii
	$simLinkPath = "$emusPath\Dolphin-x64\User\Wii"
	$emuSavePath = "$emulationPath\saves\dolphin\Wii"
	createSaveLink $simLinkPath $emuSavePath


	#States
	$simLinkPath = "$emusPath\Dolphin-x64\User\StateSaves"
	$emuSavePath = "$emulationPath\saves\dolphin\states"
	createSaveLink $simLinkPath $emuSavePath

	#cloud_sync_save_hash "$savesPath\dolphin"
}

function Dolphin_setResolution($resolution){

	switch ( $resolution )
	{
		"720P" { $multiplier = 2 }
		"1080P" { $multiplier = 3    }
		"1440P" { $multiplier = 4   }
		"4K" { $multiplier = 6 }
	}

	setConfig "InternalResolution" $multiplier "$emusPath\Dolphin-x64\User\Config\GFX.ini"

}

function Dolphin_setupStorage(){
	Write-Output "NYI"
}
function Dolphin_wipe(){
	Write-Output "NYI"
}
function Dolphin_uninstall(){
	Remove-Item -path "$emusPath\Dolphin" -recurse -force
	if($?){
		Write-Output "true"
	}
}
function Dolphin_migrate(){
	Write-Output "NYI"
}
function Dolphin_setABXYstyle(){
	Write-Output "NYI"
}
function Dolphin_wideScreenOn(){
	setMSG "Dolphin Widescreen On"
	Write-Output ""
	$configFile="$emusPath\Dolphin-x64\User\Config\GFX.ini"
	$wideScreenHack="wideScreenHack"
	$wideScreenHackSetting="wideScreenHack = True"
	$AspectRatio="AspectRatio"

	setSettingNoQuotes $configFile $wideScreenHack "True"
	setSettingNoQuotes $configFile $AspectRatio "1"

}
function Dolphin_wideScreenOff(){
	setMSG "Dolphin Widescreen Of"
	Write-Output ""
	$configFile="$emusPath\Dolphin-x64\User\Config\GFX.ini"
	$wideScreenHack="wideScreenHack"
	$wideScreenHackSetting="wideScreenHack = True"
	$AspectRatio="AspectRatio"

	setSettingNoQuotes $configFile $wideScreenHack "False"
	setSettingNoQuotes $configFile $AspectRatio "0"
}
function Dolphin_bezelOn(){
	Write-Output "NYI"
}
function Dolphin_bezelOff(){
	Write-Output "NYI"
}
function Dolphin_finalize(){
	Write-Output "NYI"
}
function Dolphin_IsInstalled(){
	$test=Test-Path -Path "$emusPath\Dolphin-x64\Dolphin.exe"
	if($test){
		Write-Output "true"
	}else{
		Write-Output "false"
	}
}
function Dolphin_resetConfig(){
	Dolphin_init
	if($?){
		Write-Output "true"
	}
}


function Dolphin_DynamicInputTextures(){
Write-Output "nope"
  #$DIT_releaseURL = getLatestReleaseURLGH "Venomalia/UniversalDynamicInput" "7z"
  #mkdir "$emusPath\Dolphin-x64\User\Load" -ErrorAction SilentlyContinue
  #download $DIT_releaseURL "UniversalDynamicInput.7z"
  #moveFromTo "$temp/UniversalDynamicInput" "$emusPath\Dolphin-x64\User\Load"
}$DuckStation_configFile="$emusPath\duckstation\settings.ini"

function DuckStation_install(){
	setMSG "Downloading DuckStation"
	$url_duck = getLatestReleaseURLGH "stenzek/duckstation" "zip" "windows-x64" "symbols"
	download $url_duck "duckstation.zip"
	moveFromTo "$temp/duckstation" "$emusPath\duckstation"
	createLauncher "duckstation"
}
function DuckStation_init(){
	setMSG "DuckStation - Configuration"
	New-Item -Path "$emusPath\duckstation\portable.txt" -ErrorAction SilentlyContinue
	$destination="$emusPath\duckstation"
	mkdir $destination -ErrorAction SilentlyContinue
	copyFromTo "$env:APPDATA\EmuDeck\backend\configs\DuckStation" "$emusPath\duckstation\"

	#Paths
	sedFile $destination\settings.ini "C:\Emulation" "$emulationPath"

	DuckStation_setupSaves
	DuckStation_setResolution $duckstationResolution

	if ("$achievementsUserToken" -ne "" ){
		DuckStation_retroAchievementsSetLogin
	}

	#
	#New Aspect Ratios
	#

	# Classic 3D Games
	if ( "$arClassic3D" -eq 169 ){
		DuckStation_wideScreenOn
	}else{
		DuckStation_wideScreenOff
	}


}
function DuckStation_update(){
	Write-Output "NYI"
}
function DuckStation_setEmulationFolder(){
	Write-Output "NYI"
}
function DuckStation_setupSaves(){
	setMSG "DuckStation - Creating Saves Links"
	#Saves
	$simLinkPath = "$emusPath\duckstation\memcards"
	$emuSavePath = "$emulationPath\saves\duckstation\saves"
	createSaveLink $simLinkPath $emuSavePath

	#States
	$simLinkPath = "$emusPath\duckstation\savestates"
	$emuSavePath = "$emulationPath\saves\duckstation\states"
	createSaveLink $simLinkPath $emuSavePath
	#cloud_sync_save_hash "$savesPath\duckstation"
}

function DuckStation_setResolution($resolution){
	switch ( $resolution )
	{
		"720P" { $multiplier = 3 }
		"1080P" { $multiplier = 5 }
		"1440P" { $multiplier = 6 }
		"4K" { $multiplier = 9 }
	}

	setConfig "ResolutionScale" $multiplier $DuckStation_configFile
}

function DuckStation_setupStorage(){
	Write-Output "NYI"
}
function DuckStation_wipe(){
	Write-Output "NYI"
}
function DuckStation_uninstall(){
	Remove-Item -path "$emusPath\duckstation" -recurse -force
	if($?){
		Write-Output "true"
	}
}
function DuckStation_migrate(){
	Write-Output "NYI"
}
function DuckStation_setABXYstyle(){
	Write-Output "NYI"
}
function DuckStation_wideScreenOn(){
	Write-Output "NYI"
}
function DuckStation_wideScreenOff(){
	Write-Output "NYI"
}
function DuckStation_bezelOn(){
	Write-Output "NYI"
}
function DuckStation_bezelOff(){
	Write-Output "NYI"
}
function DuckStation_finalize(){
	Write-Output "NYI"
}
function DuckStation_IsInstalled(){
	$test=Test-Path -Path "$emusPath\duckstation\duckstation-qt-x64-ReleaseLTCG.exe"
	if($test){
		Write-Output "true"
	}else{
		Write-Output "false"
	}
}
function DuckStation_resetConfig(){
	DuckStation_init
	if($?){
		Write-Output "true"
	}
}

function DuckStation_wideScreenOn(){
	setConfig "WidescreenHack" "true" "$DuckStation_configFile"
	setConfig "AspectRatio" "16:9" "$DuckStation_configFile"
}
function DuckStation_wideScreenOff(){
	setConfig "WidescreenHack" "false" "$DuckStation_configFile"
	setConfig "AspectRatio" "4:3" "$DuckStation_configFile"
}
function DuckStation_retroAchievementsSetLogin(){
	$content = Get-Content -Path $DuckStation_configFile -Raw
	$content = $content -replace '(?s)(\[Achievements\].*?Enabled\s*=\s*)\w+', "[Cheevos]`nEnabled = true`nUsername = $achievementsUser`nToken = $achievementsUserToken`nChallengeMode = $achievementsHardcore"
	$content | Set-Content -Path $DuckStation_configFile -Encoding UTF8
}$Flycast_configFile="$EmusPath\flycast\emu.cfg"

function Flycast_install(){
	Write-Output "NYI"
	setMSG "Downloading Flycast"
	$url_flycast = getLatestReleaseURLGH "flyinghead/flycast" "zip" "win64"
	download $url_flycast "flycast.zip"
	mkdir "$emusPath\flycast" -ErrorAction SilentlyContinue
	Move-Item -Path "$temp\flycast\flycast.exe" -Destination "$EmusPath\flycast"
	createLauncher "Flycast"
}
function Flycast_init(){
	$destination="$emusPath\flycast"
	copyFromTo "$env:APPDATA\EmuDeck\backend\configs\flycast" "$destination"
	#Flycast_setupStorage
	Flycast_setEmulationFolder
	Flycast_setupSaves
}
function Flycast_update(){
	Write-Output "NYI"
}
function Flycast_setEmulationFolder(){
	sedFile "$PPSSP_configFile" "/run/media/mmcblk0p1/Emulation" "$emulationPath"
	#Setup bios folder
	#mkdir "$biosPath}/flycast/" -ErrorAction SilentlyContinue

}
function Flycast_setupSaves(){

	#Saves
	setMSG "Flycast - Saves Links"

	#Saves
	$simLinkPath = "$emusPath\flycast\data"
	$emuSavePath = "$emulationPath\saves\flycast\saves"
	createSaveLink $simLinkPath $emuSavePath


}
function Flycast_setupStorage(){
	Write-Output "NYI"
}
function Flycast_wipe(){
	Write-Output "NYI"
}
function Flycast_uninstall(){
	Remove-Item -path "$emusPath\Flycast" -recurse -force
	if($?){
		Write-Output "true"
	}
}
function Flycast_migrate(){
	Write-Output "NYI"
}
function Flycast_setABXYstyle(){
	Write-Output "NYI"
}
function Flycast_wideScreenOn(){
	Write-Output "NYI"
}
function Flycast_wideScreenOff(){
	Write-Output "NYI"
}
function Flycast_bezelOn(){
	Write-Output "NYI"
}
function Flycast_bezelOff(){
	Write-Output "NYI"
}
function Flycast_finalize(){
	Write-Output "NYI"
}
function Flycast_IsInstalled(){
	$test=Test-Path -Path "$emusPath\Flycast\flycast.exe"
	if($test){
		Write-Output "true"
	}else{
		Write-Output "false"
	}
}
function Flycast_resetConfig(){
	Flycast_init
	if($?){
		Write-Output "true"
	}
}$MAME_emuName="MAME"
$MAME_configFile="$emusPAth\mame\mame.ini"

function MAME_install(){
	setMSG "Downloading MAME"
	$url_MAME = getLatestReleaseURLGH "mamedev\mame" "exe" "64bit" "symbols"
	download $url_MAME "mame.exe"
	mkdir "$emusPath\mame" -ErrorAction SilentlyContinue
	$installDir="$emusPath\mame"
	Start-Process -FilePath "$temp\mame.exe" -ArgumentList "x", "$temp\mame.7z", "-o$emusPath\mame", "-y", "-b" -Wait

	createLauncher "MAME"
}
function MAME_init(){
	setMSG "MAME - Configuration"
	$destination="$emusPath\mame"
	copyFromTo "$env:APPDATA\EmuDeck\backend\configs\mame" "$destination"

	MAME_setupStorage
	MAME_setEmulationFolder
	MAME_setupSaves
}
function MAME_update(){
	Write-Output "NYI"
}
function MAME_setEmulationFolder(){
		$gameDirOpt='rompath                   '
		$newGameDirOpt="$gameDirOpt""$romsPath\arcade;$biosPath;$biosPath\mame"
		changeLine "$gameDirOpt" "$newGameDirOpt" "$MAME_configFile"

		$samplepathOpt='samplepath                '
		$newSamplepathOpt="$samplepathOpt""$storagePath\mame\samples;samples"
		changeLine "$samplepathOpt" "$newSamplepathOpt" "$MAME_configFile"

		$artpathOpt='artpath                   '
		$newArtpathOpt="$artpathOpt""$storagePath\mame\artwork;artwork"
		changeLine "$artpathOpt" "$newArtpathOpt" "$MAME_configFile"

		$ctrlrpathOpt='ctrlrpath                 '
		$newctrlrpathOpt="$ctrlrpathOpt""$storagePath\mame\ctrlr;ctrlr"
		changeLine "$ctrlrpathOpt" "$newctrlrpathOpt" "$MAME_configFile"

		$inipathOpt='inipath                   '
		$newinipathOpt="$inipathOpt""$storagePath\mame\ini;ini;ini\presets"
		changeLine "$inipathOpt" "$newinipathOpt" "$MAME_configFile"


		$cheatpathOpt='cheatpath                 '
		$newcheatpathOpt="$cheatpathOpt""$storagePath\mame\cheat;cheat"
		changeLine "$cheatpathOpt" "$newcheatpathOpt" "$MAME_configFile"
}
function MAME_setupSaves(){
	setMSG "MAME - Creating Saves Links"

	#Saves
	$nvram_directoryOpt='nvram_directory           '
	$newnvram_directoryOpt="$nvram_directoryOpt""$savesPath\mame\saves"
	mkdir "$savesPath\mame\saves" -ErrorAction SilentlyContinue
	changeLine "$nvram_directoryOpt" "$newnvram_directoryOpt" "$MAME_configFile"

	#States
	state_directoryOpt='state_directory           '
	newstate_directoryOpt="$state_directoryOpt""$savesPath\mame\states"
	mkdir "$savesPath\mame\states" -ErrorAction SilentlyContinue
	changeLine "$state_directoryOpt" "$newstate_directoryOpt" "$MAME_configFile"
}
function MAME_setupStorage(){
	mkdir "$storagePath\mame\samples" -ErrorAction SilentlyContinue
	mkdir "$storagePath\mame\artwork" -ErrorAction SilentlyContinue
	mkdir "$storagePath\mame\ctrlr" -ErrorAction SilentlyContinue
	mkdir "$storagePath\mame\ini" -ErrorAction SilentlyContinue
	mkdir "$storagePath\mame\cheat" -ErrorAction SilentlyContinue
}
function MAME_wipe(){
	Write-Output "NYI"
}
function MAME_uninstall(){
	Remove-Item -path "$emusPath\mame" -recurse -force
	if($?){
		Write-Output "true"
	}else{
		Write-Output "false"
	}
}
function MAME_migrate(){
	Write-Output "NYI"
}
function MAME_setABXYstyle(){
	Write-Output "NYI"
}
function MAME_wideScreenOn(){
	Write-Output "NYI"
}
function MAME_wideScreenOff(){
	Write-Output "NYI"
}
function MAME_bezelOn(){
	Write-Output "NYI"
}
function MAME_bezelOff(){
	Write-Output "NYI"
}
function MAME_finalize(){
	Write-Output "NYI"
}
function MAME_IsInstalled(){
	$test=Test-Path -Path "$emusPath\mame\mame.exe"
	if($test){
		Write-Output "true"
	}else{
		Write-Output "false"
	}
}
function MAME_resetConfig(){
	MAME_init
	if($?){
		Write-Output "true"
	}
}$Model2_emuPath = "$emusPath\m2emulator\EMULATOR.EXE"
$Model2_configFile = "$emusPath\m2emulator\EMULATOR.INI"

$Model2_romsPath = "$emusPath\model2\roms"
$Model2_launcherPath = "$toolsPath\launchers\model-2-emulator.ps1"
$DesktopShortcutPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Model 2 Emulator.lnk"

function Model2_install() {
    setMSG "Installing Model 2 Emulator"
    $url_Model2 = "https://github.com/PhoenixInteractiveNL/edc-repo0004/raw/master/m2emulator/1.1a.7z"
    download $url_Model2 "model2.zip"
    moveFromTo "$temp\model2" "$emusPath\m2emulator"
    createLauncher "Model2"
}

function Model2_init(){

	$destination="$emusPath\m2emulator"

    mkdir -Force "$destination\pfx"

    $sourcePath = "$env:APPDATA\EmuDeck\backend\configs\model2\EMULATOR.ini"
    $destinationPath = "$emusPath\m2emulator\EMULATOR.ini"
    Copy-Item -Path $sourcePath -Destination $destinationPath -Force

    $sourceCFG = "$env:APPDATA\EmuDeck\backend\configs\model2\CFG"
    $destinationCFG = "$destination\CFG"
    Copy-Item -Path $sourceCFG -Destination $destinationCFG -Recurse -Force

    $sourceNVDATA = "$env:APPDATA\EmuDeck\backend\configs\model2\NVDATA"
    $destinationNVDATA = "$destination\NVDATA"
    if (Test-Path $sourceNVDATA) {
        Copy-Item -Path "$sourceNVDATA\*" -Destination $destinationNVDATA -Recurse -Force
    }

    $sourceScripts = "$env:APPDATA\EmuDeck\backend\configs\model2\scripts"
    $destinationScripts = "$destination\scripts"
    if (Test-Path $sourceScripts) {
        Copy-Item -Path "$sourceScripts\*" -Destination $destinationScripts -Recurse -Force
    }

    Model2_setEmulationFolder

}

function Model2_setEmulationFolder(){
	sedFile $Model2_configFile "roms" "$emulationPath\\roms\\model2"
    sedFile $Model2_configFile ":\" ":\\"
}


function Model2_update(){
	 Write-Output "true"
}

function Model2_uninstall(){
	Remove-Item -path "$emusPath\m2emulator" -recurse -force
	if($?){
		Write-Output "true"
	}
}

function Model2_IsInstalled(){
	$test=Test-Path -Path "$emusPath\m2emulator"
	if($test){
		Write-Output "true"
	}else{
		Write-Output "false"
	}
}

function Model2_resetConfig(){
	Model2_init
    if ($?) {
        Write-Output "true"
    } else {
        Write-Output "false"
    }
}

function Model2_setupSaves(){
    Write-Output "NYI"
}$PCSX2QT_configFile="$emusPath\PCSX2-Qt\inis\PCSX2.ini"

function PCSX2QT_install(){
	#$test=Test-Path -Path "$toolsPath\vc_redist.x86.exe"
	winget install Microsoft.VCRedist.2015+.x86 --accept-package-agreements --accept-source-agreements
	setMSG "Downloading PCSX2"
	$url_pcsx2 = getReleaseURLGH "pcsx2/pcsx2" "7z" "windows" "symbols"
	download $url_pcsx2 "pcsx2.7z"
	moveFromTo "$temp\pcsx2" "$emusPath\PCSX2-Qt"
	Remove-Item -Recurse -Force $temp\pcsx2 -ErrorAction SilentlyContinue
	Rename-Item -Path "$emusPath\PCSX2-Qt\pcsx2-qt.exe" -NewName "pcsx2-qtx64.exe" -ErrorAction SilentlyContinue
	createLauncher "pcsx2"
}
function PCSX2QT_init(){
	setMSG "PCSX2 - Configuration"
	$destination="$emusPath\PCSX2-Qt"
	New-Item "$emusPath\PCSX2-Qt\portable.ini" -ErrorAction SilentlyContinue

	copyFromTo "$env:APPDATA\EmuDeck\backend\configs\PCSX2" $destination

	PCSX2QT_setEmulationFolder
	PCSX2QT_setupSaves
	PCSX2QT_setResolution $pcsx2Resolution

	if ("$achievementsUserToken" -ne "" ){
		PCSX2QT_retroAchievementsSetLogin
	}


}
function PCSX2QT_update(){
	Write-Outpute-Output "NYI"
}
function PCSX2QT_setEmulationFolder(){
	sedFile $PCSX2QT_configFile "C:\Emulation" "$emulationPath"
}
function PCSX2QT_setupSaves(){
	#Saves
	setMSG "PCSX2 - Saves Links"
	#memcards
	$simLinkPath = "$emusPath\PCSX2-Qt\memcards"
	$emuSavePath = "$emulationPath\saves\pcsx2\saves"
	createSaveLink $simLinkPath $emuSavePath

	#States
	$simLinkPath = "$emusPath\PCSX2-Qt\sstates"
	$emuSavePath = "$emulationPath\saves\pcsx2\states"
	createSaveLink $simLinkPath $emuSavePath
	#cloud_sync_save_hash "$savesPath\pcsx2"
}
function PCSX2QT_setResolution($resolution){
	switch ( $resolution )
	{
		"720P" { $multiplier = 2 }
		"1080P" { $multiplier = 3    }
		"1440P" { $multiplier = 4   }
		"4K" { $multiplier = 6 }
	}

	setConfig "upscale_multiplier" $multiplier "$PCSX2QT_configFile"
}
function PCSX2QT_setupStorage(){
	Write-Output "NYI"
}
function PCSX2QT_wipe(){
	Write-Output "NYI"
}
function PCSX2QT_uninstall(){
	Remove-Item -path "$emusPath\PCSX2-Qt" -recurse -force
	if($?){
		Write-Output "true"
	}
}
function PCSX2QT_migrate(){
	Write-Output "NYI"
}
function PCSX2QT_setABXYstyle(){
	Write-Output "NYI"
}
function PCSX2QT_wideScreenOn(){
	Write-Output "NYI"
}
function PCSX2QT_wideScreenOff(){
	Write-Output "NYI"
}
function PCSX2QT_bezelOn(){
	Write-Output "NYI"
}
function PCSX2QT_bezelOff(){
	Write-Output "NYI"
}
function PCSX2QT_finalize(){
	Write-Output "NYI"
}
function PCSX2QT_IsInstalled(){
	if(Test-Path -Path "$emusPath\PCSX2-Qt\pcsx2-qtx64.exe"){
		Write-Output "true"
	}else{
		Write-Output "false"
	}
}
function PCSX2QT_resetConfig(){
	PCSX2QT_init
	if($?){
		Write-Output "true"
	}
}

function PCSX2QT_retroAchievementsSetLogin() {
	$content = Get-Content -Path $PCSX2QT_configFile -Raw
	$content = $content -replace '(?s)(\[Achievements\].*?Enabled\s*=\s*)\w+', "[Achievements]`nEnabled = true`nUsername = $achievementsUser`nToken = $achievementsUserToken`nChallengeMode = $achievementsHardcore"
	$content | Set-Content -Path $PCSX2QT_configFile -Encoding UTF8
}$PPSSP_configFile="$emusPath\PPSSPP\memstick\PSP\SYSTEM\ppsspp.ini"
$PPSSP_cheevosTokenFile="$emusPath\PPSSPP\memstick\PSP\SYSTEM\ppsspp_retroachievements.dat"
function PPSSPP_install(){
	$test=Test-Path -Path "$emusPath\ppsspp_win"
	if($test){
		Rename-Item "$emusPath\ppsspp_win" "$emusPath\PPSSPP" -ErrorAction SilentlyContinue
	}
	setMSG "Downloading PPSSPP"
	download $url_PPSSPP "PPSSPP.zip"
	moveFromTo "$temp/PPSSPP" "$emusPath\PPSSPP"
	createLauncher "PPSSPP"
}
function PPSSPP_init(){
	$test=Test-Path -Path "$emusPath\ppsspp_win"
	if($test){
		Rename-Item "$emusPath\ppsspp_win" "$emusPath\PPSSPP" -ErrorAction SilentlyContinue
	}

	$destination="$emusPath\PPSSPP\memstick\PSP\SYSTEM"
	mkdir $destination -ErrorAction SilentlyContinue
	copyFromTo "$env:APPDATA\EmuDeck\backend\configs/PPSSPP/memstick/PSP/SYSTEM" "$destination"

	sedFile "$PPSSP_configFile" "C:/Emulation" "$emulationPath"
	sedFile "$PPSSP_configFile" ":\Emulation" ":/Emulation"

	if ("$achievementsUserToken" -ne "" ){
		PPSSPP_retroAchievementsSetLogin
	}

	PPSSPP_setupSaves
	#PPSSPP_setResolution $ppssppResolution
}
function PPSSPP_update(){
	Write-Output "NYI"
}
function PPSSPP_setEmulationFolder(){
	Write-Output "NYI"
}
function PPSSPP_setupSaves(){
	setMSG "PPSSPP - Saves Links"
	mkdir "$emusPath\PPSSPP\memstick\PSP" -ErrorAction SilentlyContinue
	$simLinkPath = "$emusPath\PPSSPP\memstick\PSP\PPSSPP_STATE"
	$emuSavePath = "$emulationPath\saves\ppsspp\states"
	createSaveLink $simLinkPath $emuSavePath

	$simLinkPath = "$emusPath\PPSSPP\memstick\PSP\SAVEDATA"
	$emuSavePath = "$emulationPath\saves\ppsspp\saves"
	createSaveLink $simLinkPath $emuSavePath
	#cloud_sync_save_hash "$savesPath\ppsspp"

}
function PPSSPP_setResolution($resolution){
	Write-Output $resolution
}
function PPSSPP_setupStorage(){
	Write-Output "NYI"
}
function PPSSPP_wipe(){
	Write-Output "NYI"
}
function PPSSPP_uninstall(){
	Remove-Item -path "$emusPath\PPSSPP" -recurse -force
	if($?){
		Write-Output "true"
	}
}
function PPSSPP_migrate(){
	Write-Output "NYI"
}
function PPSSPP_setABXYstyle(){
	Write-Output "NYI"
}
function PPSSPP_wideScreenOn(){
	Write-Output "NYI"
}
function PPSSPP_wideScreenOff(){
	Write-Output "NYI"
}
function PPSSPP_bezelOn(){
	Write-Output "NYI"
}
function PPSSPP_bezelOff(){
	Write-Output "NYI"
}
function PPSSPP_finalize(){
	Write-Output "NYI"
}
function PPSSPP_IsInstalled(){
	$test=Test-Path -Path "$emusPath\PPSSPP\PPSSPPWindows64.exe"
	if($test){
		Write-Output "true"
	}else{
		Write-Output "false"
	}
}
function PPSSPP_resetConfig(){
	PPSSPP_init
	if($?){
		Write-Output "true"
	}
}


function PPSSPP_retroAchievementsSetLogin(){
	$content = Get-Content -Path $PPSSP_configFile -Raw
	$content = $content -replace '(?s)(\[Achievements\].*?AchievementsEnable\s*=\s*)\w+', "[Achievements]`nAchievementsEnable = true`nAchievementsUserName = $achievementsUser`nAchievementsChallengeMode = $achievementsHardcore"
	$content | Set-Content -Path $DuckStation_configFile -Encoding UTF8
	$achievementsUserToken | Set-Content $PPSSP_cheevosTokenFile -Encoding UTF8
}$Primehack_configFile="$emusPath\primehack\User\Config\Dolphin.ini"

function Primehack_install(){
	setMSG "Downloading PrimeHack"
	#$url_primehack = getLatestReleaseURLGH "shiiion/dolphin" "zip" "zip"
	$url_primehack = "https://github.com/shiiion/dolphin/releases/download/1.0.7a/PrimeHack.Release.v1.0.7a.zip"
	download $url_primehack "PrimeHack.zip"
	moveFromTo "$temp\PrimeHack" "$emusPath\PrimeHack"
	createLauncher "primehack"
}
function Primehack_init(){
	setMSG "Dolphin - Configuration"
	New-Item -Path "$emusPath\primehack\portable.txt" -ErrorAction SilentlyContinue
	$destination="$emusPath\primehack"
	mkdir $destination -ErrorAction SilentlyContinue

	$destination="$emusPath\primehack"
	copyFromTo "$env:APPDATA\EmuDeck\backend\configs\primehack" "$destination"
	#Bios Path
	sedFile $destination\User\Config\Dolphin.ini "/run/media/mmcblk0p1/Emulation/roms/" "$romsPath"
	sedFile $destination\User\Config\Dolphin.ini "/" '\'

	Primehack_setupSaves
	#Dolphin_DynamicInputTextures
	Primehack_setResolution $dolphinResolution
}
function Primehack_update(){
	Write-Output "true"
}
#function Primehack_setEmulationFolder(){
#	gameDirOpt='ISOPath0 = '
#	newGameDirOpt='ISOPath0 = '"${romsPath}/primehack"
#	mkdir newGameDirOpt -ErrorAction SilentlyContinue
#	sedFile "$Primehack_configFile" "$gameDirOpt" $newGameDirOpt"
#}

function Primehack_setupSaves(){
	setMSG "Dolphin - Creating Saves Links"

	#Saves GC
	mkdir "$emusPath\primehack\User" -ErrorAction SilentlyContinue
	$simLinkPath = "$emusPath\primehack\User\GC"
	$emuSavePath = "$emulationPath\saves\primehack\GC"
	createSaveLink $simLinkPath $emuSavePath

	#Saves Wii
	$simLinkPath = "$emusPath\primehack\User\Wii"
	$emuSavePath = "$emulationPath\saves\primehack\Wii"
	createSaveLink $simLinkPath $emuSavePath

	#States
	$simLinkPath = "$emusPath\primehack\User\StateSaves"
	$emuSavePath = "$emulationPath\saves\primehack\states"
	createSaveLink $simLinkPath $emuSavePath
}
function Primehack_setResolution(){
	switch ( $resolution )
	{
		"720P" { $multiplier = 2 }
		"1080P" { $multiplier = 3    }
		"1440P" { $multiplier = 4   }
		"4K" { $multiplier = 6 }
	}
	setConfig "InternalResolution" $multiplier "$emusPath\primehack\User\Config\GFX.ini"
}

function Primehack_setupStorage(){
	Write-Output "true"
}
function Primehack_wipe(){
	Write-Output "true"
}
function Primehack_uninstall(){
	Remove-Item -path "$emusPath\primehack" -recurse -force
	if($?){
		Write-Output "true"
	}
}
function Primehack_migrate(){
	Write-Output "true"
}
function Primehack_setABXYstyle(){
	Write-Output "true"
}
function Primehack_wideScreenOn(){
	Write-Output "true"
}
function Primehack_wideScreenOff(){
	Write-Output "true"
}
function Primehack_bezelOn(){
	Write-Output "true"
}
function Primehack_bezelOff(){
	Write-Output "true"
}
function Primehack_finalize(){
	Write-Output "true"
}
function Primehack_IsInstalled(){
	$test=Test-Path -Path "$emusPath\primehack"
	if($test){
		Write-Output "true"
	}else{
		Write-Output "false"
	}
}
function Primehack_resetConfig(){
	Primehack_init
	if($?){
		Write-Output "true"
	}
}$RPCS3_configFile="$emusPath\RPCS3\config.yml"

function RPCS3_install(){
	setMSG "Downloading RPCS3"
	$url_rpcs3 = getLatestReleaseURLGH "RPCS3/rpcs3-binaries-win" "7z"
	download $url_rpcs3 "rpcs3.7z"
	moveFromTo "$temp/rpcs3" "$emusPath\RPCS3"
	createLauncher "rpcs3"

	#$url_vulkan = "https://sdk.lunarg.com/sdk/download/latest/windows/vulkan-runtime.exe"
	#download $url_vulkan "vulkan-runtime.exe"
	#.\$temp\vulkan-runtime.exe

}
function RPCS3_init(){
	setMSG "RPCS3 - Configuration"
	$destination="$emusPath\RPCS3"
	copyFromTo "$env:APPDATA\EmuDeck\backend\configs\RPCS3" "$destination"
	RPCS3_setResolution $rpcs3Resolution
	RPCS3_setupStorage
	RPCS3_setupSaves
	RPCS3_setEmulationFolder
}
function RPCS3_update(){
	Write-Output "NYI"
}
function RPCS3_setEmulationFolder(){
	sedFile "$emusPath/RPCS3/config/vfs.yml" "C:/Emulation" "$emulationPath"
	sedFile "$emusPath/RPCS3/config/vfs.yml" "\" "/"

}
function RPCS3_renameFolders(){
	Write-Output "Renaming PS3 folders for ESDE compatibility..."

	$basePath = "$romsPath/ps3"
	if (-not (Test-Path $basePath)) {
		Write-Output "The directory $basePath does not exist. Please verify the path."
		return
	}

	$directories = Get-ChildItem -Path $basePath -Directory

	foreach ($directory in $directories) {
		$name = $directory.Name

		# Skip the "shortcuts" folder
		if ($name -ne "shortcuts") {

			if ($name -eq "media.ps3") {
				$newName = "media"
				Rename-Item -Path $directory.FullName -NewName $newName
				Write-Output "Fixed folder '$name' to '$newName'."
			}

			# If the folder name does not end with .ps3, add the extension
			if ($name -eq "media") {
				Write-Output "The folder 'media' does not need to be renamed."
			}elseif (-not $name.EndsWith(".ps3")) {
				$newName = $name + ".ps3"
				Rename-Item -Path $directory.FullName -NewName $newName
				Write-Output "Renamed folder '$name' to '$newName'."
			}
			# Avoid renaming "media" to itself
		}
	}
}
function RPCS3_setResolution($resolution){
	switch ( $resolution )
	{
		"720P" { $res = "100";  }
		"1080P" { $res = "150"; }
		"1440P" { $res = "200"; }
		"4K" { $res = "300"; }
	}
	$destination="$emusPath\RPCS3\config.yml"
	setConfig "Resolution Scale:" $res $destination
	#Fix setConfig =
	sedFile $destination "Resolution Scale:=" "  Resolution Scale: "
}

function RPCS3_setupSaves(){
	setMSG "RPCS3 - Saves Links"
	mkdir "$emulationPath\storage\rpcs3\dev_hdd0\home\00000001\"  -ErrorAction SilentlyContinue
	$simLinkPath = "$emulationPath\storage\rpcs3\dev_hdd0\home\00000001\savedata"
	$emuSavePath = "$savesPath\rpcs3\saves"
	createSaveLink $simLinkPath $emuSavePath
	$simLinkPath = "$emulationPath\storage\rpcs3\dev_hdd0\home\00000001\trophy"
	$emuSavePath = "$savesPath\rpcs3\trophy"
	createSaveLink $simLinkPath $emuSavePath
	#cloud_sync_save_hash "$savesPath\rpcs3"
}

function RPCS3_setupStorage(){
	$SourceFilePath = "$emusPath\RPCS3\dev_hdd0"

	#We move HDD to the Emulation storage folder
	$test=Test-Path -Path "$emusPath\RPCS3\dev_hdd0"
	if($test){
		$userDrive=(Get-Item $emulationPath).PSDrive.Name

		$destinationFree = (Get-PSDrive -Name "$userDrive").Free
		$sizeInGB = [Math]::Round($destinationFree / 1GB)

		$originSize = (Get-ChildItem -Path $SourceFilePath -Recurse | Measure-Object -Property Length -Sum).Sum
		$wshell = New-Object -ComObject Wscript.Shell

		if ( $originSize -gt $destinationFree ){
			$Output = $wshell.Popup("You don't have enough space in your $userDrive drive, free at least $sizeInGB GB")
			exit
		}
		$Output = $wshell.Popup("We are going to move RPCS3 data to your $userDrive/Emulation/storage/rpcs3/dev_hdd0 to optimize storage. This could take long, so please wait until you get a new confirmation window")

		moveFromTo "$emusPath\RPCS3\dev_hdd0" "$emulationPath/storage/rpcs3/dev_hdd0"
		$Output = $wshell.Popup("Migration complete!")
		mkdir "$emulationPath/storage/rpcs3/dev_hdd0/game"  -ErrorAction SilentlyContinue
	}else{
		mkdir "$emulationPath/storage/rpcs3/dev_hdd0/home/00000001/savedata"  -ErrorAction SilentlyContinue
	}
}
function RPCS3_wipe(){
	Write-Output "NYI"
}
function RPCS3_uninstall(){
	Remove-Item -path "$emusPath\RPCS3" -recurse -force
	if($?){
		Write-Output "true"
	}
}
function RPCS3_migrate(){
	Write-Output "NYI"
}
function RPCS3_setABXYstyle(){
	Write-Output "NYI"
}
function RPCS3_wideScreenOn(){
	Write-Output "NYI"
}
function RPCS3_wideScreenOff(){
	Write-Output "NYI"
}
function RPCS3_bezelOn(){
	Write-Output "NYI"
}
function RPCS3_bezelOff(){
	Write-Output "NYI"
}
function RPCS3_finalize(){
	Write-Output "NYI"
}
function RPCS3_IsInstalled(){
	$test=Test-Path -Path "$emusPath\RPCS3"
	if($test){
		Write-Output "true"
	}else{
		Write-Output "false"
	}
}
function RPCS3_resetConfig(){
	RPCS3_init
	if($?){
		Write-Output "true"
	}
}$RetroArch_configFile="$emusPath\RetroArch\retroarch.cfg"

function RetroArch_install(){
	setMSG "Downloading RetroArch"
	download $url_ra "ra.7z"
	moveFromTo "$temp/ra/RetroArch-Win64" "$emusPath\RetroArch"
	Remove-Item -Recurse -Force ra -ErrorAction SilentlyContinue
	createLauncher "retroarch"

	setMSG "Downloading RetroArch Cores"
	mkdir "$emusPath\RetroArch\cores" -ErrorAction SilentlyContinue
	$RAcores = @("a5200_libretro.dll","81_libretro.dll","atari800_libretro.dll","bluemsx_libretro.dll","chailove_libretro.dll","fbneo_libretro.dll","freechaf_libretro.dll","freeintv_libretro.dll","fuse_libretro.dll","gearsystem_libretro.dll","gw_libretro.dll","hatari_libretro.dll","lutro_libretro.dll","mednafen_pcfx_libretro.dll","mednafen_vb_libretro.dll","mednafen_wswan_libretro.dll","mu_libretro.dll","neocd_libretro.dll","nestopia_libretro.dll","nxengine_libretro.dll","o2em_libretro.dll","picodrive_libretro.dll","pokemini_libretro.dll","prboom_libretro.dll","prosystem_libretro.dll","px68k_libretro.dll","quasi88_libretro.dll","scummvm_libretro.dll","squirreljme_libretro.dll","theodore_libretro.dll","uzem_libretro.dll","vecx_libretro.dll","vice_xvic_libretro.dll","virtualjaguar_libretro.dll","x1_libretro.dll","mednafen_lynx_libretro.dll","mednafen_ngp_libretro.dll","mednafen_pce_libretro.dll","mednafen_pce_fast_libretro.dll","mednafen_psx_libretro.dll","mednafen_psx_hw_libretro.dll","mednafen_saturn_libretro.dll","mednafen_supafaust_libretro.dll","mednafen_supergrafx_libretro.dll","blastem_libretro.dll","bluemsx_libretro.dll","bsnes_libretro.dll","bsnes_mercury_accuracy_libretro.dll","cap32_libretro.dll","citra2018_libretro.dll","citra_libretro.dll","crocods_libretro.dll","desmume2015_libretro.dll","desmume_libretro.dll","dolphin_libretro.dll","dosbox_core_libretro.dll","dosbox_pure_libretro.dll","dosbox_svn_libretro.dll","fbalpha2012_cps1_libretro.dll","fbalpha2012_cps2_libretro.dll","fbalpha2012_cps3_libretro.dll","fbalpha2012_libretro.dll","fbalpha2012_neogeo_libretro.dll","fceumm_libretro.dll","fbneo_libretro.dll","flycast_libretro.dll","fmsx_libretro.dll","frodo_libretro.dll","gambatte_libretro.dll","gearboy_libretro.dll","gearsystem_libretro.dll","genesis_plus_gx_libretro.dll","genesis_plus_gx_wide_libretro.dll","gpsp_libretro.dll","handy_libretro.dll","kronos_libretro.dll","mame2000_libretro.dll","mame2003_plus_libretro.dll","mame2010_libretro.dll","mame_libretro.dll","melonds_libretro.dll","melondsds_libretro.dll","mesen_libretro.dll","mesen-s_libretro.dll","mgba_libretro.dll","mupen64plus_next_libretro.dll","nekop2_libretro.dll","np2kai_libretro.dll","nestopia_libretro.dll","parallel_n64_libretro.dll","pcsx2_libretro.dll","pcsx_rearmed_libretro.dll","picodrive_libretro.dll","ppsspp_libretro.dll","puae_libretro.dll","quicknes_libretro.dll","race_libretro.dll","sameboy_libretro.dll","smsplus_libretro.dll","snes9x2010_libretro.dll","snes9x_libretro.dll","stella2014_libretro.dll","stella_libretro.dll","tgbdual_libretro.dll","vbam_libretro.dll","vba_next_libretro.dll","vice_x128_libretro.dll","vice_x64_libretro.dll","vice_x64sc_libretro.dll","vice_xscpu64_libretro.dll","yabasanshiro_libretro.dll","yabause_libretro.dll","bsnes_hd_beta_libretro.dll","swanstation_libretro.dll","opera_libretro.dll")
	$RAcores.count

	foreach ( $core in $RAcores )
	{
		$url= -join("http://buildbot.libretro.com/nightly/windows/x86_64/latest/",$core,".zip")
		Write-Output "Downloading $url"
		downloadCore $url $core
	}
}
function RetroArch_init(){

	#We just convert the SteamOS settings with our windows paths
	Remove-Item $RetroArch_configFile  -ErrorAction SilentlyContinue

	setMSG "RetroArch - Bezels & Filters"
	copyFromTo "$env:APPDATA\EmuDeck\backend\configs\RetroArch" "$emusPath\RetroArch"
	$path="$emusPath\RetroArch\config"
	Get-ChildItem $path -Recurse -Filter *.cfg |
	Foreach-Object {
		$originFile = $_.FullName

		$origin="~/.var/app/org.libretro.RetroArch/config/retroarch/overlays/pegasus/"
		$target="$emusPath\RetroArch\overlays\pegasus\"

		sedFile $originFile $origin $target

		#Video Filters path
		$origin="/app/lib/retroarch/filters/video/"
		$target="$emusPath\RetroArch\filters\video\"

		sedFile $originFile $origin $target
	}

	setMSG "RetroArch - Shaders"
	$path="$emusPath\RetroArch\config"
	Get-ChildItem $path -Recurse -Filter *.glslp |
	Foreach-Object {
		$originFile = $_.FullName

		$origin="/app/share/libretro/shaders/"
		$target=":/shaders/"
		sedFile $originFile $origin $target
	}
	$path="$emusPath\RetroArch\config"
	Get-ChildItem $path -Recurse -Filter *.slangp |
	Foreach-Object {
		$originFile = $_.FullName

		$origin="/app/share/libretro/shaders/"
		$target=":/shaders/"
		sedFile $originFile $origin $target
	}


	#setMSG "RetroArch - Bios & Saves"

	RetroArch_setupSaves

	#retroAchievements
	if ("$achievementsUserToken" -ne "" ){
		RetroArch_retroAchievementsSetLogin
		if ( "$achievementsHardcore" -eq "true" ){
			RetroArch_retroAchievementsHardCoreOn
		}else{
			RetroArch_retroAchievementsHardCoreOff
		}
	}

	#RA Bezels
	RetroArch_setBezels #needs to change

	#RA AutoSave
	if ( "$RAautoSave" -eq "true" ){
		RetroArch_autoSaveOn
	}else{
		RetroArch_autoSaveOff
	}


	#
	#New Shaders
	#Moved before widescreen, so widescreen disabled if needed.
	#

	RetroArch_setShadersCRT
	RetroArch_setShaders3DCRT
	RetroArch_setShadersMAT


	#
	#New Aspect Ratios
	#

	#Sega Games
	#Master System
	#Genesis
	#Sega CD
	#Sega 32X

	switch ($arSega){
	  32 {
		RetroArch_mastersystem_ar32;
		RetroArch_genesis_ar32;
		RetroArch_segacd_ar32
		RetroArch_sega32x_ar32
	  }
	  43 {
		RetroArch_mastersystem_ar43
		RetroArch_genesis_ar43
		RetroArch_segacd_ar43
		RetroArch_sega32x_ar43
		if ( "$RABezels" -eq "true"){
			if ("$doSetupRA" -eq "true" ){
			  RetroArch_mastersystem_bezelOn
			  RetroArch_genesis_bezelOn
			  RetroArch_segacd_bezelOn
			  RetroArch_sega32x_bezelOn
			}
		}
	  }
	}

	#Snes and NES
	switch ($arSnes){
	  87{
		RetroArch_snes_ar87
		RetroArch_nes_ar87
	  }
	  43{
		RetroArch_snes_ar43
		RetroArch_nes_ar43
		if ( "$RABezels" -eq "true" ){
			if( "$doSetupRA" -eq "true" ){
				RetroArch_snes_bezelOn
			}
		}
	  }
	}

	# Classic 3D Games
		#Dreamcast
		#PSX
		#Nintendo 64
		#Saturn
		#Xbox
	if ( "$arClassic3D" -eq 169 ){
			RetroArch_Beetle_PSX_HW_wideScreenOn
			RetroArch_Flycast_wideScreenOn
			RetroArch_dreamcast_bezelOff
			RetroArch_psx_bezelOff
			RetroArch_n64_wideScreenOn
			RetroArch_SwanStation_wideScreenOn
	}else{
		#"SET 4:3"
		RetroArch_Flycast_wideScreenOff
		RetroArch_n64_wideScreenOff
		RetroArch_Beetle_PSX_HW_wideScreenOff
		RetroArch_SwanStation_wideScreenOff


		if ( "$RABezels" -eq "true" ){
			if( "$doSetupRA" -eq "true" ){
			RetroArch_dreamcast_bezelOn
			RetroArch_n64_bezelOn
			RetroArch_psx_bezelOn
			}
		}
	}

	#Bios
	setConfigRA "system_directory" "$biosPath" $RetroArch_configFile


	mkdir "$biosPath/mame/bios" -ErrorAction SilentlyContinue
	mkdir "$biosPath/dc" -ErrorAction SilentlyContinue
	mkdir "$biosPath/neocd" -ErrorAction SilentlyContinue


	"Put your Mame bios here" | Set-Content "$biosPath/mame/bios/readme.txt" -Encoding UTF8
	"Put your Dreamcast bios here" | Set-Content "$biosPath/dc/readme.txt" -Encoding UTF8
	"Put your Neo Geo CD bios here" | Set-Content "$biosPath/neocd/readme.txt" -Encoding UTF8
	"Put your RetroArch, DuckStation, RPCSX2 bios here in this directory, don't create subfolders!" | Set-Content "$biosPath/readme.txt" -Encoding UTF8

	#Ally
	if($device -eq "Asus Rog Ally"){
		setConfigRA "audio_driver" '"wasapi"' $RetroArch_configFile
	}

}
function RetroArch_update(){
	Write-Output "NYI"
}
function RetroArch_setEmulationFolder(){
	Write-Output "NYI"
}
function RetroArch_setupSaves(){
	#Saves
	setMSG "RetroArch - Creating Saves Links"
	$simLinkPath = "$emusPath\RetroArch\saves"
	$emuSavePath = "$emulationPath\saves\retroarch\saves"
	createSaveLink "$simLinkPath" "$emuSavePath"

	#States
	$simLinkPath = "$emusPath\RetroArch\states"
	$emuSavePath = "$emulationPath\saves\retroarch\states"
	createSaveLink "$simLinkPath" "$emuSavePath"
	#cloud_sync_save_hash "$savesPath\retroarch"
}

function RetroArch_setOverride($fileToCheck, $name, $key, $value){
	$path="$emusPath\RetroArch\config"
	Get-ChildItem $path -Recurse -Filter $fileToCheck |
	Foreach-Object {
		$originFile = $_.FullName
		setConfigRA $key $value $originFile
	}
}

function RetroArch_bezelOnAll(){
	$path="$emusPath\RetroArch\config"
	Get-ChildItem $path -Recurse -Filter *.cfg |
	Foreach-Object {
		$originFile = $_.FullName
		setConfigRA "input_overlay_enable" "true" $originFile
		setConfigRA "input_overlay_behind_menu" "true" $originFile
	}
}

function RetroArch_bezelOffAll(){
	$path="$emusPath\RetroArch\config"
	Get-ChildItem $path -Recurse -Filter *.cfg |
	Foreach-Object {
		$originFile = $_.FullName
		setConfigRA "input_overlay_enable" "false" $originFile
		setConfigRA "input_overlay_behind_menu" "true" $originFile
	}
}

function RetroArch_setupStorage(){
	Write-Output "NYI"
}

function RetroArch_setupStorage(){
	Write-Output "NYI"
}
function RetroArch_wipe(){
	Write-Output "NYI"
}
function RetroArch_uninstall(){
	Remove-Item -path "$emusPath\Retroarch" -recurse -force
	if($?){
		Write-Output "true"
	}
}
function RetroArch_migrate(){
	Write-Output "NYI"
}
function RetroArch_setABXYstyle(){
	Write-Output "NYI"
}
function RetroArch_wideScreenOn(){
	Write-Output "NYI"
}
function RetroArch_wideScreenOff(){
	Write-Output "NYI"
}
function RetroArch_bezelOn(){
	Write-Output "NYI"
}
function RetroArch_bezelOff(){
	Write-Output "NYI"
}
function RetroArch_finalize(){
	Write-Output "NYI"
}
function RetroArch_IsInstalled(){
	$test=Test-Path -Path "$emusPath\RetroArch"
	if($test){
		Write-Output "true"
	}else{
		Write-Output "false"
	}
}
function RetroArch_resetConfig{
	RetroArch_init
	if($?){
		Write-Output "true"
	}
}


function RetroArch_wswanc_setConfig(){
	RetroArch_setOverride "wonderswancolor.cfg" "Beetle Cygne"  "input_player1_analog_dpad_mode" "1"
	RetroArch_setOverride "wonderswancolor.cfg" "Beetle WonderSwan"  "input_player1_analog_dpad_mode" "1"
}
function RetroArch_wswanc_bezelOn(){
	RetroArch_setOverride "wonderswancolor.cfg" "Beetle Cygne"  "input_overlay_enable" "false"
	RetroArch_setOverride "wonderswancolor.cfg" "Beetle WonderSwan"  "input_overlay_enable" "false"
}
function RetroArch_wswanc_bezelOff(){
	RetroArch_setOverride "wonderswancolor.cfg" "Beetle Cygne"  "input_overlay_enable" "false"
	RetroArch_setOverride "wonderswancolor.cfg" "Beetle WonderSwan"  "input_overlay_enable" "false"
}
function RetroArch_wswanc_MATshaderOn(){
	RetroArch_setOverride "wonderswancolor.cfg" "Beetle Cygne"  "video_shader_enable" "true"
	RetroArch_setOverride "wonderswancolor.cfg" "Beetle Cygne"	"video_filter" "ED_RM_LINE"
	RetroArch_setOverride "wonderswancolor.cfg" "Beetle Cygne"	"video_smooth" "false"

	RetroArch_setOverride "wonderswancolor.cfg" "Beetle WonderSwan"  "video_shader_enable" "true"
	RetroArch_setOverride "wonderswancolor.cfg" "Beetle WonderSwan"	 "video_filter" "ED_RM_LINE"
	RetroArch_setOverride "wonderswancolor.cfg" "Beetle WonderSwan"	 "video_smooth" "false"
}

function RetroArch_wswanc_MATshaderOff(){
	RetroArch_setOverride "wonderswancolor.cfg" "Beetle Cygne"  "video_shader_enable" "false"
	RetroArch_setOverride "wonderswancolor.cfg" "Beetle Cygne"	"video_filter" "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride "wonderswancolor.cfg" "Beetle Cygne"	"video_smooth" "true"

	RetroArch_setOverride "wonderswancolor.cfg" "Beetle WonderSwan"  "video_shader_enable" "false"
	RetroArch_setOverride "wonderswancolor.cfg" "Beetle WonderSwan"	 "video_filter" "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride "wonderswancolor.cfg" "Beetle WonderSwan"	 "video_smooth" "true"
}

function RetroArch_wswan_setConfig(){
	RetroArch_setOverride "wonderswan.cfg" "Beetle Cygne"  "input_player1_analog_dpad_mode" "1"
	RetroArch_setOverride "wonderswan.cfg" "Beetle WonderSwan"  "input_player1_analog_dpad_mode" "1"
}
function RetroArch_wswan_bezelOn(){
	RetroArch_setOverride "wonderswan.cfg" "Beetle Cygne"  "input_overlay_enable" "false"
	RetroArch_setOverride "wonderswan.cfg" "Beetle WonderSwan"  "input_overlay_enable" "false"
}

function RetroArch_wswan_bezelOff(){
	RetroArch_setOverride "wonderswan.cfg" "Beetle Cygne"  "input_overlay_enable" "false"
	RetroArch_setOverride "wonderswan.cfg" "Beetle WonderSwan"  "input_overlay_enable" "false"
}

function RetroArch_wswan_MATshaderOn(){
	RetroArch_setOverride "wonderswan.cfg" "Beetle Cygne"  "video_shader_enable" "true"
	RetroArch_setOverride "wonderswan.cfg" "Beetle Cygne"	"video_filter" "ED_RM_LINE"
	RetroArch_setOverride "wonderswan.cfg" "Beetle Cygne"	"video_smooth" "false"

	RetroArch_setOverride "wonderswan.cfg" "Beetle WonderSwan"  "video_shader_enable" "true"
	RetroArch_setOverride "wonderswan.cfg" "Beetle WonderSwan"	 "video_filter" "ED_RM_LINE"
	RetroArch_setOverride "wonderswan.cfg" "Beetle WonderSwan"	 "video_smooth" "false"
}

function RetroArch_wswan_MATshaderOff(){
	RetroArch_setOverride "wonderswan.cfg" "Beetle Cygne"  "video_shader_enable" "false"
	RetroArch_setOverride "wonderswan.cfg" "Beetle Cygne"	"video_filter" "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride "wonderswan.cfg" "Beetle Cygne"	"video_smooth" "true"

	RetroArch_setOverride "wonderswan.cfg" "Beetle WonderSwan"  "video_shader_enable" "false"
	RetroArch_setOverride "wonderswan.cfg" "Beetle WonderSwan"	 "video_filter" "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride "wonderswan.cfg" "Beetle WonderSwan"	 "video_smooth" "true"
}

function RetroArch_dolphin_emu_setConfig(){
	RetroArch_setOverride "dolphin_emu.cfg" "dolphin_emu"  "video_driver" "gl"
	RetroArch_setOverride "dolphin_emu.cfg" "dolphin_emu"  "video_driver" "gl"
}

function RetroArch_PPSSPP_setConfig(){
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_auto_frameskip" "disabled"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_block_transfer_gpu" "enabled"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_button_preference" "Cross"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_cheats" "disabled"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_cpu_core" "JIT"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_disable_slow_framebuffer_effects" "disabled"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_fast_memory" "enabled"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_force_lag_sync" "disabled"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_frameskip" "Off"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_frameskiptype" "Number"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_gpu_hardware_transform" "enabled"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_ignore_bad_memory_access" "enabled"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_inflight_frames" "Up"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_internal_resolution" "1440x816"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_io_timing_method" "Fast"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_language" "Automatic"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_lazy_texture_caching" "disabled"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_locked_cpu_speed" "off"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_lower_resolution_for_effects" "Off"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_rendering_mode" "Buffered"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_retain_changed_textures" "disabled"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_software_skinning" "enabled"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_spline_quality" "Low"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_texture_anisotropic_filtering" "off"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_texture_deposterize" "disabled"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_texture_filtering" "Auto"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_texture_replacement" "enabled"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_texture_scaling_level" "Off"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_texture_scaling_type" "xbrz"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_texture_shader" "Off"
	RetroArch_setOverride "psp.cfg" "PPSSPP"  "ppsspp_vertex_cache" "disabled"
}

function RetroArch_pcengine_setConfig(){
	RetroArch_setOverride "pcengine.cfg" "Beetle PCE Fast"  "input_player1_analog_dpad_mode" "1"
	RetroArch_setOverride "pcengine.cfg" "Beetle PCE"  "input_player1_analog_dpad_mode" "1"
}
function RetroArch_pcengine_bezelOn(){
	RetroArch_setOverride "pcengine.cfg" "Beetle PCE Fast"  "aspect_ratio_index" "21"
	RetroArch_setOverride "pcengine.cfg" "Beetle PCE Fast"  "custom_viewport_height" "1200"
	RetroArch_setOverride "pcengine.cfg" "Beetle PCE Fast"  "custom_viewport_x" "0"
	RetroArch_setOverride "pcengine.cfg" "Beetle PCE Fast"  "input_overlay" "$emusPath\RetroArch\overlays\pegasus\pcengine.cfg"
	RetroArch_setOverride "pcengine.cfg" "Beetle PCE Fast"  "input_overlay_aspect_adjust_landscape" "-0.150000"
	RetroArch_setOverride "pcengine.cfg" "Beetle PCE Fast"  "input_overlay_enable" "true"
	RetroArch_setOverride "pcengine.cfg" "Beetle PCE Fast"  "input_overlay_scale_landscape" "1.075000"

	RetroArch_setOverride "pcengine.cfg" "Beetle PCE"  "aspect_ratio_index" "21"
	RetroArch_setOverride "pcengine.cfg" "Beetle PCE"  "custom_viewport_height" "1200"
	RetroArch_setOverride "pcengine.cfg" "Beetle PCE"  "custom_viewport_x" "0"
	RetroArch_setOverride "pcengine.cfg" "Beetle PCE"  "input_overlay" "$emusPath\RetroArch\overlays\pegasus\pcengine.cfg"
	RetroArch_setOverride "pcengine.cfg" "Beetle PCE"  "input_overlay_aspect_adjust_landscape" "-0.150000"
	RetroArch_setOverride "pcengine.cfg" "Beetle PCE"  "input_overlay_enable" "true"
	RetroArch_setOverride "pcengine.cfg" "Beetle PCE"  "input_overlay_scale_landscape" "1.075000"

}

function RetroArch_pcengine_bezelOff(){
	RetroArch_setOverride "pcengine.cfg" "Beetle PCE Fast"  "input_overlay_enable" "false"

	RetroArch_setOverride "pcengine.cfg" "Beetle PCE"  "input_overlay_enable" "false"
}

function RetroArch_pcengine_CRTshaderOn(){
	RetroArch_setOverride "pcengine.cfg" "Beetle PCE Fast"  "video_shader_enable" "true"
	RetroArch_setOverride "pcengine.cfg" "Beetle PCE Fast"	"video_filter" "ED_RM_LINE"
	RetroArch_setOverride "pcengine.cfg" "Beetle PCE Fast"	"video_smooth" "false"

	RetroArch_setOverride "pcengine.cfg" "Beetle PCE"  "video_shader_enable" "true"
	RetroArch_setOverride "pcengine.cfg" "Beetle PCE"	"video_filter" "ED_RM_LINE"
	RetroArch_setOverride "pcengine.cfg" "Beetle PCE"	"video_smooth" "false"
}

function RetroArch_pcengine_CRTshaderOff(){
	RetroArch_setOverride "pcengine.cfg" "Beetle PCE Fast"  "video_shader_enable" "false"
	RetroArch_setOverride "pcengine.cfg" "Beetle PCE Fast"	"video_filter" "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride "pcengine.cfg" "Beetle PCE Fast"	"video_smooth" '"true"'

	RetroArch_setOverride 'pcengine.cfg' 'Beetle PCE'  'video_shader_enable' '"false"'
	RetroArch_setOverride 'pcengine.cfg' 'Beetle PCE'	'video_filter' "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride 'pcengine.cfg' 'Beetle PCE'	'video_smooth' '"true"'
}

function RetroArch_amiga1200_CRTshaderOff(){
	RetroArch_setOverride 'amiga1200.cfg' 'PUAE'  'video_shader_enable' '"false"'
	RetroArch_setOverride 'amiga1200.cfg' 'PUAE'  'video_filter' "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride 'amiga1200.cfg' 'PUAE'  'video_smooth' '"true"'
}

function RetroArch_amiga1200_CRTshaderOn(){
	RetroArch_setOverride 'amiga1200.cfg' 'PUAE'  'video_shader_enable' '"true"'
	RetroArch_setOverride 'amiga1200.cfg' 'PUAE'  'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'amiga1200.cfg' 'PUAE'  'video_smooth' '"false"'
}

function RetroArch_amiga1200_setUpCoreOpt(){
	RetroArch_setOverride 'amiga1200.opt' 'PUAE'  'puae_model' '"A1200"'
}

function RetroArch_nes_setConfig(){
	RetroArch_setOverride 'nes.cfg' 'Mesen'  'input_player1_analog_dpad_mode' '"1"'
	RetroArch_setOverride 'nes.cfg' 'Nestopia'  'input_player1_analog_dpad_mode' '"1"'
}

function RetroArch_nes_bezelOn(){
	RetroArch_setOverride 'nes.cfg' 'Mesen'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\nes.cfg"
	RetroArch_setOverride 'nes.cfg' 'Mesen'  'input_overlay_auto_scale' '"false"'
	RetroArch_setOverride 'nes.cfg' 'Mesen'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'nes.cfg' 'Mesen'  'input_overlay_opacity' '"0.700000"'
	RetroArch_setOverride 'nes.cfg' 'Mesen'  'input_overlay_scale_landscape' '"1.070000"'
	RetroArch_setOverride 'nes.cfg' 'Mesen'  'input_overlay_aspect_adjust_landscape' '"0.100000"'
	RetroArch_setOverride 'nes.cfg' 'Mesen'  'video_scale_integer' '"false"'
	RetroArch_setOverride 'nes.cfg' 'Mesen'  'aspect_ratio_index' '"0"'
	RetroArch_setOverride 'nes.cfg' 'Nestopia'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\nes.cfg"
	RetroArch_setOverride 'nes.cfg' 'Nestopia'  'input_overlay_auto_scale' '"false"'
	RetroArch_setOverride 'nes.cfg' 'Nestopia'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'nes.cfg' 'Nestopia'  'input_overlay_opacity' '"0.700000"'
	RetroArch_setOverride 'nes.cfg' 'Nestopia'  'input_overlay_scale_landscape' '"1.070000"'
	RetroArch_setOverride 'nes.cfg' 'Nestopia'  'input_overlay_aspect_adjust_landscape' '"0.100000"'
	RetroArch_setOverride 'nes.cfg' 'Nestopia'  'video_scale_integer' '"false"'
	RetroArch_setOverride 'nes.cfg' 'Nestopia'  'aspect_ratio_index' '"0"'
}

function RetroArch_nes_bezelOff(){
	RetroArch_setOverride 'nes.cfg' 'Nestopia'  'input_overlay_enable' '"false"'
	RetroArch_setOverride 'nes.cfg' 'Mesen'  'input_overlay_enable' '"false"'
}

function RetroArch_nes_CRTshaderOn(){
	RetroArch_setOverride 'nes.cfg' 'Mesen'  'video_shader_enable' '"true"'
	RetroArch_setOverride 'nes.cfg' 'Mesen'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'nes.cfg' 'Mesen'	'video_smooth' '"false"'

	RetroArch_setOverride 'nes.cfg' 'Nestopia'  'video_shader_enable' '"true"'
	RetroArch_setOverride 'nes.cfg' 'Nestopia'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'nes.cfg' 'Nestopia'	'video_smooth' '"false"'
}

function RetroArch_nes_CRTshaderOff(){
	RetroArch_setOverride 'nes.cfg' 'Mesen'  'video_shader_enable' '"false"'
	RetroArch_setOverride 'nes.cfg' 'Mesen'	'video_filter' "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride 'nes.cfg' 'Mesen'	'video_smooth' '"true"'

	RetroArch_setOverride 'nes.cfg' 'Nestopia'  'video_shader_enable' '"false"'
	RetroArch_setOverride 'nes.cfg' 'Nestopia'	'video_filter' "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride 'nes.cfg' 'Nestopia'	'video_smooth' '"true"'
}

function RetroArch_nes_ar43(){
	#RetroArch_nes_bezelOn
	RetroArch_setOverride 'nes.cfg' 'Nestopia'  'aspect_ratio_index' '"0"'
	RetroArch_setOverride 'nes.cfg' 'Mesen'  'aspect_ratio_index' '"0"'
}

function RetroArch_nes_ar87(){
	RetroArch_setOverride 'nes.cfg' 'Nestopia'  'input_overlay_scale_landscape' '"1.380000"'
	RetroArch_setOverride 'nes.cfg' 'Nestopia'  'input_overlay_aspect_adjust_landscape' '"-0.170000"'
	RetroArch_setOverride 'nes.cfg' 'Nestopia'  'aspect_ratio_index' '"15"'
	RetroArch_setOverride 'nes.cfg' 'Mesen'  'input_overlay_scale_landscape' '"1.380000"'
	RetroArch_setOverride 'nes.cfg' 'Mesen'  'input_overlay_aspect_adjust_landscape' '"-0.170000"'
	RetroArch_setOverride 'nes.cfg' 'Mesen'  'aspect_ratio_index' '"15"'
}

function RetroArch_nes_ar32(){
	RetroArch_setOverride 'nes.cfg' 'Nestopia'  'aspect_ratio_index' '"7"'
	RetroArch_setOverride 'nes.cfg' 'Mesen'  'aspect_ratio_index' '"7"'
	RetroArch_nes_bezelOff
}

function RetroArch_Mupen64Plus_Next_setConfig(){
	RetroArch_setOverride 'n64.cfg' 'Mupen64Plus-Next'  'aspect_ratio_index' '"0"'
	RetroArch_setOverride 'n64.cfg' 'Mupen64Plus-Next'  'video_crop_overscan' '"false"'
	RetroArch_setOverride 'n64.cfg' 'Mupen64Plus-Next'  'video_smooth' 'ED_RM_LINE'
	RetroArch_setOverride 'n64.cfg' 'Mupen64Plus-Next'  'video_shader_enable' '"false"'
	RetroArch_setOverride 'n64.cfg' 'Mupen64Plus-Next'  'input_overlay_auto_scale'  '"false"'
}

function  RetroArch_n64_3DCRTshaderOn(){
	 RetroArch_setOverride 'n64.cfg' 'Mupen64Plus-Next'  'video_shader_enable' '"true"'
	RetroArch_setOverride 'n64.cfg' 'Mupen64Plus-Next'  'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'n64.cfg' 'Mupen64Plus-Next'  'video_smooth' 'ED_RM_LINE'
 }

function RetroArch_n64_3DCRTshaderOff(){
	RetroArch_setOverride 'n64.cfg' 'Mupen64Plus-Next'  'video_shader_enable' '"false"'
	RetroArch_setOverride 'n64.cfg' 'Mupen64Plus-Next'  'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'n64.cfg' 'Mupen64Plus-Next'  'video_smooth' 'ED_RM_LINE'
}

function RetroArch_n64_setConfig(){
	RetroArch_n64_3DCRTshaderOff
}

function RetroArch_lynx_setConfig(){
	RetroArch_setOverride 'lynx.cfg' 'Beetle Lynx'  'input_player1_analog_dpad_mode' '"1"'
	RetroArch_setOverride 'atarilynx.cfg' 'Handy'  'input_player1_analog_dpad_mode' '"1"'
}

function RetroArch_lynx_bezelOn(){
	RetroArch_setOverride 'lynx.cfg' 'Beetle Lynx'  'aspect_ratio_index' '"21"'
	RetroArch_setOverride 'lynx.cfg' 'Beetle Lynx'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\lynx.cfg"
	RetroArch_setOverride 'lynx.cfg' 'Beetle Lynx'  'input_overlay_auto_scale' '"false"'
	RetroArch_setOverride 'lynx.cfg' 'Beetle Lynx'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'lynx.cfg' 'Beetle Lynx'  'input_overlay_opacity' '"0.700000"'
	RetroArch_setOverride 'lynx.cfg' 'Beetle Lynx'  'input_overlay_scale_landscape' '"1.055000"'
	RetroArch_setOverride 'lynx.cfg' 'Beetle Lynx'  'video_scale_integer' '"false"'

	RetroArch_setOverride 'atarilynx.cfg' 'Handy'  'aspect_ratio_index' '"21"'
	RetroArch_setOverride 'atarilynx.cfg' 'Handy'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\lynx.cfg"
	RetroArch_setOverride 'atarilynx.cfg' 'Handy'  'input_overlay_auto_scale' '"false"'
	RetroArch_setOverride 'atarilynx.cfg' 'Handy'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'atarilynx.cfg' 'Handy'  'input_overlay_opacity' '"0.700000"'
	RetroArch_setOverride 'atarilynx.cfg' 'Handy'  'input_overlay_scale_landscape' '"1.055000"'
	RetroArch_setOverride 'atarilynx.cfg' 'Handy'  'video_scale_integer' '"false"'
}

function RetroArch_lynx_bezelOff(){
	RetroArch_setOverride 'lynx.cfg' 'Beetle Lynx'  'input_overlay_enable' '"false"'
	RetroArch_setOverride 'atarilynx.cfg' 'Handy'  'input_overlay_enable' '"false"'
}

function RetroArch_lynx_MATshaderOn(){
	RetroArch_setOverride 'lynx.cfg' 'Beetle Lynx'  'video_shader_enable' 'true'
	RetroArch_setOverride 'lynx.cfg' 'Beetle Lynx'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'lynx.cfg' 'Beetle Lynx'	'video_smooth' '"false"'

	RetroArch_setOverride 'atarilynx.cfg' 'Handy'  'video_shader_enable' 'true'
	RetroArch_setOverride 'atarilynx.cfg' 'Handy'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'atarilynx.cfg' 'Handy'	'video_smooth' '"false"'
}

function RetroArch_lynx_MATshaderOff(){
	RetroArch_setOverride 'lynx.cfg' 'Beetle Lynx'  'video_shader_enable' 'false'
	RetroArch_setOverride 'lynx.cfg' 'Beetle Lynx'	'video_filter' "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride 'lynx.cfg' 'Beetle Lynx'	'video_smooth' '"true"'

	RetroArch_setOverride 'atarilynx.cfg' 'Handy'  'video_shader_enable' 'false'
	RetroArch_setOverride 'atarilynx.cfg' 'Handy'	'video_filter' "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride 'atarilynx.cfg' 'Handy'	'video_smooth' '"true"'
}


function RetroArch_SameBoy_gb_setConfig(){
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'input_player1_analog_dpad_mode' '"1"'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'gambatte_dark_filter_level' '"0"'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'gambatte_gb_bootloader' '"enabled"'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'gambatte_gb_colorization' '"internal"'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'gambatte_gb_hwmode' '"Auto"'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'gambatte_gb_internal_palette' '"GB'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'gambatte_gb_link_mode' '"Not'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'gambatte_gb_link_network_port' '"56400"'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'gambatte_gb_link_network_server_ip_1' '"0"'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'gambatte_gb_link_network_server_ip_10' '"0"'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'gambatte_gb_link_network_server_ip_11' '"0"'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'gambatte_gb_link_network_server_ip_12' '"0"'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'gambatte_gb_link_network_server_ip_2' '"0"'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'gambatte_gb_link_network_server_ip_3' '"0"'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'gambatte_gb_link_network_server_ip_4' '"0"'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'gambatte_gb_link_network_server_ip_5' '"0"'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'gambatte_gb_link_network_server_ip_6' '"0"'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'gambatte_gb_link_network_server_ip_7' '"0"'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'gambatte_gb_link_network_server_ip_8' '"0"'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'gambatte_gb_link_network_server_ip_9' '"0"'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'gambatte_gb_palette_twb64_1' '"TWB64'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'gambatte_gb_palette_twb64_2' '"TWB64'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'gambatte_mix_frames' '"disabled"'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'gambatte_rumble_level' '"10"'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'gambatte_show_gb_link_settings' '"disabled"'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'gambatte_turbo_period' '"4"'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'gambatte_up_down_allowed' '"disabled"'
}

function RetroArch_ngp_setConfig(){
	RetroArch_setOverride 'ngp.cfg' 'Beetle NeoPop'  'input_player1_analog_dpad_mode' '"1"'
}

function RetroArch_ngp_bezelOn(){
	RetroArch_setOverride 'ngp.cfg' 'Beetle NeoPop'  'aspect_ratio_index' '"21"'
	RetroArch_setOverride 'ngp.cfg' 'Beetle NeoPop'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\ngpc.cfg"
	RetroArch_setOverride 'ngp.cfg' 'Beetle NeoPop'  'input_overlay_aspect_adjust_landscape' '"-0.310000"'
	RetroArch_setOverride 'ngp.cfg' 'Beetle NeoPop'  'input_overlay_auto_scale' '"false"'
	RetroArch_setOverride 'ngp.cfg' 'Beetle NeoPop'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'ngp.cfg' 'Beetle NeoPop'  'input_overlay_hide_in_menu' '"false"'
	RetroArch_setOverride 'ngp.cfg' 'Beetle NeoPop'  'input_overlay_scale_landscape' '"1.625000"'
	RetroArch_setOverride 'ngp.cfg' 'Beetle NeoPop'  'input_overlay_x_separation_portrait' '"-0.010000"'
	RetroArch_setOverride 'ngp.cfg' 'Beetle NeoPop'  'input_overlay_y_offset_landscape' '"-0.135000"'
}

function RetroArch_ngp_bezelOff(){
	RetroArch_setOverride 'ngp.cfg' 'Beetle NeoPop'  'input_overlay_enable' '"false"'
}

function RetroArch_ngp_MATshaderOn(){
	RetroArch_setOverride 'ngp.cfg' 'Beetle NeoPop'  'video_shader_enable' 'true'
	RetroArch_setOverride 'ngp.cfg' 'Beetle NeoPop'	 'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'ngp.cfg' 'Beetle NeoPop'	 'video_smooth' '"false"'
}

function RetroArch_ngp_MATshaderOff(){
	RetroArch_setOverride 'ngp.cfg' 'Beetle NeoPop'  'video_shader_enable' 'false'
	RetroArch_setOverride 'ngp.cfg' 'Beetle NeoPop'	 'video_filter' "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride 'ngp.cfg' 'Beetle NeoPop'	 'video_smooth' '"true"'
}

function RetroArch_ngpc_setConfig(){
	RetroArch_setOverride 'ngpc.cfg' 'Beetle NeoPop'  'input_player1_analog_dpad_mode' '"1"'
}

function RetroArch_ngpc_bezelOn(){
	RetroArch_setOverride 'ngpc.cfg' 'Beetle NeoPop'  'aspect_ratio_index' '"21"'
	RetroArch_setOverride 'ngpc.cfg' 'Beetle NeoPop'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\ngpc.cfg"
	RetroArch_setOverride 'ngpc.cfg' 'Beetle NeoPop'  'input_overlay_aspect_adjust_landscape' '"-0.170000"'
	RetroArch_setOverride 'ngpc.cfg' 'Beetle NeoPop'  'input_overlay_auto_scale' '"false"'
	RetroArch_setOverride 'ngpc.cfg' 'Beetle NeoPop'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'ngpc.cfg' 'Beetle NeoPop'  'input_overlay_scale_landscape' '"1.615000"'
	RetroArch_setOverride 'ngpc.cfg' 'Beetle NeoPop'  'input_overlay_x_separation_portrait' '"-0.010000"'
	RetroArch_setOverride 'ngpc.cfg' 'Beetle NeoPop'  'input_overlay_y_offset_landscape' '"-0.135000"'
}

function RetroArch_ngpc_bezelOff(){
	RetroArch_setOverride 'ngpc.cfg' 'Beetle NeoPop'  'input_overlay_enable' '"false"'
}

function RetroArch_ngpc_MATshaderOn(){
	RetroArch_setOverride 'ngpc.cfg' 'Beetle NeoPop'  'video_shader_enable' 'true'
	RetroArch_setOverride 'ngpc.cfg' 'Beetle NeoPop'	 'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'ngpc.cfg' 'Beetle NeoPop'	 'video_smooth' '"false"'
}

function RetroArch_ngpc_MATshaderOff(){
	RetroArch_setOverride 'ngpc.cfg' 'Beetle NeoPop'  'video_shader_enable' 'false'
	RetroArch_setOverride 'ngpc.cfg' 'Beetle NeoPop'	 'video_filter' "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride 'ngpc.cfg' 'Beetle NeoPop'	 'video_smooth' '"true"'
}

function RetroArch_atari2600_setConfig(){
	RetroArch_setOverride 'atari2600.cfg' 'Stella'  'input_player1_analog_dpad_mode' '"1"'
}

function RetroArch_atari2600_bezelOn(){
	RetroArch_setOverride 'atari2600.cfg' 'Stella'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\atari2600.cfg"
	RetroArch_setOverride 'atari2600.cfg' 'Stella'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'atari2600.cfg' 'Stella'  'input_overlay_aspect_adjust_landscape' '"0.095000"'
	RetroArch_setOverride 'atari2600.cfg' 'Stella'  'input_overlay_scale_landscape' '"1.070000"'
	RetroArch_setOverride 'atari2600.cfg' 'Stella'  'aspect_ratio_index' '"0"'
}

function RetroArch_atari2600_bezelOff(){
	RetroArch_setOverride 'atari2600.cfg' 'Stella' 'input_overlay_enable' '"false"'
}

function RetroArch_atari2600_CRTshaderOn(){
	RetroArch_setOverride 'atari2600.cfg' 'Stella' 'video_shader_enable' 'true'
	RetroArch_setOverride 'atari2600.cfg' 'Stella'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'atari2600.cfg' 'Stella'	'video_smooth' '"false"'
}

function RetroArch_atari2600_CRTshaderOff(){
	RetroArch_setOverride 'atari2600.cfg' 'Stella' 'video_shader_enable' '"false"'
	RetroArch_setOverride 'atari2600.cfg' 'Stella'	'video_filter' "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride 'atari2600.cfg' 'Stella'	'video_smooth' '"true"'
}

function RetroArch_mame_setConfig(){
	RetroArch_setOverride 'mame.cfg' 'MAME 2003-Plus'  'input_player1_analog_dpad_mode' '"1"'
	RetroArch_setOverride 'mame.cfg' 'MAME'  'input_player1_analog_dpad_mode' '"1"'
	RetroArch_setOverride 'mame.cfg' 'MAME'  'cheevos_enable = "false"'
}

function RetroArch_mame_bezelOn(){
	RetroArch_setOverride 'mame.cfg' 'MAME 2003-Plus'  'input_overlay_enable' '"false"'
	RetroArch_setOverride 'mame.cfg' 'MAME'  'input_overlay_enable' '"false"'
}

function RetroArch_mame_bezelOff(){
	RetroArch_setOverride 'mame.cfg' 'MAME 2003-Plus'  'input_overlay_enable' '"false"'
	RetroArch_setOverride 'mame.cfg' 'MAME'  'input_overlay_enable' '"false"'
}

function RetroArch_mame_CRTshaderOn(){
	RetroArch_setOverride 'mame.cfg' 'MAME 2003-Plus'  'video_shader_enable' 'true'
	RetroArch_setOverride 'mame.cfg' 'MAME 2003-Plus'   'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'mame.cfg' 'MAME 2003-Plus'	'video_smooth' '"false"'

	RetroArch_setOverride 'mame.cfg' 'MAME'  'video_shader_enable' 'true'
	RetroArch_setOverride 'mame.cfg' 'MAME'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'mame.cfg' 'MAME'	'video_smooth' '"false"'
}

function RetroArch_mame_CRTshaderOff(){
	RetroArch_setOverride 'mame.cfg' 'MAME 2003-Plus'  'video_shader_enable' 'false'
	RetroArch_setOverride 'mame.cfg' 'MAME 2003-Plus'	'video_filter' "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride 'mame.cfg' 'MAME 2003-Plus'	'video_smooth' '"true"'

	RetroArch_setOverride 'mame.cfg' 'MAME'  'video_shader_enable' 'false'
	RetroArch_setOverride 'mame.cfg' 'MAME'	'video_filter' "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride 'mame.cfg' 'MAME'	'video_smooth' '"true"'
}

function RetroArch_neogeo_bezelOn(){
	RetroArch_setOverride 'neogeo.cfg' 'FinalBurn Neo'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\neogeo.cfg"
	RetroArch_setOverride 'neogeo.cfg' 'FinalBurn Neo'  'input_overlay_auto_scale' '"false"'
	RetroArch_setOverride 'neogeo.cfg' 'FinalBurn Neo'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'neogeo.cfg' 'FinalBurn Neo'  'input_overlay_hide_in_menu' '"false"'
	RetroArch_setOverride 'neogeo.cfg' 'FinalBurn Neo'  'input_overlay_scale_landscape' '"1.055000'
}

function RetroArch_neogeo_bezelOff(){
	RetroArch_setOverride 'neogeo.cfg' 'FinalBurn Neo'  'input_overlay_enable' '"false"'
}

function RetroArch_neogeo_CRTshaderOn(){
	RetroArch_setOverride 'neogeo.cfg' 'FinalBurn Neo' 'video_shader_enable' 'true'
	RetroArch_setOverride 'neogeo.cfg' 'FinalBurn Neo'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'neogeo.cfg' 'FinalBurn Neo'	'video_smooth' '"false"'
}

function RetroArch_neogeo_CRTshaderOff(){
	RetroArch_setOverride 'neogeo.cfg' 'FinalBurn Neo' 'video_shader_enable' '"false"'
	RetroArch_setOverride 'neogeo.cfg' 'FinalBurn Neo'	'video_filter' "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride 'neogeo.cfg' 'FinalBurn Neo'	'video_smooth' '"true"'
}

function RetroArch_fbneo_bezelOn(){
	RetroArch_setOverride 'fbneo.cfg' 'FinalBurn Neo'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\neogeo.cfg"
	RetroArch_setOverride 'fbneo.cfg' 'FinalBurn Neo'  'input_overlay_auto_scale' '"false"'
	RetroArch_setOverride 'fbneo.cfg' 'FinalBurn Neo'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'fbneo.cfg' 'FinalBurn Neo'  'input_overlay_hide_in_menu' '"false"'
	RetroArch_setOverride 'fbneo.cfg' 'FinalBurn Neo'  'input_overlay_scale_landscape' '"1.055000'
}

function RetroArch_fbneo_bezelOff(){
	RetroArch_setOverride 'fbneo.cfg' 'FinalBurn Neo'  'input_overlay_enable' '"false"'
}

function RetroArch_fbneo_CRTshaderOn(){
	RetroArch_setOverride 'fbneo.cfg' 'FinalBurn Neo' 'video_shader_enable' 'true'
	RetroArch_setOverride 'fbneo.cfg' 'FinalBurn Neo'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'fbneo.cfg' 'FinalBurn Neo'	'video_smooth' '"false"'
}

function RetroArch_fbneo_CRTshaderOff(){
	RetroArch_setOverride 'fbneo.cfg' 'FinalBurn Neo' 'video_shader_enable' '"false"'
	RetroArch_setOverride 'fbneo.cfg' 'FinalBurn Neo'	'video_filter' "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride 'fbneo.cfg' 'FinalBurn Neo'	'video_smooth' '"true"'
}


function RetroArch_segacd_setConfig(){
	RetroArch_setOverride 'megacd.cfg' 'Genesis Plus GX'  'input_player1_analog_dpad_mode' '"1"'
	RetroArch_setOverride 'segacd.cfg' 'Genesis Plus GX'  'input_player1_analog_dpad_mode' '"1"'
}

function RetroArch_segacd_bezelOn(){
	RetroArch_setOverride 'megacd.cfg' 'Genesis Plus GX'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\segacd.cfg"
	RetroArch_setOverride 'megacd.cfg' 'Genesis Plus GX'  'input_overlay_auto_scale' '"false"'
	RetroArch_setOverride 'megacd.cfg' 'Genesis Plus GX'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'megacd.cfg' 'Genesis Plus GX'  'input_overlay_hide_in_menu' '"false"'
	RetroArch_setOverride 'megacd.cfg' 'Genesis Plus GX'  'input_overlay_scale_landscape' '"1.055000'
	RetroArch_setOverride 'megacd.cfg' 'Genesis Plus GX'  'aspect_ratio_index' '"0"'

	RetroArch_setOverride 'segacd.cfg' 'Genesis Plus GX'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\segacd.cfg"
	RetroArch_setOverride 'segacd.cfg' 'Genesis Plus GX'  'input_overlay_auto_scale' '"false"'
	RetroArch_setOverride 'segacd.cfg' 'Genesis Plus GX'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'segacd.cfg' 'Genesis Plus GX'  'input_overlay_hide_in_menu' '"false"'
	RetroArch_setOverride 'segacd.cfg' 'Genesis Plus GX'  'input_overlay_scale_landscape' '"1.055000'
	RetroArch_setOverride 'segacd.cfg' 'Genesis Plus GX'  'aspect_ratio_index' '"0"'
}
function RetroArch_segacd_bezelOff(){
	RetroArch_setOverride 'megacd.cfg' 'Genesis Plus GX'  'input_overlay_enable' '"false"'
	RetroArch_setOverride 'segacd.cfg' 'Genesis Plus GX'  'input_overlay_enable' '"false"'
}

function RetroArch_segacd_CRTshaderOn(){
	RetroArch_setOverride 'segacd.cfg' 'Genesis Plus GX'  'video_shader_enable' '"true"'
	RetroArch_setOverride 'megacd.cfg' 'Genesis Plus GX'  'video_shader_enable' '"true"'
}

function RetroArch_segacd_CRTshaderOff(){
	RetroArch_setOverride 'segacd.cfg' 'Genesis Plus GX'  'video_shader_enable' '"false"'
	RetroArch_setOverride 'megacd.cfg' 'Genesis Plus GX'  'video_shader_enable' '"false"'
}


function RetroArch_segacd_ar32(){
	RetroArch_setOverride 'segacd.cfg' 'Genesis Plus GX'  'aspect_ratio_index' '"7"'
	RetroArch_setOverride 'megacd.cfg' 'Genesis Plus GX'  'aspect_ratio_index' '"7"'
	RetroArch_segacd_bezelOff
}
function RetroArch_segacd_ar43(){
	RetroArch_setOverride 'segacd.cfg' 'Genesis Plus GX'  'aspect_ratio_index' '"21"'
	RetroArch_setOverride 'megacd.cfg' 'Genesis Plus GX'  'aspect_ratio_index' '"21"'
}

function RetroArch_genesis_setConfig(){
	RetroArch_setOverride 'genesis.cfg' 'Genesis Plus GX'  'input_player1_analog_dpad_mode' '"1"'
	RetroArch_setOverride 'megadrive.cfg' 'Genesis Plus GX'  'input_player1_analog_dpad_mode' '"1"'
}

function RetroArch_genesis_bezelOn(){
	RetroArch_setOverride 'genesis.cfg' 'Genesis Plus GX'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\genesis.cfg"
	RetroArch_setOverride 'genesis.cfg' 'Genesis Plus GX'  'input_overlay_auto_scale' '"false"'
	RetroArch_setOverride 'genesis.cfg' 'Genesis Plus GX'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'genesis.cfg' 'Genesis Plus GX'  'input_overlay_scale_landscape' '"1.055000"'
	RetroArch_setOverride 'genesis.cfg' 'Genesis Plus GX'  'aspect_ratio_index' '"0"'

	RetroArch_setOverride 'megadrive.cfg' 'Genesis Plus GX'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\genesis.cfg"
	RetroArch_setOverride 'megadrive.cfg' 'Genesis Plus GX'  'input_overlay_auto_scale' '"false"'
	RetroArch_setOverride 'megadrive.cfg' 'Genesis Plus GX'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'megadrive.cfg' 'Genesis Plus GX'  'input_overlay_scale_landscape' '"1.055000"'
	RetroArch_setOverride 'megadrive.cfg' 'Genesis Plus GX'  'aspect_ratio_index' '"0"'

}


function RetroArch_genesis_bezelOff(){
	RetroArch_setOverride 'megadrive.cfg' 'Genesis Plus GX'  'input_overlay_enable' '"false"'
	RetroArch_setOverride 'genesis.cfg' 'Genesis Plus GX'  'input_overlay_enable' '"false"'
}

function RetroArch_genesis_ar32(){
	RetroArch_setOverride 'genesis.cfg' 'Genesis Plus GX'  'aspect_ratio_index' '"7"'
	RetroArch_setOverride 'megadrive.cfg' 'Genesis Plus GX'  'aspect_ratio_index' '"7"'
	RetroArch_genesis_bezelOff
}

function RetroArch_genesis_ar43(){
	RetroArch_setOverride 'genesis.cfg' 'Genesis Plus GX'  'aspect_ratio_index' '"21"'
	RetroArch_setOverride 'megadrive.cfg' 'Genesis Plus GX'  'aspect_ratio_index' '"21"'
}

function RetroArch_genesis_CRTshaderOn(){
	RetroArch_setOverride 'genesis.cfg' 'Genesis Plus GX'  'video_shader_enable' '"true"'
	RetroArch_setOverride 'genesis.cfg' 'Genesis Plus GX'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'genesis.cfg' 'Genesis Plus GX'	'video_smooth' '"false"'

	RetroArch_setOverride 'megadrive.cfg' 'Genesis Plus GX'  'video_shader_enable' '"true"'
	RetroArch_setOverride 'megadrive.cfg' 'Genesis Plus GX'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'megadrive.cfg' 'Genesis Plus GX'	'video_smooth' '"false"'
}

function RetroArch_genesis_CRTshaderOff(){
	RetroArch_setOverride 'genesis.cfg' 'Genesis Plus GX'  'video_shader_enable' '"false"'
	RetroArch_setOverride 'genesis.cfg' 'Genesis Plus GX'	'video_filter' "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride 'genesis.cfg' 'Genesis Plus GX'	'video_smooth' '"true"'

	RetroArch_setOverride 'megadrive.cfg' 'Genesis Plus GX'  'video_shader_enable' '"false"'
	RetroArch_setOverride 'megadrive.cfg' 'Genesis Plus GX'	'video_filter' "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride 'megadrive.cfg' 'Genesis Plus GX'	'video_smooth' '"true"'
}

function RetroArch_gamegear_setConfig(){
	RetroArch_setOverride 'gamegear.cfg' 'Genesis Plus GX'  'input_player1_analog_dpad_mode' '"1"'
	RetroArch_setOverride 'gamegear.cfg' 'Gearsystem'  'input_player1_analog_dpad_mode' '"1"'
}

function RetroArch_gamegear_bezelOn(){
	RetroArch_setOverride 'gamegear.cfg' 'Genesis Plus GX'  'aspect_ratio_index' '"21"'
	RetroArch_setOverride 'gamegear.cfg' 'Genesis Plus GX'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\gg.cfg"
	RetroArch_setOverride 'gamegear.cfg' 'Genesis Plus GX'  'input_overlay_aspect_adjust_landscape' '"-0.115000"'
	RetroArch_setOverride 'gamegear.cfg' 'Genesis Plus GX'  'input_overlay_auto_scale' '"false"'
	RetroArch_setOverride 'gamegear.cfg' 'Genesis Plus GX'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'gamegear.cfg' 'Genesis Plus GX'  'input_overlay_scale_landscape' '"1.545000"'

	RetroArch_setOverride 'gamegear.cfg' 'Gearsystem'  'aspect_ratio_index' '"21"'
	RetroArch_setOverride 'gamegear.cfg' 'Gearsystem'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\gg.cfg"
	RetroArch_setOverride 'gamegear.cfg' 'Gearsystem'  'input_overlay_aspect_adjust_landscape' '"-0.115000"'
	RetroArch_setOverride 'gamegear.cfg' 'Gearsystem'  'input_overlay_auto_scale' '"false"'
	RetroArch_setOverride 'gamegear.cfg' 'Gearsystem'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'gamegear.cfg' 'Gearsystem'  'input_overlay_scale_landscape' '"1.545000"'
}

function RetroArch_gamegear_bezelOff(){
	RetroArch_setOverride 'gamegear.cfg' 'Genesis Plus GX'  'input_overlay_enable' '"false"'

	RetroArch_setOverride 'gamegear.cfg' 'Gearsystem'  'input_overlay_enable' '"false"'
}

function RetroArch_gamegear_MATshaderOn(){
	RetroArch_setOverride 'gamegear.cfg' 'Genesis Plus GX'  'video_shader_enable' '"true"'
	RetroArch_setOverride 'gamegear.cfg' 'Genesis Plus GX'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'gamegear.cfg' 'Genesis Plus GX'	'video_smooth' '"false"'

	RetroArch_setOverride 'gamegear.cfg' 'Gearsystem'  'video_shader_enable' '"true"'
	RetroArch_setOverride 'gamegear.cfg' 'Gearsystem'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'gamegear.cfg' 'Gearsystem'	'video_smooth' '"false"'
}

function RetroArch_gamegear_MATshaderOff(){
	RetroArch_setOverride 'gamegear.cfg' 'Genesis Plus GX'  'video_shader_enable' '"false"'
	RetroArch_setOverride 'gamegear.cfg' 'Genesis Plus GX'	'video_filter' "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride 'gamegear.cfg' 'Genesis Plus GX'	'video_smooth' '"true"'

	RetroArch_setOverride 'gamegear.cfg' 'Gearsystem'  'video_shader_enable' '"false"'
	RetroArch_setOverride 'gamegear.cfg' 'Gearsystem'	'video_filter' "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride 'gamegear.cfg' 'Gearsystem'	'video_smooth' '"true"'
}

function RetroArch_mastersystem_setConfig(){
	RetroArch_setOverride 'mastersystem.cfg' 'Genesis Plus GX'  'input_player1_analog_dpad_mode' '"1"'
}

function RetroArch_mastersystem_bezelOn(){
	RetroArch_setOverride 'mastersystem.cfg' 'Genesis Plus GX'  'aspect_ratio_index' '"21"'
	RetroArch_setOverride 'mastersystem.cfg' 'Genesis Plus GX'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\mastersystem.cfg"
	RetroArch_setOverride 'mastersystem.cfg' 'Genesis Plus GX'  'input_overlay_auto_scale' '"false"'
	RetroArch_setOverride 'mastersystem.cfg' 'Genesis Plus GX'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'mastersystem.cfg' 'Genesis Plus GX'  'input_overlay_scale_landscape' '"1.055000"'
}

function RetroArch_mastersystem_bezelOff(){
	RetroArch_setOverride 'mastersystem.cfg' 'Genesis Plus GX'  'input_overlay_enable' '"false"'
}

function RetroArch_mastersystem_ar32(){
	RetroArch_setOverride 'mastersystem.cfg' 'Genesis Plus GX'  'aspect_ratio_index' '"7"'
	RetroArch_mastersystem_bezelOff
}

function RetroArch_mastersystem_CRTshaderOn(){
	RetroArch_setOverride 'mastersystem.cfg' 'Genesis Plus GX'  'video_shader_enable' '"true"'
	RetroArch_setOverride 'mastersystem.cfg' 'Genesis Plus GX'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'mastersystem.cfg' 'Genesis Plus GX'	'video_smooth' '"false"'
}

function RetroArch_mastersystem_CRTshaderOff(){
	RetroArch_setOverride 'mastersystem.cfg' 'Genesis Plus GX'  'video_shader_enable' '"false"'
	RetroArch_setOverride 'mastersystem.cfg' 'Genesis Plus GX'	'video_filter' "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride 'mastersystem.cfg' 'Genesis Plus GX'	'video_smooth' '"true"'
}

function RetroArch_mastersystem_ar43(){
	RetroArch_setOverride 'mastersystem.cfg' 'Genesis Plus GX'  'aspect_ratio_index' '"21"'
}
function RetroArch_sega32x_setConfig(){
	RetroArch_setOverride 'sega32x.cfg' 'PicoDrive'  'input_player1_analog_dpad_mode' '"1"'
}
function RetroArch_sega32x_bezelOn(){
	RetroArch_setOverride 'sega32x.cfg' 'PicoDrive'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\sega32x.cfg"
	RetroArch_setOverride 'sega32x.cfg' 'PicoDrive'  'input_overlay_auto_scale' '"false"'
	RetroArch_setOverride 'sega32x.cfg' 'PicoDrive'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'sega32x.cfg' 'PicoDrive'  'input_overlay_hide_in_menu' '"false"'
	RetroArch_setOverride 'sega32x.cfg' 'PicoDrive'  'input_overlay_scale_landscape' '"1.070000"'
	RetroArch_setOverride 'sega32x.cfg' 'PicoDrive'  'input_overlay_aspect_adjust_landscape' '"0.095000"'
	RetroArch_setOverride 'sega32x.cfg' 'PicoDrive'  'aspect_ratio_index' '"0"'
}

function RetroArch_sega32x_bezelOff(){
	RetroArch_setOverride 'sega32x.cfg' 'PicoDrive'  'input_overlay_enable' '"false"'
}

function RetroArch_sega32x_CRTshaderOn(){
	RetroArch_setOverride 'sega32x.cfg' 'PicoDrive'  'video_shader_enable' '"true"'
	RetroArch_setOverride 'sega32x.cfg' 'PicoDrive'	 'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'sega32x.cfg' 'PicoDrive'	 'video_smooth' '"false"'
}

function RetroArch_sega32x_CRTshaderOff(){
	RetroArch_setOverride 'sega32x.cfg' 'PicoDrive'  'video_shader_enable' '"false"'
	RetroArch_setOverride 'sega32x.cfg' 'PicoDrive'	 'video_filter' "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride 'sega32x.cfg' 'PicoDrive'	 'video_smooth' '"true"'
}

function RetroArch_sega32x_ar32(){
	RetroArch_setOverride 'sega32x.cfg' 'PicoDrive'  'aspect_ratio_index' '"7"'
	RetroArch_sega32x_bezelOff
}

function RetroArch_sega32x_ar43(){
	RetroArch_setOverride 'sega32x.cfg' 'PicoDrive'  'aspect_ratio_index' '"21"'
	RetroArch_sega32x_bezelOff
}

#function RetroArch_gba_bezelOn(){
#	#missing stuff?
#	RetroArch_setOverride 'gba.cfg' 'mGBA'  'aspect_ratio_index' '"21"'
#}
function RetroArch_gba_setConfig(){
	RetroArch_setOverride 'gba.cfg' 'mGBA'  'input_player1_analog_dpad_mode' '"1"'
}
function RetroArch_gba_MATshaderOn(){
	RetroArch_setOverride 'gba.cfg' 'mGBA'  'video_shader_enable' '"true"'
	RetroArch_setOverride 'gba.cfg' 'mGBA'	 'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'gba.cfg' 'mGBA'	 'video_smooth' '"false"'
}

function RetroArch_gba_MATshaderOff(){
	RetroArch_setOverride 'gba.cfg' 'mGBA'  'video_shader_enable' '"false"'
	RetroArch_setOverride 'gba.cfg' 'mGBA'	 'video_filter' "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride 'gba.cfg' 'mGBA'	 'video_smooth' '"true"'
}

function RetroArch_gb_bezelOn(){
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'aspect_ratio_index' '"21"'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\gb.cfg"
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'input_overlay_auto_scale' '"false"'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'input_overlay_scale_landscape' '"1.860000"'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'input_overlay_y_offset_landscape' '"-0.150000"'

	RetroArch_setOverride 'gb.cfg' 'Gambatte'  'aspect_ratio_index' '"21"'
	RetroArch_setOverride 'gb.cfg' 'Gambatte'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\gb.cfg"
	RetroArch_setOverride 'gb.cfg' 'Gambatte'  'input_overlay_auto_scale' '"false"'
	RetroArch_setOverride 'gb.cfg' 'Gambatte'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'gb.cfg' 'Gambatte'  'input_overlay_scale_landscape' '"1.860000"'
	RetroArch_setOverride 'gb.cfg' 'Gambatte'  'input_overlay_y_offset_landscape' '"-0.150000"'
}

function RetroArch_gb_setConfig(){
	RetroArch_setOverride 'gb.cfg' 'Gambatte'  'input_player1_analog_dpad_mode' '"1"'
}

function RetroArch_gb_bezelOff(){
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'input_overlay_enable' '"false"'


	RetroArch_setOverride 'gb.cfg' 'Gambatte'  'input_overlay_enable' '"false"'
}

function RetroArch_gb_MATshaderOn(){
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'video_shader_enable' 'true'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'	 'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'	 'video_smooth' '"false"'

	RetroArch_setOverride 'gb.cfg' 'Gambatte'  'video_shader_enable' '"true"'
	RetroArch_setOverride 'gb.cfg' 'Gambatte'	 'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'gb.cfg' 'Gambatte'	 'video_smooth' '"false"'
}

function RetroArch_gb_MATshaderOff(){
	RetroArch_setOverride 'gb.cfg' 'SameBoy'  'video_shader_enable' 'false'
	RetroArch_setOverride 'gb.cfg' 'SameBoy'	 'video_filter' "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride 'gb.cfg' 'SameBoy'	 'video_smooth' '"true"'

	RetroArch_setOverride 'gb.cfg' 'Gambatte'  'video_shader_enable' '"false"'
	RetroArch_setOverride 'gb.cfg' 'Gambatte'	 'video_filter' "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride 'gb.cfg' 'Gambatte'	 'video_smooth' '"true"'
}

function RetroArch_SameBoy_gbc_setConfig(){
	RetroArch_setOverride 'gbc.cfg' 'SameBoy'  'input_player1_analog_dpad_mode' '"1"'
	RetroArch_setOverride 'gbc.cfg' 'SameBoy'  'gambatte_gbc_color_correction' '"GBC'
	RetroArch_setOverride 'gbc.cfg' 'SameBoy'  'gambatte_gbc_color_correction_mode' '"accurate"'
	RetroArch_setOverride 'gbc.cfg' 'SameBoy'  'gambatte_gbc_frontlight_position' '"central"'
}


function RetroArch_gbc_setConfig(){
	RetroArch_setOverride 'gbc.cfg' 'Gambatte'  'input_player1_analog_dpad_mode' '"1"'
}

function RetroArch_gbc_bezelOn(){
	RetroArch_setOverride 'gbc.cfg' 'SameBoy'  'aspect_ratio_index' '"21"'
	RetroArch_setOverride 'gbc.cfg' 'SameBoy'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\gbc.cfg"
	RetroArch_setOverride 'gbc.cfg' 'SameBoy'  'input_overlay_auto_scale' '"false"'
	RetroArch_setOverride 'gbc.cfg' 'SameBoy'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'gbc.cfg' 'SameBoy'  'input_overlay_scale_landscape' '"1.870000"'
	RetroArch_setOverride 'gbc.cfg' 'SameBoy'  'input_overlay_y_offset_landscape' '"-0.220000"'

	RetroArch_setOverride 'gbc.cfg' 'Gambatte'  'aspect_ratio_index' '"21"'
	RetroArch_setOverride 'gbc.cfg' 'Gambatte'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\gbc.cfg"
	RetroArch_setOverride 'gbc.cfg' 'Gambatte'  'input_overlay_auto_scale' '"false"'
	RetroArch_setOverride 'gbc.cfg' 'Gambatte'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'gbc.cfg' 'Gambatte'  'input_overlay_scale_landscape' '"1.870000"'
	RetroArch_setOverride 'gbc.cfg' 'Gambatte'  'input_overlay_y_offset_landscape' '"-0.220000"'
}

function RetroArch_gbc_bezelOff(){
	RetroArch_setOverride 'gbc.cfg' 'SameBoy'  'input_overlay_enable' '"false"'


	RetroArch_setOverride 'gbc.cfg' 'Gambatte'  'input_overlay_enable' '"false"'
}

function RetroArch_gbc_MATshaderOn(){
	RetroArch_setOverride 'gbc.cfg' 'SameBoy'  'video_shader_enable' 'true'
	RetroArch_setOverride 'gbc.cfg' 'SameBoy'	 'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'gbc.cfg' 'SameBoy'	 'video_smooth' '"false"'

	RetroArch_setOverride 'gbc.cfg' 'Gambatte'  'video_shader_enable' 'true'
	RetroArch_setOverride 'gbc.cfg' 'Gambatte'	 'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'gbc.cfg' 'Gambatte'	 'video_smooth' '"false"'
}

function RetroArch_gbc_MATshaderOff(){
	RetroArch_setOverride 'gbc.cfg' 'SameBoy'  'video_shader_enable' 'false'
	RetroArch_setOverride 'gbc.cfg' 'SameBoy'	 'video_filter' "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride 'gbc.cfg' 'SameBoy'	 'video_smooth' '"true"'

	RetroArch_setOverride 'gbc.cfg' 'Gambatte'  'video_shader_enable' 'false'
	RetroArch_setOverride 'gbc.cfg' 'Gambatte'	 'video_filter' "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride 'gbc.cfg' 'Gambatte'	 'video_smooth' '"true"'
}

function RetroArch_n64_wideScreenOn(){
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-aspect' '"16:9 adjusted"'
	RetroArch_setOverride 'n64.cfg' 'Mupen64Plus-Next'  'aspect_ratio_index' '"1"'
	RetroArch_n64_bezelOff
	RetroArch_n64_3DCRTshaderOff
}

function RetroArch_n64_wideScreenOff(){
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-aspect' '"4:3"'
	RetroArch_setOverride 'n64.cfg' 'Mupen64Plus-Next'  'aspect_ratio_index' '"0"'
	#RetroArch_n64_bezelOn
}

function RetroArch_n64_bezelOn(){
	RetroArch_setOverride 'n64.cfg' 'Mupen64Plus-Next'  'aspect_ratio_index' '"0"'
	RetroArch_setOverride 'n64.cfg' 'Mupen64Plus-Next'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\N64.cfg"
	RetroArch_setOverride 'n64.cfg' 'Mupen64Plus-Next'  'input_overlay_aspect_adjust_landscape' '"0.085000"'
	RetroArch_setOverride 'n64.cfg' 'Mupen64Plus-Next'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'n64.cfg' 'Mupen64Plus-Next'  'input_overlay_scale_landscape' '"1.065000"'
}

function RetroArch_n64_bezelOff(){
	RetroArch_setOverride 'n64.cfg' 'Mupen64Plus-Next'  'input_overlay_enable' '"false"'
}

function RetroArch_atari800_setConfig(){
	RetroArch_setOverride 'atari800.cfg' 'Stella'  'input_player1_analog_dpad_mode' '"1"'
}

function RetroArch_atari800_bezelOn(){
	RetroArch_setOverride 'atari800.cfg' 'Stella'  'aspect_ratio_index' '"0"'
	RetroArch_setOverride 'atari800.cfg' 'Stella'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\atari800.cfg"
	RetroArch_setOverride 'atari800.cfg' 'Stella'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'atari800.cfg' 'Stella'  'input_overlay_hide_in_menu' '"true"'
	RetroArch_setOverride 'atari800.cfg' 'Stella'  'input_overlay_scale_landscape' '"1.175000"'
	RetroArch_setOverride 'atari800.cfg' 'Stella'  'input_overlay_aspect_adjust_landscape' '"0.000000"'
}

function RetroArch_atari800_bezelOff(){
	RetroArch_setOverride 'atari800.cfg' 'Stella'  'input_overlay_enable' '"false"'
}

function RetroArch_atari5200_setConfig(){
	RetroArch_setOverride 'atari5200.cfg' 'Stella'  'input_player1_analog_dpad_mode' '"1"'
}

function RetroArch_atari5200_bezelOn(){
	RetroArch_setOverride 'atari5200.cfg' 'Stella'  'aspect_ratio_index' '"0"'
	RetroArch_setOverride 'atari5200.cfg' 'Stella'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\atari5200.cfg"
	RetroArch_setOverride 'atari5200.cfg' 'Stella'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'atari5200.cfg' 'Stella'  'input_overlay_hide_in_menu' '"true"'
	RetroArch_setOverride 'atari5200.cfg' 'Stella'  'input_overlay_scale_landscape' '"1.175000"'
	RetroArch_setOverride 'atari5200.cfg' 'Stella'  'input_overlay_aspect_adjust_landscape' '"0.000000"'
}

function RetroArch_atari5200_bezelOff(){
	RetroArch_setOverride 'atari5200.cfg' 'Stella'  'input_overlay_enable' '"false"'
}

function RetroArch_dreamcast_bezelOn(){
	RetroArch_setOverride 'dreamcast.cfg' 'Flycast'  'aspect_ratio_index' '"0"'
	RetroArch_setOverride 'dreamcast.cfg' 'Flycast'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\Dreamcast.cfg"
	RetroArch_setOverride 'dreamcast.cfg' 'Flycast'  'input_overlay_aspect_adjust_landscape' '"0.110000"'
	RetroArch_setOverride 'dreamcast.cfg' 'Flycast'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'dreamcast.cfg' 'Flycast'  'input_overlay_scale_landscape' '"1.054998"'
}

function RetroArch_dreamcast_bezelOff(){
	RetroArch_setOverride 'dreamcast.cfg' 'Flycast'  'input_overlay_enable' '"false"'
}

#temporary
function RetroArch_Flycast_bezelOff(){
	RetroArch_dreamcast_bezelOff
}

function RetroArch_Flycast_bezelOn(){
	RetroArch_dreamcast_bezelOn
}

function RetroArch_Beetle_PSX_HW_bezelOff(){
	RetroArch_psx_bezelOff
}

function RetroArch_Beetle_PSX_HW_bezelOn(){
	RetroArch_psx_bezelOn
}

function  RetroArch_dreamcast_3DCRTshaderOn(){
	 RetroArch_setOverride 'dreamcast.cfg' 'Flycast'  'video_shader_enable' '"true"'
	RetroArch_setOverride 'dreamcast.cfg' 'Flycast'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'dreamcast.cfg' 'Flycast'	'video_smooth' 'ED_RM_LINE'
 }

function RetroArch_dreamcast_setConfig(){
	RetroArch_dreamcast_3DCRTshaderOff
}

function RetroArch_dreamcast_3DCRTshaderOff(){
	RetroArch_setOverride 'dreamcast.cfg' 'Flycast'  'video_shader_enable' '"false"'
	RetroArch_setOverride 'dreamcast.cfg' 'Flycast'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'dreamcast.cfg' 'Flycast'	'video_smooth' 'ED_RM_LINE'
}

function RetroArch_saturn_setConfig(){
	RetroArch_setOverride 'saturn.cfg' 'Yabause'  'input_player1_analog_dpad_mode' '"1"'
	RetroArch_setOverride 'saturn.cfg' 'YabaSanshiro'  'input_player1_analog_dpad_mode' '"1"'
	RetroArch_setOverride 'saturn.cfg' 'Kronos'  'input_player1_analog_dpad_mode' '"1"'
	RetroArch_setOverride 'saturn.cfg' 'Beetle Saturn'  'input_player1_analog_dpad_mode' '"1"'
	RetroArch_saturn_3DCRTshaderOff
}

function RetroArch_saturn_bezelOn(){
	RetroArch_setOverride 'saturn.cfg' 'Yabause'  'aspect_ratio_index' '"0"'
	RetroArch_setOverride 'saturn.cfg' 'Yabause'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\saturn.cfg"
	RetroArch_setOverride 'saturn.cfg' 'Yabause'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'saturn.cfg' 'Yabause'  'input_overlay_scale_landscape' '"1.070000"'
	RetroArch_setOverride 'saturn.cfg' 'Yabause'  'input_overlay_aspect_adjust_landscape' '"0.095000"'

	RetroArch_setOverride 'saturn.cfg' 'YabaSanshiro'  'aspect_ratio_index' '"0"'
	RetroArch_setOverride 'saturn.cfg' 'YabaSanshiro'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\saturn.cfg"
	RetroArch_setOverride 'saturn.cfg' 'YabaSanshiro'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'saturn.cfg' 'YabaSanshiro'  'input_overlay_scale_landscape' '"1.070000"'
	RetroArch_setOverride 'saturn.cfg' 'YabaSanshiro'  'input_overlay_aspect_adjust_landscape' '"0.095000"'


	RetroArch_setOverride 'saturn.cfg' 'Kronos'  'aspect_ratio_index' '"0"'
	RetroArch_setOverride 'saturn.cfg' 'Kronos'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\saturn.cfg"
	RetroArch_setOverride 'saturn.cfg' 'Kronos'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'saturn.cfg' 'Kronos'  'input_overlay_scale_landscape' '"1.070000"'
	RetroArch_setOverride 'saturn.cfg' 'Kronos'  'input_overlay_aspect_adjust_landscape' '"0.095000"'

	RetroArch_setOverride 'saturn.cfg' 'Beetle Saturn'  'aspect_ratio_index' '"0"'
	RetroArch_setOverride 'saturn.cfg' 'Beetle Saturn'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\saturn.cfg"
	RetroArch_setOverride 'saturn.cfg' 'Beetle Saturn'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'saturn.cfg' 'Beetle Saturn'  'input_overlay_scale_landscape' '"1.070000"'
	RetroArch_setOverride 'saturn.cfg' 'Beetle Saturn'  'input_overlay_aspect_adjust_landscape' '"0.095000"'
}

function RetroArch_saturn_bezelOff(){
	RetroArch_setOverride 'saturn.cfg' 'Yabause'  'input_overlay_enable' '"false"'
	RetroArch_setOverride 'saturn.cfg' 'YabaSanshiro'  'input_overlay_enable' '"false"'
	RetroArch_setOverride 'saturn.cfg' 'Kronos'  'input_overlay_enable' '"false"'
	RetroArch_setOverride 'saturn.cfg' 'Beetle Saturn'  'input_overlay_enable' '"false"'
}

function  RetroArch_saturn_3DCRTshaderOn(){
	 RetroArch_setOverride 'saturn.cfg' 'Yabause'  'video_shader_enable' '"true"'
	RetroArch_setOverride 'saturn.cfg' 'Yabause'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'saturn.cfg' 'Yabause'	'video_smooth' 'ED_RM_LINE'

	 RetroArch_setOverride 'saturn.cfg' 'YabaSanshiro'  'video_shader_enable' '"true"'
	RetroArch_setOverride 'saturn.cfg' 'YabaSanshiro'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'saturn.cfg' 'YabaSanshiro'	'video_smooth' 'ED_RM_LINE'

	RetroArch_setOverride 'saturn.cfg' 'Kronos'  'video_shader_enable' '"true"'
	RetroArch_setOverride 'saturn.cfg' 'Kronos'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'saturn.cfg' 'Kronos'	'video_smooth' 'ED_RM_LINE'

	 RetroArch_setOverride 'saturn.cfg' 'Beetle Saturn'  'video_shader_enable' '"true"'
	RetroArch_setOverride 'saturn.cfg' 'Beetle Saturn'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'saturn.cfg' 'Beetle Saturn'	'video_smooth' 'ED_RM_LINE'
 }

function RetroArch_saturn_3DCRTshaderOff(){
	RetroArch_setOverride 'saturn.cfg' 'Yabause'  'video_shader_enable' '"false"'
	RetroArch_setOverride 'saturn.cfg' 'YabaSanshiro'  'video_shader_enable' '"false"'
	RetroArch_setOverride 'saturn.cfg' 'Kronos'  'video_shader_enable' '"false"'
	RetroArch_setOverride 'saturn.cfg' 'Beetle Saturn'  'video_shader_enable' '"false"'

	RetroArch_setOverride 'saturn.cfg' 'Yabause'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'saturn.cfg' 'Yabause'	'video_smooth' 'ED_RM_LINE'

	RetroArch_setOverride 'saturn.cfg' 'YabaSanshiro'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'saturn.cfg' 'YabaSanshiro'	'video_smooth' 'ED_RM_LINE'

	RetroArch_setOverride 'saturn.cfg' 'Kronos'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'saturn.cfg' 'Kronos'	'video_smooth' 'ED_RM_LINE'

	RetroArch_setOverride 'saturn.cfg' 'Beetle Saturn'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'saturn.cfg' 'Beetle Saturn'	'video_smooth' 'ED_RM_LINE'
}

function RetroArch_snes_setConfig(){
	RetroArch_setOverride 'snes.cfg' 'Snes9x'  'input_player1_analog_dpad_mode' '"1"'
}

function RetroArch_snes_bezelOn(){
	RetroArch_setOverride 'snes.cfg' 'Snes9x'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\snes.cfg"
	RetroArch_setOverride 'snes.cfg' 'Snes9x'  'input_overlay_auto_scale' '"false"'
	RetroArch_setOverride 'snes.cfg' 'Snes9x'  'input_overlay_enable' '"true"'
	RetroArch_setOverride 'snes.cfg' 'Snes9x'  'input_overlay_opacity' '"0.700000"'
	RetroArch_setOverride 'snes.cfg' 'Snes9x'  'video_scale_integer' '"false"'
}

function RetroArch_snes_bezelOff(){
	RetroArch_setOverride 'snes.cfg' 'Snes9x'  'input_overlay_enable' '"false"'
}

function RetroArch_snes_CRTshaderOn(){
	RetroArch_setOverride 'snes.cfg' 'Snes9x'  'video_shader_enable' '"true"'
	RetroArch_setOverride 'snes.cfg' 'Snes9x'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'snes.cfg' 'Snes9x'	'video_smooth' '"false"'
}

function RetroArch_snes_CRTshaderOff(){
	RetroArch_setOverride 'snes.cfg' 'Snes9x'  'video_shader_enable' '"false"'
	RetroArch_setOverride 'snes.cfg' 'Snes9x'	'video_filter' "$emusPath\RetroArch\filters\video\Normal4x.filt"
	RetroArch_setOverride 'snes.cfg' 'Snes9x'	'video_smooth' '"true"'
}

function RetroArch_snes_ar43(){
	RetroArch_setOverride 'snes.cfg' 'Snes9x'  'aspect_ratio_index' '"0"'
	RetroArch_setOverride 'snes.cfg' 'Snes9x'  'input_overlay_scale_landscape' '"1.055000"'
	RetroArch_setOverride 'snes.cfg' 'Snes9x'  'input_overlay_aspect_adjust_landscape' '"0"'
	RetroArch_setOverride 'snes.cfg' 'Snes9x'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\snes.cfg"
}

function RetroArch_snes_ar87(){
	RetroArch_setOverride 'snes.cfg' 'Snes9x'  'input_overlay' "$emusPath\RetroArch\overlays\pegasus\snes87.cfg"
	RetroArch_setOverride 'snes.cfg' 'Snes9x'  'input_overlay_scale_landscape' '"1.380000"'
	RetroArch_setOverride 'snes.cfg' 'Snes9x'  'input_overlay_aspect_adjust_landscape' '"-0.170000"'
	RetroArch_setOverride 'snes.cfg' 'Snes9x'  'aspect_ratio_index' '"15"'
}

function RetroArch_snes_ar32(){
	RetroArch_setOverride 'snes.cfg' 'Snes9x'  'aspect_ratio_index' '"7"'
	RetroArch_snes_bezelOff
}


#function RetroArch_bsnes_hd_beta_bezelOn(){
# 	RetroArch_setOverride 'sneshd.cfg' 'bsnes-hd beta'  'video_scale_integer' '"false"'
# }

function RetroArch_melonDS_setUpCoreOpt(){
	RetroArch_setOverride 'melonDS.opt' 'melonDS'  'melonds_audio_bitrate' '"Automatic"'
	RetroArch_setOverride 'melonDS.opt' 'melonDS'  'melonds_audio_interpolation' '"None"'
	RetroArch_setOverride 'melonDS.opt' 'melonDS'  'melonds_boot_directly' '"enabled"'
	RetroArch_setOverride 'melonDS.opt' 'melonDS'  'melonds_console_mode' '"DS"'
	RetroArch_setOverride 'melonDS.opt' 'melonDS'  'melonds_dsi_sdcard' '"disabled"'
	RetroArch_setOverride 'melonDS.opt' 'melonDS'  'melonds_hybrid_ratio' '"2"'
	RetroArch_setOverride 'melonDS.opt' 'melonDS'  'melonds_hybrid_small_screen' '"Duplicate"'
	RetroArch_setOverride 'melonDS.opt' 'melonDS'  'melonds_jit_block_size' '"32"'
	RetroArch_setOverride 'melonDS.opt' 'melonDS'  'melonds_jit_branch_optimisations' '"enabled"'
	RetroArch_setOverride 'melonDS.opt' 'melonDS'  'melonds_jit_enable' '"enabled"'
	RetroArch_setOverride 'melonDS.opt' 'melonDS'  'melonds_jit_fast_memory' '"enabled"'
	RetroArch_setOverride 'melonDS.opt' 'melonDS'  'melonds_jit_literal_optimisations' '"enabled"'
	RetroArch_setOverride 'melonDS.opt' 'melonDS'  'melonds_opengl_better_polygons' '"enabled"'
	RetroArch_setOverride 'melonDS.opt' 'melonDS'  'melonds_opengl_filtering' '"nearest"'
	RetroArch_setOverride 'melonDS.opt' 'melonDS'  'melonds_opengl_renderer' '"enabled"'
	RetroArch_setOverride 'melonDS.opt' 'melonDS'  'melonds_opengl_resolution' '"5x native (1280x960)"'
	RetroArch_setOverride 'melonDS.opt' 'melonDS'  'melonds_randomize_mac_address' '"disabled"'
	RetroArch_setOverride 'melonDS.opt' 'melonDS'  'melonds_screen_gap' '"0"'
	RetroArch_setOverride 'melonDS.opt' 'melonDS'  'melonds_screen_layout' '"Hybrid Bottom"'
	RetroArch_setOverride 'melonDS.opt' 'melonDS'  'melonds_swapscreen_mode' '"Toggle"'
	RetroArch_setOverride 'melonDS.opt' 'melonDS'  'melonds_threaded_renderer' '"disabled"'
	RetroArch_setOverride 'melonDS.opt' 'melonDS'  'melonds_touch_mode' '"Touch"'
}

function RetroArch_melonDS_setConfig(){
	RetroArch_setOverride 'nds.cfg' 'melonDS'  'rewind_enable' '"false"'
}

function RetroArch_Mupen64Plus_Next_setUpCoreOpt(){
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-169screensize' '"1920x1080"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-43screensize' '"1280x960"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-alt-map' '"False"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-angrylion-multithread' '"all threads"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-angrylion-overscan' '"disabled"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-angrylion-sync' '"Low"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-angrylion-vioverlay' '"Filtered"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-aspect' '"4:3"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-astick-deadzone' '"15"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-astick-sensitivity' '"100"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-BackgroundMode' '"OnePiece"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-BilinearMode' '"standard"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-CorrectTexrectCoords' '"Auto"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-CountPerOp' '"0"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-CountPerOpDenomPot' '"0"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-cpucore' '"dynamic_recompiler"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-d-cbutton' '"C3"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-DitheringPattern' '"False"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-DitheringQuantization' '"False"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-EnableCopyAuxToRDRAM' '"False"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-EnableCopyColorToRDRAM' '"Async"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-EnableCopyDepthToRDRAM' '"Software"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-EnableEnhancedHighResStorage' '"True"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-EnableEnhancedTextureStorage' '"True"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-EnableFBEmulation' '"True"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-EnableFragmentDepthWrite' '"True"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-EnableHiResAltCRC' '"False"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-EnableHWLighting' '"False"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-EnableInaccurateTextureCoordinates' '"False"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-EnableLegacyBlending' '"False"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-EnableLODEmulation' '"True"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-EnableN64DepthCompare' '"False"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-EnableNativeResFactor' '"4"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-EnableNativeResTexrects' '"Optimized"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-EnableOverscan' '"Enabled"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-EnableShadersStorage' '"True"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-EnableTexCoordBounds' '"True"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-EnableTextureCache' '"True"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-ForceDisableExtraMem' '"False"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-FrameDuping' '"False"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-Framerate' '"Fullspeed"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-FXAA' '"0"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-GLideN64IniBehaviour' '"late"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-HybridFilter' '"False"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-IgnoreTLBExceptions' '"False"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-l-cbutton' '"C2"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-MaxHiResTxVramLimit' '"0"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-MaxTxCacheSize' '"8000"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-MultiSampling' '"0"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-OverscanBottom' '"0"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-OverscanLeft' '"0"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-OverscanRight' '"0"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-OverscanTop' '"0"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-pak1' '"memory"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-pak2' '"none"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-pak3' '"none"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-pak4' '"none"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-parallel-rdp-deinterlace-method' '"Bob"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-parallel-rdp-dither-filter' '"True"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-parallel-rdp-divot-filter' '"True"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-parallel-rdp-downscaling' '"disable"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-parallel-rdp-gamma-dither' '"True"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-parallel-rdp-native-tex-rect' '"True"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-parallel-rdp-native-texture-lod' '"False"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-parallel-rdp-overscan' '"0"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-parallel-rdp-super-sampled-read-back' '"False"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-parallel-rdp-super-sampled-read-back-dither' '"False"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-parallel-rdp-synchronous' '"True"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-parallel-rdp-upscaling' '"1x"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-parallel-rdp-vi-aa' '"True"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-parallel-rdp-vi-bilinear' '"True"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-r-cbutton' '"C1"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-rdp-plugin' '"gliden64"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-RDRAMImageDitheringMode' '"False"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-rsp-plugin' '"hle"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-ThreadedRenderer' '"True"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-txCacheCompression' '"True"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-txEnhancementMode' '"As Is"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-txFilterIgnoreBG' '"True"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-txFilterMode' '"None"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-txHiresEnable' '"True"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-txHiresFullAlphaChannel' '"False"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-u-cbutton' '"C4"'
	RetroArch_setOverride 'Mupen64Plus-Next.opt' 'Mupen64Plus-Next'  'mupen64plus-virefresh' '"Auto"'
}

function RetroArch_Beetle_PSX_HW_setUpCoreOpt(){
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_adaptive_smoothing' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_analog_calibration' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_analog_toggle' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_aspect_ratio' '"corrected"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_cd_access_method' '"sync"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_cd_fastload' '"2x(native)"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_core_timing_fps' '"force_progressive"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_cpu_dynarec' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_cpu_freq_scale' '"100%(native)"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_crop_overscan' '"smart"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_crosshair_color_p1' '"red"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_crosshair_color_p2' '"blue"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_depth' '"16bpp(native)"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_display_internal_fps' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_display_vram' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_dither_mode' '"1x(native)"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_dump_textures' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_dynarec_eventcycles' '"128"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_dynarec_invalidate' '"full"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_enable_memcard1' '"enabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_enable_multitap_port1' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_enable_multitap_port2' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_filter' '"nearest"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_filter_exclude_2d_polygon' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_filter_exclude_sprite' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_frame_duping' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_gpu_overclock' '"1x(native)"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_gte_overclock' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_gun_cursor' '"cross"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_gun_input_mode' '"lightgun"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_image_crop' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_image_offset' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_image_offset_cycles' '"0"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_initial_scanline' '"0"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_initial_scanline_pal' '"0"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_internal_resolution' '"2x"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_last_scanline' '"239"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_last_scanline_pal' '"287"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_line_render' '"default"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_mdec_yuv' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_memcard_left_index' '"0"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_memcard_right_index' '"1"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_mouse_sensitivity' '"100%"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_msaa' '"1x"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_negcon_deadzone' '"0%"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_negcon_response' '"linear"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_override_bios' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_pal_video_timing_override' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_pgxp_2d_tol' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_pgxp_mode' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_pgxp_nclip' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_pgxp_texture' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_pgxp_vertex' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_renderer' '"hardware"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_renderer_software_fb' '"enabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_replace_textures' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_scaled_uv_offset' '"enabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_shared_memory_cards' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_skip_bios' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_super_sampling' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_track_textures' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_use_mednafen_memcard0_method' '"libretro"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_widescreen_hack' '"disabled"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_widescreen_hack_aspect_ratio' '"16:9"'
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_wireframe' '"disabled"'
}

function RetroArch_Flycast_setUpCoreOpt(){
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_allow_service_buttons' '"disabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_alpha_sorting' '"per-triangle (normal)"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_analog_stick_deadzone' '"15%"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_anisotropic_filtering' '"4"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_auto_skip_frame' '"disabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_boot_to_bios' '"disabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_broadcast' '"NTSC"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_cable_type' '"TV'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_custom_textures' '"disabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_delay_frame_swapping' '"disabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_digital_triggers' '"disabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_dump_textures' '"disabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_enable_dsp' '"enabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_enable_purupuru' '"enabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_enable_rttb' '"disabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_fog' '"enabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_force_wince' '"disabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_frame_skipping' '"disabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_gdrom_fast_loading' '"disabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_hle_bios' '"disabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_internal_resolution' '"960x720"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_language' '"English"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_lightgun1_crosshair' '"disabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_lightgun2_crosshair' '"disabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_lightgun3_crosshair' '"disabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_lightgun4_crosshair' '"disabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_mipmapping' '"enabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_oit_abuffer_size' '"512MB"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_per_content_vmus' '"disabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_pvr2_filtering' '"disabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_region' '"USA"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_screen_rotation' '"horizontal"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_show_lightgun_settings' '"disabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_show_vmu_screen_settings' '"disabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_texupscale' '"1"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_texupscale_max_filtered_texture_size' '"256"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_threaded_rendering' '"enabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_trigger_deadzone' '"0%"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_vmu1_pixel_off_color' '"DEFAULT_OFF 01"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_vmu1_pixel_on_color' '"DEFAULT_ON 00"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_vmu1_screen_display' '"disabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_vmu1_screen_opacity' '"100%"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_vmu1_screen_position' '"Upper Left"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_vmu1_screen_size_mult' '"1x"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_vmu2_pixel_off_color' '"DEFAULT_OFF 01"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_vmu2_pixel_on_color' '"DEFAULT_ON 00"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_vmu2_screen_display' '"disabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_vmu2_screen_opacity' '"100%"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_vmu2_screen_position' '"Upper Left"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_vmu2_screen_size_mult' '"1x"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_vmu3_pixel_off_color' '"DEFAULT_OFF 01"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_vmu3_pixel_on_color' '"DEFAULT_ON 00"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_vmu3_screen_display' '"disabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_vmu3_screen_opacity' '"100%"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_vmu3_screen_position' '"Upper Left"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_vmu3_screen_size_mult' '"1x"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_vmu4_pixel_off_color' '"DEFAULT_OFF 01"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_vmu4_pixel_on_color' '"DEFAULT_ON 00"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_vmu4_screen_display' '"disabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_vmu4_screen_opacity' '"100%"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_vmu4_screen_position' '"Upper Left"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_vmu4_screen_size_mult' '"1x"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_volume_modifier_enable' '"enabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_widescreen_cheats' '"disabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_widescreen_hack' '"disabled"'
}

function RetroArch_Gambatte_setUpCoreOpt(){
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_audio_resampler' '"sinc"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_dark_filter_level' '"0"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_gb_bootloader' '"enabled"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_gb_colorization' '"auto"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_gb_hwmode' '"Auto"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_gb_internal_palette' '"GB - DMG"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_gb_link_mode' '"Not Connected"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_gb_link_network_port' '"56400"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_gb_link_network_server_ip_1' '"0"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_gb_link_network_server_ip_10' '"0"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_gb_link_network_server_ip_11' '"0"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_gb_link_network_server_ip_12' '"0"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_gb_link_network_server_ip_2' '"0"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_gb_link_network_server_ip_3' '"0"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_gb_link_network_server_ip_4' '"0"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_gb_link_network_server_ip_5' '"0"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_gb_link_network_server_ip_6' '"0"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_gb_link_network_server_ip_7' '"0"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_gb_link_network_server_ip_8' '"0"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_gb_link_network_server_ip_9' '"0"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_gb_palette_pixelshift_1' '"PixelShift 01 - Arctic Green"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_gb_palette_twb64_1' '"WB64 001 - Aqours Blue"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_gb_palette_twb64_2' '"TWB64 101 - 765PRO Pink"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_gbc_color_correction' '"GBC only"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_gbc_color_correction_mode' '"accurate"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_gbc_frontlight_position' '"central"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_mix_frames' '"disabled"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_rumble_level' '"10"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_show_gb_link_settings' '"disabled"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_turbo_period' '"4"'
	RetroArch_setOverride 'Gambatte.opt' 'Gambatte'  'gambatte_up_down_allowed' '"disabled"'
}

function RetroArch_Nestopia_setUpCoreOpt(){
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_arkanoid_device' '"mouse"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_aspect' '"auto"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_audio_vol_dpcm' '"100"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_audio_vol_fds' '"100"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_audio_vol_mmc5' '"100"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_audio_vol_n163' '"100"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_audio_vol_noise' '"100"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_audio_vol_s5b' '"100"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_audio_vol_sq1' '"100"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_audio_vol_sq2' '"100"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_audio_vol_tri' '"100"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_audio_vol_vrc6' '"100"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_audio_vol_vrc7' '"100"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_blargg_ntsc_filter' '"disabled"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_button_shift' '"disabled"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_favored_system' '"auto"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_fds_auto_insert' '"enabled"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_genie_distortion' '"disabled"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_nospritelimit' '"disabled"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_overclock' '"1x"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_overscan_h' '"disabled"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_overscan_v' '"enabled"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_palette' '"cxa2025as"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_ram_power_state' '"0x00"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_select_adapter' '"auto"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_show_advanced_av_settings' '"disabled"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_show_crosshair' '"enabled"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_turbo_pulse' '"2"'
	RetroArch_setOverride 'Nestopia.opt' 'Nestopia'  'nestopia_zapper_device' '"lightgun"'
}
function RetroArch_bsnes_hd_beta_setUpCoreOpt(){
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_blur_emulation' '"OFF"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_coprocessor_delayed_sync' '"ON"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_coprocessor_prefer_hle' '"ON"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_cpu_fastmath' '"OFF"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_cpu_overclock' '"100"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_cpu_sa1_overclock' '"100"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_cpu_sfx_overclock' '"100"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_dsp_cubic' '"OFF"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_dsp_echo_shadow' '"OFF"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_dsp_fast' '"ON"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_entropy' '"Low"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_hotfixes' '"OFF"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_ips_headered' '"OFF"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_mode7_bgGrad' '"4"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_mode7_igwin' '"outside"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_mode7_igwinx' '"128"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_mode7_mosaic' '"1x scale"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_mode7_perspective' '"on'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_mode7_scale' '"1x"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_mode7_strWin' '"OFF"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_mode7_supersample' '"none"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_mode7_widescreen' '"16:10"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_mode7_windRad' '"0"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_mode7_wsbg1' '"auto horz and vert"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_mode7_wsbg2' '"auto horz and vert"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_mode7_wsbg3' '"auto horz and vert"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_mode7_wsbg4' '"auto horz and vert"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_mode7_wsBgCol' '"auto"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_mode7_wsMarker' '"none"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_mode7_wsMarkerAlpha' '"1/1"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_mode7_wsMode' '"all"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_mode7_wsobj' '"safe"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_ppu_deinterlace' '"ON"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_ppu_fast' '"ON"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_ppu_no_sprite_limit' '"ON"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_ppu_no_vram_blocking' '"OFF"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_ppu_show_overscan' '"OFF"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_run_ahead_frames' '"OFF"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_sgb_bios' '"SGB1.sfc"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_video_aspectcorrection' '"OFF"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_video_gamma' '"100"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_video_luminance' '"100"'
	RetroArch_setOverride 'bsnes-hd beta.opt' 'bsnes-hd beta'  'bsnes_video_saturation' '"100"'
}

function RetroArch_Flycast_wideScreenOn(){
	RetroArch_setOverride 'Flycast.opt' 	'Flycast'  	'reicast_widescreen_cheats' 	'"enabled"'
	RetroArch_setOverride 'Flycast.opt' 	'Flycast'  	'reicast_widescreen_hack' 	'"enabled"'
	RetroArch_setOverride 'dreamcast.cfg' 	'Flycast'  	'aspect_ratio_index' 		'"1"'
	RetroArch_dreamcast_bezelOff
	RetroArch_dreamcast_3DCRTshaderOff
}

function RetroArch_Flycast_wideScreenOff(){
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_widescreen_cheats' '"disabled"'
	RetroArch_setOverride 'Flycast.opt' 'Flycast'  'reicast_widescreen_hack' '"disabled"'
	RetroArch_setOverride 'dreamcast.cfg' 'Flycast'  'aspect_ratio_index' '"0"'
}

function RetroArch_Beetle_PSX_HW_wideScreenOn(){
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_widescreen_hack' '"enabled"'
	RetroArch_setOverride 'Beetle PSX.opt' 'Beetle PSX'  'beetle_psx_hw_widescreen_hack' '"enabled"'
	RetroArch_psx_bezelOff
}

function RetroArch_Beetle_PSX_HW_wideScreenOff(){
	RetroArch_setOverride 'Beetle PSX HW.opt' 'Beetle PSX HW'  'beetle_psx_hw_widescreen_hack' '"disabled"'
	RetroArch_setOverride 'Beetle PSX.opt' 'Beetle PSX'  'beetle_psx_hw_widescreen_hack' '"disabled"'
}


function RetroArch_SwanStation_setConfig(){
	RetroArch_setOverride 'SwanStation.opt' 'SwanStation'  'duckstation_GPU.ResolutionScale' '"3"'
}

function RetroArch_SwanStation_wideScreenOn(){
	RetroArch_setOverride 'SwanStation.opt' 'SwanStation'  'duckstation_GPU.WidescreenHack' '"true"'
	RetroArch_setOverride 'SwanStation.opt' 'SwanStation'  'duckstation_Display.AspectRatio' '"16:9"'
	RetroArch_setOverride 'psx.cfg' 'SwanStation'  'aspect_ratio_index' '"1"'
	RetroArch_psx_bezelOff
}

function RetroArch_SwanStation_wideScreenOff(){
	RetroArch_setOverride 'SwanStation.opt' 'SwanStation'  'duckstation_GPU.WidescreenHack' '"false"'
	RetroArch_setOverride 'SwanStation.opt' 'SwanStation'  'duckstation_Display.AspectRatio' '"auto"'
	RetroArch_setOverride 'psx.cfg' 'SwanStation'  'aspect_ratio_index' '"0"'
}

function RetroArch_psx_bezelOn(){
	RetroArch_setOverride 'psx.cfg' 'Beetle PSX HW' 'input_overlay_enable' '"true"'
	RetroArch_setOverride 'psx.cfg' 'Beetle PSX HW' 'aspect_ratio_index' '"0"'
	RetroArch_setOverride 'psx.cfg' 'Beetle PSX HW' 'input_overlay' '"~/.var/app/org.libretro.RetroArch/config/retroarch/overlays/pegasus/psx.cfg"'
	RetroArch_setOverride 'psx.cfg' 'Beetle PSX HW' 'input_overlay_aspect_adjust_landscape' '"0.100000"'
	RetroArch_setOverride 'psx.cfg' 'Beetle PSX HW' 'input_overlay_enable' '"true"'
	RetroArch_setOverride 'psx.cfg' 'Beetle PSX HW' 'input_overlay_scale_landscape' '"1.060000"'
	RetroArch_setOverride 'psx.cfg' 'Beetle PSX' 'input_overlay_enable' '"true"'
	RetroArch_setOverride 'psx.cfg' 'Beetle PSX' 'aspect_ratio_index' '"0"'
	RetroArch_setOverride 'psx.cfg' 'Beetle PSX' 'input_overlay' '"~/.var/app/org.libretro.RetroArch/config/retroarch/overlays/pegasus/psx.cfg"'
	RetroArch_setOverride 'psx.cfg' 'Beetle PSX' 'input_overlay_aspect_adjust_landscape' '"0.100000"'
	RetroArch_setOverride 'psx.cfg' 'Beetle PSX' 'input_overlay_enable' '"true"'
	RetroArch_setOverride 'psx.cfg' 'Beetle PSX' 'input_overlay_scale_landscape' '"1.060000"'
	RetroArch_setOverride 'psx.cfg' 'SwanStation' 'input_overlay_enable' '"true"'
	RetroArch_setOverride 'psx.cfg' 'SwanStation' 'aspect_ratio_index' '"0"'
	RetroArch_setOverride 'psx.cfg' 'SwanStation' 'input_overlay' '"~/.var/app/org.libretro.RetroArch/config/retroarch/overlays/pegasus/psx.cfg"'
	RetroArch_setOverride 'psx.cfg' 'SwanStation' 'input_overlay_aspect_adjust_landscape' '"0.100000"'
	RetroArch_setOverride 'psx.cfg' 'SwanStation' 'input_overlay_enable' '"true"'
	RetroArch_setOverride 'psx.cfg' 'SwanStation' 'input_overlay_scale_landscape' '"1.060000"'
}


function RetroArch_psx_bezelOff(){
	RetroArch_setOverride 'psx.cfg' 'Beetle PSX HW'  'input_overlay_enable' '"false"'
	RetroArch_setOverride 'psx.cfg' 'Beetle PSX'  'input_overlay_enable' '"false"'
	RetroArch_setOverride 'psx.cfg' 'SwanStation'  'input_overlay_enable' '"false"'
}

function  RetroArch_psx_3DCRTshaderOn(){
	 RetroArch_setOverride 'psx.cfg' 'Beetle PSX HW'  'video_shader_enable' 'true'
	RetroArch_setOverride 'psx.cfg' 'Beetle PSX HW'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'psx.cfg' 'Beetle PSX HW'	'video_smooth' 'ED_RM_LINE'

	 RetroArch_setOverride 'psx.cfg' 'Beetle PSX'  'video_shader_enable' 'true'
	RetroArch_setOverride 'psx.cfg' 'Beetle PSX'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'psx.cfg' 'Beetle PSX'	'video_smooth' 'ED_RM_LINE'

	 RetroArch_setOverride 'psx.cfg' 'SwanStation'  'video_shader_enable' 'true'
	RetroArch_setOverride 'psx.cfg' 'SwanStation'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'psx.cfg' 'SwanStation'	'video_smooth' 'ED_RM_LINE'
 }

function RetroArch_psx_3DCRTshaderOff(){
	RetroArch_setOverride 'psx.cfg' 'Beetle PSX HW'  'video_shader_enable' '"false"'
	RetroArch_setOverride 'psx.cfg' 'Beetle PSX HW'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'psx.cfg' 'Beetle PSX HW'	'video_smooth' 'ED_RM_LINE'

	RetroArch_setOverride 'psx.cfg' 'Beetle PSX'  'video_shader_enable' '"false"'
	RetroArch_setOverride 'psx.cfg' 'Beetle PSX'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'psx.cfg' 'Beetle PSX'	'video_smooth' 'ED_RM_LINE'

	RetroArch_setOverride 'psx.cfg' 'SwanStation'  'video_shader_enable' '"false"'
	RetroArch_setOverride 'psx.cfg' 'SwanStation'	'video_filter' 'ED_RM_LINE'
	RetroArch_setOverride 'psx.cfg' 'SwanStation'	'video_smooth' 'ED_RM_LINE'
}

function RetroArch_psx_setConfig(){
	RetroArch_psx_3DCRTshaderOff
}


function RetroArch_autoSaveOn(){
	setConfigRA "savestate_auto_load" "true" $RetroArch_configFile
	setConfigRA "savestate_auto_save" "true" $RetroArch_configFile
}
function RetroArch_autoSaveOff(){
	setConfigRA "savestate_auto_load" "false" $RetroArch_configFile
	setConfigRA "savestate_auto_save" "false" $RetroArch_configFile
}

function RetroArch_retroAchievementsOn(){
	setConfigRA 'cheevos_enable' 'true' "$RetroArch_configFile"
	#Mame fix
	#RetroArch_setOverride 'mame.cfg' 'MAME 2003-Plus'  'cheevos_enable' '"false"'
	#RetroArch_setOverride 'mame.cfg' 'MAME'  'cheevos_enable' '"false"'
}
function RetroArch_retroAchievementsOff(){
	setConfigRA 'cheevos_enable' 'false' "$RetroArch_configFile"
	#Mame fix
	#RetroArch_setOverride 'mame.cfg' 'MAME 2003-Plus'  'cheevos_enable' '"false"'
	#RetroArch_setOverride 'mame.cfg' 'MAME'  'cheevos_enable' '"false"'
}

function RetroArch_retroAchievementsHardCoreOn(){
	setConfigRA 'cheevos_hardcore_mode_enable' 'true' $RetroArch_configFile
}
function RetroArch_retroAchievementsHardCoreOff(){
	setConfigRA 'cheevos_hardcore_mode_enable' 'false' $RetroArch_configFile
}

function RetroArch_retroAchievementsSetLogin(){
	setConfigRA 'cheevos_token' $achievementsUserToken "$RetroArch_configFile"
	setConfigRA 'cheevos_username' $achievementsUser "$RetroArch_configFile"
	RetroArch_retroAchievementsOn
}

function RetroArch_setSNESAR(){
	if ( "$SNESAR" -eq 87 ){
		RetroArch_snes_ar87
	}else{
		RetroArch_snes_ar43
	}
}
function RetroArch_setBezels(){
	if ( "$RABezels" -eq "true" ){
		RetroArch_bezelOnAll
	}else{
		RetroArch_bezelOffAll
	}
}
function RetroArch_setShadersCRT(){
	if ( "$RAHandClassic2D" -eq "true" ){
		RetroArch_CRTshaderOnAll
	}else{
		RetroArch_CRTshaderOffAll
	}
}
function RetroArch_setShaders3DCRT(){
	if ( "$RAHandClassic3D" -eq "true" ){
		RetroArch_3DCRTshaderOnAll
	}else{
		RetroArch_3DCRTshaderOffAll
	}
}
function RetroArch_setShadersMAT(){
	if ( "$RAHandHeldShader" -eq "true" ){
		RetroArch_MATshadersOnAll
	}else{
		RetroArch_MATshadersOffAll
	}
}

function RetroArch_MATshadersOnAll(){
	RetroArch_wswanc_MATshaderOn
	RetroArch_wswan_MATshaderOn
	RetroArch_lynx_MATshaderOn
	RetroArch_ngp_MATshaderOn
	RetroArch_ngpc_MATshaderOn
	RetroArch_gamegear_MATshaderOn
	RetroArch_gba_MATshaderOn
	RetroArch_gb_MATshaderOn
	RetroArch_gbc_MATshaderOn
}

function RetroArch_MATshadersOffAll(){
	RetroArch_wswanc_MATshaderOff
	RetroArch_wswan_MATshaderOff
	RetroArch_lynx_MATshaderOff
	RetroArch_ngp_MATshaderOff
	RetroArch_ngpc_MATshaderOff
	RetroArch_gamegear_MATshaderOff
	RetroArch_gba_MATshaderOff
	RetroArch_gb_MATshaderOff
	RetroArch_gbc_MATshaderOff
}

function RetroArch_3DCRTshaderOnAll{
	RetroArch_n64_3DCRTshaderOn
	RetroArch_dreamcast_3DCRTshaderOn
	RetroArch_saturn_3DCRTshaderOn
	RetroArch_psx_3DCRTshaderOn
}

function RetroArch_3DCRTshaderOffAll{
	RetroArch_n64_3DCRTshaderOff
	RetroArch_dreamcast_3DCRTshaderOff
	RetroArch_saturn_3DCRTshaderOff
	RetroArch_psx_3DCRTshaderOff
}


function RetroArch_CRTshaderOnAll(){
	RetroArch_pcengine_CRTshaderOn
	RetroArch_amiga1200_CRTshaderOn
	RetroArch_nes_CRTshaderOn
	RetroArch_atari2600_CRTshaderOn
	RetroArch_mame_CRTshaderOn
	RetroArch_neogeo_CRTshaderOn
	RetroArch_fbneo_CRTshaderOn
	RetroArch_segacd_CRTshaderOn
	RetroArch_genesis_CRTshaderOn
	RetroArch_mastersystem_CRTshaderOn
	RetroArch_sega32x_CRTshaderOn
	RetroArch_snes_CRTshaderOn

}

function RetroArch_CRTshaderOffAll(){
	RetroArch_pcengine_CRTshaderOff
	RetroArch_amiga1200_CRTshaderOff
	RetroArch_nes_CRTshaderOff
	RetroArch_atari2600_CRTshaderOff
	RetroArch_mame_CRTshaderOff
	RetroArch_neogeo_CRTshaderOff
	RetroArch_fbneo_CRTshaderOff
	RetroArch_segacd_CRTshaderOff
	RetroArch_genesis_CRTshaderOff
	RetroArch_mastersystem_CRTshaderOff
	RetroArch_sega32x_CRTshaderOff
	RetroArch_snes_CRTshaderOff

}

$Ryujinx_configFile="$emusPath\Ryujinx\portable\Config.json"

function Ryujinx_install(){
	setMSG "Downloading Ryujinx"
	$url_ryu = getLatestReleaseURLGH "Ryubing/Stable-Releases" "zip"
	download $url_ryu "Ryujinx.zip"
	moveFromTo "$temp/Ryujinx/publish" "$emusPath\Ryujinx"
	createLauncher "Ryujinx"
}
function Ryujinx_init(){
	setMSG "Ryujinx - Configuration"
	$destination="$emusPath\Ryujinx"
	mkdir "$destination\portable" -ErrorAction SilentlyContinue
	Copy-Item -Path "$env:APPDATA\EmuDeck\backend\configs\Ryujinx\Config.json" -Destination "$destination\portable\Config.json" -Force
	Ryujinx_setEmulationFolder
	Ryujinx_setupSaves
	Ryujinx_setResolution $yuzuResolution


	sedFile "$destination\portable\Config.json" "C:\\Emulation" "$emulationPath"
	sedFile "$destination\portable\Config.json" ":\Emulation" ":\\Emulation"

}

function Ryujinx_update(){
	Write-Output "NYI"
}
function Ryujinx_setEmulationFolder(){
	$destination="$emusPath\Ryujinx"
	sedFile $destination\portable\Config.json "/run/media/mmcblk0p1/Emulation/roms/switch" "$romsPath/switch"
}
function Ryujinx_setupSaves(){

	setMSG "Ryujinx - Creating Keys  Links"
	#Firmware
	mkdir "$emusPath\Ryujinx\portable" -ErrorAction SilentlyContinue
	mkdir "$biosPath\ryujinx" -ErrorAction SilentlyContinue
	$simLinkPath = "$emusPath\Ryujinx\portable\system"
	$emuSavePath = "$emulationPath\bios\ryujinx\keys"
	createSaveLink $simLinkPath $emuSavePath

	setMSG "Ryujinx - Saves Links"
	mkdir "$emusPath\Ryujinx\portable\bis\user" -ErrorAction SilentlyContinue
	$simLinkPath = "$emusPath\Ryujinx\portable\bis\user\save"
	$emuSavePath = "$emulationPath\saves\ryujinx\saves"
	createSaveLink $simLinkPath $emuSavePath

	$simLinkPath = "$emusPath\Ryujinx\portable\bis\system\save"
	$emuSavePath = "$emulationPath\saves\ryujinx\system_saves"
	createSaveLink $simLinkPath $emuSavePath

	$simLinkPath = "$emusPath\Ryujinx\portable\bis\user\saveMeta"
	$emuSavePath = "$emulationPath\saves\ryujinx\saveMeta"
	createSaveLink $simLinkPath $emuSavePath

	$simLinkPath = "$emusPath\Ryujinx\portable\system"
	$emuSavePath = "$emulationPath\saves\ryujinx\system"
	createSaveLink $simLinkPath $emuSavePath

	#cloud_sync_save_hash "$savesPath\ryujinx"

}

function Ryujinx_setResolution($resolution){
	switch ( $resolution )
	{
		"720P" { $multiplier = 1;  $docked="false"}
		"1080P" { $multiplier = 1; $docked="true"   }
		"1440P" { $multiplier = 2;  $docked="false" }
		"4K" { $multiplier = 2; $docked="true" }
	}

	$jsonConfig = Get-Content -Path "$emusPath\Ryujinx\portable\Config.json" | ConvertFrom-Json
	$jsonConfig.docked_mode = $docked
	$jsonConfig.res_scale = $multiplier
}
function Ryujinx_setupStorage(){
	Write-Output "NYI"
}
function Ryujinx_wipe(){
	Write-Output "NYI"
}
function Ryujinx_uninstall(){
	Remove-Item -path "$emusPath\Ryujinx" -recurse -force
	if($?){
		Write-Output "true"
	}
}
function Ryujinx_migrate(){
	Write-Output "NYI"
}
function Ryujinx_setABXYstyle(){
	Write-Output "NYI"
}
function Ryujinx_wideScreenOn(){
	Write-Output "NYI"
}
function Ryujinx_wideScreenOff(){
	Write-Output "NYI"
}
function Ryujinx_bezelOn(){
	Write-Output "NYI"
}
function Ryujinx_bezelOff(){
	Write-Output "NYI"
}
function Ryujinx_finalize(){
	Write-Output "NYI"
}
function Ryujinx_IsInstalled(){
	$test=Test-Path -Path "$emusPath\Ryujinx"
	if($test){
		Write-Output "true"
	}else{
		Write-Output "false"
	}
}
function Ryujinx_resetConfig(){
	Ryujinx_init
	if($?){
		Write-Output "true"
	}
}$ScummVM_configFile="$env:APPDATA\ScummVM\scummvm.ini"

function ScummVM_install(){
	setMSG "Downloading ScummVM"
	download $url_ScummVM "ScummVM.zip"
	moveFromTo "$temp\ScummVM" "$emusPath\ScummVM"
	createLauncher "ScummVM"
}
function ScummVM_init(){
	copyFromTo "$env:APPDATA\EmuDeck\backend\configs\scummvm" "$env:APPDATA\ScummVM"
	ScummVM_setEmulationFolder
	ScummVM_setupSaves
}
function ScummVM_update(){
	Write-Output "NYI"
}
function ScummVM_setEmulationFolder(){
	sedFile $ScummVM_configFile "/run/media/mmcblk0p1/Emulation" "$emulationPath"
}
function ScummVM_setupSaves(){
	setMSG "ScummVM - Saves Links"
	mkdir "$savespath\scummvm\saves" -ErrorAction SilentlyContinue
}
function ScummVM_setupStorage(){
	Write-Output "NYI"
}
function ScummVM_wipe(){
	Write-Output "NYI"
}
function ScummVM_uninstall(){
	Remove-Item -path "$emusPath\ScummVM" -recurse -force
	if($?){
		Write-Output "true"
	}
}
function ScummVM_migrate(){
	Write-Output "NYI"
}
function ScummVM_setABXYstyle(){
	Write-Output "NYI"
}
function ScummVM_wideScreenOn(){
	Write-Output "NYI"
}
function ScummVM_wideScreenOff(){
	Write-Output "NYI"
}
function ScummVM_bezelOn(){
	Write-Output "NYI"
}
function ScummVM_bezelOff(){
	Write-Output "NYI"
}
function ScummVM_finalize(){
	Write-Output "NYI"
}
function ScummVM_IsInstalled(){
	$test=Test-Path -Path "$emusPath\ScummVM\scummvm.exe"
	if($test){
		Write-Output "true"
	}else{
		Write-Output "false"
	}
}
function ScummVM_resetConfig(){
	ScummVM_init
	if($?){
		Write-Output "true"
	}
}$ShadPS4_configFile="$emusPath\ShadPS4-qt\user\config.toml"

function ShadPS4_install(){
	setMSG "Downloading ShadPS4"
	$url_ShadPS4 = "https://github.com/shadps4-emu/shadPS4/releases/download/v.0.4.0/shadps4-win64-qt-0.4.0.zip"
	download $url_ShadPS4 "ShadPS4.zip"
	moveFromTo "$temp/ShadPS4" "$emusPath\ShadPS4-qt"
	createLauncher "shadps4"
}
function ShadPS4_init(){
	setMSG "ShadPS4 - Configuration"
	$destination="$emusPath\ShadPS4-qt\user"
	mkdir $destination -ErrorAction SilentlyContinue
	copyFromTo "$env:APPDATA\EmuDeck\backend\configs\ShadPS4" "$destination"
	#ShadPS4_setResolution $ShadPS4Resolution
	ShadPS4_setupStorage
	ShadPS4_setupSaves
	ShadPS4_setEmulationFolder
}
function ShadPS4_update(){
	Write-Output "NYI"
}
function ShadPS4_setEmulationFolder(){
	sedFile "$ShadPS4_configFile" "/run/media/mmcblk0p1/Emulation" "$emulationPath"
	sedFile "$ShadPS4_configFile" "\" "/"
}
function ShadPS4_setResolution($resolution){
	echo "NYI"
}

function ShadPS4_setupSaves(){
	setMSG "ShadPS4 - Saves Links"
	mkdir "$emusPath\shadps4-qt\user"  -ErrorAction SilentlyContinue
	mkdir "$emusPath\shadps4-qt\user\savedata"  -ErrorAction SilentlyContinue
	$simLinkPath = "$emusPath\shadps4-qt\user\savedata"
	$emuSavePath = "$emulationPath\saves\shadps4\saves"
	createSaveLink $simLinkPath $emuSavePath
}

function ShadPS4_setupStorage(){
	mkdir "$emulationPath\storage\shadps4\games\"  -ErrorAction SilentlyContinue
	mkdir "$emulationPath\storage\shadps4\dlc\"  -ErrorAction SilentlyContinue
}
function ShadPS4_wipe(){
	Write-Output "NYI"
}
function ShadPS4_uninstall(){
	Remove-Item -path "$emusPath\ShadPS4-qt" -recurse -force
	if($?){
		Write-Output "true"
	}
}
function ShadPS4_migrate(){
	Write-Output "NYI"
}
function ShadPS4_setABXYstyle(){
	Write-Output "NYI"
}
function ShadPS4_wideScreenOn(){
	Write-Output "NYI"
}
function ShadPS4_wideScreenOff(){
	Write-Output "NYI"
}
function ShadPS4_bezelOn(){
	Write-Output "NYI"
}
function ShadPS4_bezelOff(){
	Write-Output "NYI"
}
function ShadPS4_finalize(){
	Write-Output "NYI"
}
function ShadPS4_IsInstalled(){
	$test=Test-Path -Path "$emusPath\ShadPS4-qt\shadPS4.exe"
	if($test){
		Write-Output "true"
	}else{
		Write-Output "false"
	}
}
function ShadPS4_resetConfig(){
	ShadPS4_init
	if($?){
		Write-Output "true"
	}
}$Supermodel_configFile="$emusPath/Supermodel/Config/Supermodel.ini"
$Supermodel_gamesList="https://raw.githubusercontent.com/trzy/Supermodel/master/Config/Games.xml"

function SuperModel_install(){
	setMSG "Installing Supermodel"
    $url_Supermodel = "https://www.supermodel3.com/Files/Git_Snapshots/Supermodel_0.3a-git-d043dc0_Win64.zip"
    download $url_Supermodel "supermodel.zip"
    moveFromTo "$temp\supermodel" "$emusPath\Supermodel"
    createLauncher "Supermodel"
}

function SuperModel_init(){

	$destination="$emusPath\Supermodel"
    
    mkdir -Force "$destination\Analysis"
    mkdir -Force "$destination\Log"

    $sourcePath = "$env:APPDATA\EmuDeck\backend\configs\supermodel\Supermodel.ini"
    $destinationPath = "$emusPath\Supermodel\Config\Supermodel.ini"
    Copy-Item -Path $sourcePath -Destination $destinationPath -Force

    if (Test-Path "$destination\Config\Games.xml") {
        Remove-Item "$destination\Config\Games.xml" -Force
    }
    Invoke-WebRequest -Uri $Supermodel_gamesList -OutFile "$destination\Config\Games.xml"
    Supermodel_setEmulationFolder
    Supermodel_setupSaves
}

function SuperModel_update(){
	Write-Output "NYI"
}

function SuperModel_setEmulationFolder(){
	sedFile $Supermodel_configFile "ROMs" "$emulationPath\\roms\\model3"
    sedFile $Supermodel_configFile ":\" ":\\"
}

function SuperModel_setupSaves() {

    setMSG "Supermodel - Saves Links"

    mkdir "$emusPath\Supermodel" -ErrorAction SilentlyContinue

    $simLinkPath = "$emusPath\Supermodel\saves"
    $emuSavePath = "$emulationPath\saves\supermodel\saves"
    createSaveLink $simLinkPath $emuSavePath
}

function SuperModel_setupStorage(){
	Write-Output "NYI"
}
function SuperModel_wipe(){
	Write-Output "NYI"
}
function SuperModel_uninstall(){
	Remove-Item -path "$emusPath\SuperModel" -recurse -force
	if($?){
		Write-Output "true"
	}
}
function SuperModel_migrate(){
	Write-Output "NYI"
}
function SuperModel_setABXYstyle(){
	Write-Output "NYI"
}
function SuperModel_wideScreenOn(){
	Write-Output "NYI"
}
function SuperModel_wideScreenOff(){
	Write-Output "NYI"
}
function SuperModel_bezelOn(){
	Write-Output "NYI"
}
function SuperModel_bezelOff(){
	Write-Output "NYI"
}
function SuperModel_finalize(){
	Write-Output "NYI"
}
function SuperModel_IsInstalled(){
	$test=Test-Path -Path "$emusPath\SuperModel"
	if($test){
		Write-Output "true"
	}else{
		Write-Output "false"
	}
}
function SuperModel_resetConfig(){
	Supermodel_init
    if ($?) {
        Write-Output "true"
    } else {
        Write-Output "false"
    }
}$Vita3K_configFile="$emusPath\Vita3K\config.yml"

function Vita3K_install(){
	setMSG "Downloading Vita3K"
	$url_vita3k = getLatestReleaseURLGH "Vita3K/Vita3K" "zip" "windows"
	download $url_vita3k "vita3k.zip"
	moveFromTo "$temp\vita3k" "$emusPath\Vita3K"
	createLauncher "Vita3K"
}
function Vita3K_init(){
	$destination="$emusPath\vita3k"
	copyFromTo "$env:APPDATA\EmuDeck\backend\configs\vita3k" "$destination"
	Vita3K_setEmulationFolder
	Vita3K_setupStorage
	Vita3K_setupSaves
	Vita3K_finalize
}
function Vita3K_update(){
	Write-Output "NYI"
}
function Vita3K_setEmulationFolder(){
	sedFile "$Vita3K_configFile" "/run/media/mmcblk0p1/Emulation" "$emulationPath"
}
function Vita3K_setupSaves(){
	setMSG "Vita3K - Saves Links"
	mkdir "$storagePath\Vita3K\ux0\user\00\savedata" -ErrorAction SilentlyContinue
	mkdir "$emulationPath\saves\Vita3K\saves" -ErrorAction SilentlyContinue
	createSymlink "$emulationPath\storage\Vita3K\ux0\user\00\savedata" "$emulationPath\saves\Vita3K\saves"
}
function Vita3K_setupStorage(){
	mkdir "$storagePath\Vita3K\ux0\app" -ErrorAction SilentlyContinue
	createSymlink "$romsPath\psvita\InstalledGames" "$storagePath\Vita3K\ux0\app"
}
function Vita3K_wipe(){
	Write-Output "NYI"
}
function Vita3K_uninstall(){
	Remove-Item -path "$emusPath\vita3k" -recurse -force
	if($?){
		Write-Output "true"
	}
}
function Vita3K_migrate(){
	Write-Output "NYI"
}
function Vita3K_setABXYstyle(){
	Write-Output "NYI"
}
function Vita3K_wideScreenOn(){
	Write-Output "NYI"
}
function Vita3K_wideScreenOff(){
	Write-Output "NYI"
}
function Vita3K_bezelOn(){
	Write-Output "NYI"
}
function Vita3K_bezelOff(){
	Write-Output "NYI"
}
function Vita3K_finalize(){
	Write-Output "NYI"
}
function Vita3K_IsInstalled(){
	$test=Test-Path -Path "$emusPath\vita3k\vita3k.exe"
	if($test){
		Write-Output "true"
	}else{
		Write-Output "false"
	}
}
function Vita3K_resetConfig(){
	Vita3K_init
	if($?){
		Write-Output "true"
	}
}$Xemu_configFile="${emusPath}\xemu\xemu.toml"

function Xemu_install(){
	setMSG "Downloading Xemu"
	$url_xemu = getLatestReleaseURLGH "xemu-project/xemu" "zip" "win-release.zip"
	download $url_xemu "xemu-win-release.zip"
	moveFromTo "$temp/xemu-win-release" "$emusPath\xemu"
	createLauncher "xemu"
}
function Xemu_init(){
	$destination="$emusPath\xemu"
	copyFromTo "$env:APPDATA\EmuDeck\backend\configs\xemu" "$destination"
	sedFile $Xemu_configFile "/run/media/mmcblk0p1/Emulation" "$emulationPath"
	sedFile $Xemu_configFile "/" '\'
	Xemu_setupStorage
	Xemu_setCustomizations
	Xemu_setupSaves
	#Xemu_setResolution $xemuResolution
}
function Xemu_update(){
	Write-Output "NYI"
}
function Xemu_setupSaves(){
	mkdir "$savesPath\xemu" -ErrorAction SilentlyContinue
	"$storagePath\xemu"
	$simLinkPath = "$storagePath\xemu"
	$emuSavePath = "$savesPath\xemu\saves"
	createSaveLink $simLinkPath $emuSavePath
}
function Xemu_setResolution($resolution){
	Write-Output $resolution
}
function Xemu_setupStorage(){
	mkdir "$storagePath\xemu" -ErrorAction SilentlyContinue
	$url_xemu_hdd = "https://github.com/mborgerson/xemu-hdd-image/releases/latest/download/xbox_hdd.qcow2.zip"
	download $url_xemu_hdd "xbox_hdd.qcow2.zip"
	moveFromTo "$temp/xbox_hdd.qcow2" "$storagePath\xemu"
}
function Xemu_wipe(){
	Write-Output "NYI"
}
function Xemu_uninstall(){
	Remove-Item -path "$emusPath\Xemu" -recurse -force
	if($?){
		Write-Output "true"
	}
}
function Xemu_migrate(){
	Write-Output "NYI"
}
function Xemu_setABXYstyle(){
	Write-Output "NYI"
}
function Xemu_wideScreenOn(){
	$fit='fit = '
	$fitSetting="$fit'scale_16_9'"
	changeLine "$fit" "$fitSetting" "$Xemu_configFile"
}
function Xemu_wideScreenOff(){
	$fit='fit = '
	$fitSetting="$fit'scale_4_3'"
	changeLine "$fit" "$fitSetting" "$Xemu_configFile"
}
function Xemu_bezelOn(){
	Write-Output "NYI"
}
function Xemu_bezelOff(){
	Write-Output "NYI"
}
function Xemu_finalize(){
	Write-Output "NYI"
}
function Xemu_IsInstalled(){
	$test=Test-Path -Path "$emusPath\xemu"
	if($test){
		Write-Output "true"
	}else{
		Write-Output "false"
	}
}
function Xemu_resetConfig(){
	Xemu_init
	if($?){
		Write-Output "true"
	}
}
function Xemu_setCustomizations(){
	if ( "$arClassic3D" -eq "169"){
	  Xemu_wideScreenOn
	}else{
	  Xemu_wideScreenOff
	}
}
$Xenia_configFile="${emusPath}\xenia\xenia-canary.config.toml"

function Xenia_install(){
	setMSG "Downloading Xenia"
	$url_xenia = getLatestReleaseURLGH "xenia-canary/xenia-canary-releases" "zip"
	download $url_xenia "xenia.zip"
	moveFromTo "$temp/xenia" "$emusPath\xenia"
	createLauncher "xenia"
	Xenia_getPatches
}
function Xenia_init(){
	$destination="$emusPath\xenia"
	mkdir $destination -ErrorAction SilentlyContinue
	copyFromTo "$env:APPDATA\EmuDeck\backend\configs\xenia" "$destination"
	mkdir "$romsPath\xbox360\xbla" -ErrorAction SilentlyContinue
	#Xenia_setResolution $xeniaResolution
}
function Xenia_update(){
	Write-Output "NYI"
}
function Xenia_setEmulationFolder(){
	Write-Output "NYI"
}
function Xenia_setupSaves(){
	setMSG "Xenia - Saves Links"
	mkdir "$emusPath\xenia\content"  -ErrorAction SilentlyContinue
	$simLinkPath = "$emusPath\xenia\content"
	$emuSavePath = "$emulationPath\saves\xenia\saves"
	createSaveLink $simLinkPath $emuSavePath

}
function Xenia_setResolution($resolution){
	Write-Output $resolution
}
function Xenia_getPatches(){
  $patches_dir="$emusPath/xenia/patches"
  $patches_url="https://github.com/xenia-canary/game-patches/releases/latest/download/game-patches.zip"
  $patches_branch="main"
  download $patches_url "patches.zip"
  mkdir $patches_dir -ErrorAction SilentlyContinue
  moveFromTo "$temp\patches" "$emusPath\xenia"


}
function Xenia_setupStorage(){
	Write-Output "NYI"
}
function Xenia_wipe(){
	Write-Output "NYI"
}
function Xenia_uninstall(){
	Remove-Item -path "$emusPath\Xenia" -recurse -force
	if($?){
		Write-Output "true"
	}
}
function Xenia_migrate(){
	Write-Output "NYI"
}
function Xenia_setABXYstyle(){
	Write-Output "NYI"
}
function Xenia_wideScreenOn(){
	Write-Output "NYI"
}
function Xenia_wideScreenOff(){
	Write-Output "NYI"
}
function Xenia_bezelOn(){
	Write-Output "NYI"
}
function Xenia_bezelOff(){
	Write-Output "NYI"
}
function Xenia_finalize(){
	Write-Output "NYI"
}
function Xenia_IsInstalled(){
	$test=Test-Path -Path "$emusPath\xenia"
	if($test){
		Write-Output "true"
	}else{
		Write-Output "false"
	}
}
function Xenia_resetConfig(){
	Xenia_init
	if($?){
		Write-Output "true"
	}
}$Yuzu_configFile="${emusPath}\yuzu\yuzu-windows-msvc\user\config\qt-config.ini"

function Yuzu_install(){
	setMSG "Downloading Yuzu"
	winget install Microsoft.VCRedist.2015+.x64 --accept-package-agreements --accept-source-agreements
	$url_yuzu = getLatestReleaseURLGH "yuzu-emu/yuzu-mainline" "7z" "windows"
	#$url_yuzu = "https://github.com/yuzu-emu/yuzu-mainline/releases/download/mainline-0-1476/yuzu-windows-msvc-20230621-e3122c5b4.7z"
	download $url_yuzu "yuzu.7z"
	moveFromTo "$temp/yuzu/yuzu-windows-msvc" "$emusPath\yuzu\yuzu-windows-msvc"
	Remove-Item -Recurse -Force yuzu -ErrorAction SilentlyContinue
	createLauncher "yuzu"
}
function Yuzu_init(){

	setMSG "Yuzu - Configuration"
	mkdir "$emusPath\yuzu\yuzu-windows-msvc\user\nand\system\Contents\registered" -ErrorAction SilentlyContinue
	mkdir "$emusPath\yuzu\yuzu-windows-msvc\user\keys" -ErrorAction SilentlyContinue

	$destination="$emusPath\yuzu\yuzu-windows-msvc\user\config"
	mkdir $destination -ErrorAction SilentlyContinue
	copyFromTo "$env:APPDATA\EmuDeck\backend\configs\yuzu\config" "$destination"

	#SDL fix
	Copy-Item "$env:APPDATA\EmuDeck\backend\configs\yuzu\SDL2.dll" -Destination "$emusPath\yuzu\yuzu-windows-msvc\" -ErrorAction SilentlyContinue -Force

	sedFile $destination\qt-config.ini "C:/Emulation" $emulationPath

	Yuzu_setupStorage
	Yuzu_setupSaves
	Yuzu_setResolution $yuzuResolution
	createLauncher "Yuzu"

}
function Yuzu_update(){
	Write-Output "NYI"
}
function Yuzu_setEmulationFolder(){
	Write-Output "NYI"
}
function Yuzu_setupSaves(){

	setMSG "Yuzu - Creating Keys & Firmware Links"
	#Firmware
	mkdir "$emusPath\yuzu\yuzu-windows-msvc\user\nand\system\Contents"  -ErrorAction SilentlyContinue
	$simLinkPath = "$emusPath\yuzu\yuzu-windows-msvc\user\nand\system\Contents\registered"
	$emuSavePath = "$emulationPath\bios\yuzu\firmware"
	createSaveLink $simLinkPath $emuSavePath

	#DLCs
	mkdir "$emusPath\yuzu\yuzu-windows-msvc\user\nand\user\Contents"  -ErrorAction SilentlyContinue
	$simLinkPath = "$emusPath\yuzu\yuzu-windows-msvc\user\nand\user\Contents\registered"
	$emuSavePath = "$storagePath\yuzu\storage"
	createSaveLink $simLinkPath $emuSavePath

	#Keys
	$simLinkPath = "$emusPath\yuzu\yuzu-windows-msvc\user\keys"
	$emuSavePath = "$emulationPath\bios\yuzu\keys"
	createSaveLink $simLinkPath $emuSavePath

	setMSG "Yuzu - Saves Links"
	mkdir "$emusPath\yuzu\yuzu-windows-msvc\user\nand\user"  -ErrorAction SilentlyContinue
	$simLinkPath = "$emusPath\yuzu\yuzu-windows-msvc\user\nand\user\save"
	$emuSavePath = "$emulationPath\saves\yuzu\saves"
	createSaveLink $simLinkPath $emuSavePath

	mkdir $emusPath\yuzu\yuzu-windows-msvc\user\nand\system\save\8000000000000010\su\  -ErrorAction SilentlyContinue
	$simLinkPath = "$emusPath\yuzu\yuzu-windows-msvc\user\nand\system\save\8000000000000010\su\avators"
	$emuSavePath = "$emulationPath\saves\yuzu\profiles"
	createSaveLink $simLinkPath $emuSavePath
	#cloud_sync_save_hash "$savesPath\yuzu"


}
function Yuzu_setResolution($resolution){
	switch ( $resolution )
	{
		"720P" { $multiplier = 2;  $docked="false"}
		"1080P" { $multiplier = 2; $docked="true"   }
		"1440P" { $multiplier = 3;  $docked="false" }
		"4K" { $multiplier = 3; $docked="true" }
	}

	setConfig "resolution_setup" $multiplier "$emusPath\yuzu\yuzu-windows-msvc\user\config\qt-config.ini"
	setConfig "use_docked_mode" $docked "$emusPath\yuzu\yuzu-windows-msvc\user\config\qt-config.ini"

}
function Yuzu_setupStorage(){
	mkdir "$emulationPath\storage\yuzu\screenshots" -ErrorAction SilentlyContinue
	mkdir "$emulationPath\storage\yuzu\dump" -ErrorAction SilentlyContinue
	mkdir "$emulationPath\storage\yuzu\load" -ErrorAction SilentlyContinue
	mkdir "$emulationPath\storage\yuzu\nand" -ErrorAction SilentlyContinue
	mkdir "$emulationPath\storage\yuzu\sdmc" -ErrorAction SilentlyContinue
	mkdir "$emulationPath\storage\yuzu\tas" -ErrorAction SilentlyContinue
}
function Yuzu_wipe(){
	Write-Output "NYI"
}
function Yuzu_uninstall(){
	Remove-Item -path "$emusPath\yuzu" -recurse -force
	if($?){
		Write-Output "true"
	}
}
function Yuzu_migrate(){
	Write-Output "NYI"
}
function Yuzu_setABXYstyle(){
	Write-Output "NYI"
}
function Yuzu_wideScreenOn(){
	Write-Output "NYI"
}
function Yuzu_wideScreenOff(){
	Write-Output "NYI"
}
function Yuzu_bezelOn(){
	Write-Output "NYI"
}
function Yuzu_bezelOff(){
	Write-Output "NYI"
}
function Yuzu_finalize(){
	Write-Output "NYI"
}
function Yuzu_IsInstalled(){
	$test=Test-Path -Path "$emusPath\yuzu\yuzu-windows-msvc"
	if($test){
		Write-Output "true"
	}else{
		Write-Output "false"
	}
}
function Yuzu_resetConfig(){
	Yuzu_init
	if($?){
		Write-Output "true"
	}
}


### Yuzu EA
function YuzuEA_install($tokenValue) {
	$jwtHost = "https://api.yuzu-emu.org/jwt/installer/"
	$yuzuEaHost = "https://api.yuzu-emu.org/downloads/earlyaccess/"
	$user = $null
	$auth = $null

	$length = $tokenValue.Length
	$remainder = $length % 4
	if ($remainder -eq 1) {
		$tokenValue += "==="
	} elseif ($remainder -eq 2) {
		$tokenValue += "=="
	} elseif ($remainder -eq 3) {
		$tokenValue += "="
	}

	$decodedData = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("$tokenValue"))
	$user, $auth = $decodedData.Split(':')

	if ($user -ne $null -and $auth -ne $null) {

		$yuzuEaMetadata = curl  "https://api.yuzu-emu.org/downloads/earlyaccess/" | ConvertFrom-Json

		$url_yuzuEA = ($yuzuEaMetadata.files | Where-Object { $_.name -match ".*\.7z" }).url

		$jwtHost = "https://api.yuzu-emu.org/jwt/installer/"

		$headers = @{
			"X-Username" = $user
			"X-Token" = $auth
			"User-Agent" = "EmuDeck"
		}

		$response = Invoke-WebRequest -Uri $jwtHost -Method Post -Headers $headers
		$BEARERTOKEN = $response.Content


		rm -r -fo "$temp/yuzuEA"-ErrorAction SilentlyContinue > $null
		download $url_yuzuEA "yuzuEA.7z" $BEARERTOKEN > $null
		xcopy "$temp\yuzuEA\yuzu-windows-msvc-early-access\" "$emusPath\yuzu\yuzu-windows-msvc\" /H /E /Y > $null
		rm -r -fo "$temp/yuzuEA" -ErrorAction SilentlyContinue > $null
		#createLauncher "yuzu"

		#SDL fix
		Copy-Item "$env:APPDATA\EmuDeck\backend\configs\yuzu\SDL2.dll" -Destination "$emusPath\yuzu\yuzu-windows-msvc\" -ErrorAction SilentlyContinue -Force

		Write-Host "true"

	} else {
		Write-Host "invalid"
	}

}

function YuzuEA_addToken($tokenValue){
	YuzuEA_install $tokenValue
}

function YuzuEA_IsInstalled() {
	$test=Test-Path -Path "$emusPath\yuzu\yuzu-windows-msvc"
	if($test){
		Write-Output "true"
	}else{
		Write-Output "false"
	}
}

function YuzuEA_uninstall() {
	echo "Begin Yuzu EA uninstall"
	Write-Output "NYI"
}$mGBA_configFile="$emusPath/mgba/config.ini"

function mGBA_install(){
	setMSG "Downloading mGBA"
	#$url_mGBA = getLatestReleaseURLGH "mgba-emu/mgba" "7z" "win64.7z"

	$url_mGBA = "https://github.com/mgba-emu/mgba/releases/download/0.10.1/mGBA-0.10.1-win64.7z"
	download $url_mGBA "mgba.zip"
	moveFromTo "$temp\mgba\mGBA-0.10.1-win64" "$emusPath\mGBA"
	createLauncher "mGBA"
}
function mGBA_init(){
	$destination="$emusPath\mgba"
	copyFromTo "$env:APPDATA\EmuDeck\backend\configs\mgba" "$destination"
	#mGBA_setupStorage
	mGBA_setEmulationFolder
	mGBA_setupSaves
	#mGBA_addSteamInputProfile
}
function mGBA_update(){
	Write-Output "true"
}
function mGBA_setEmulationFolder(){
	sedFile $mGBA_configFile "/run/media/mmcblk0p1/Emulation" "$emulationPath"
}
function mGBA_setupSaves(){
	mkdir "$savesPath/mgba/saves" -ErrorAction SilentlyContinue
	mkdir "$savesPath/mgba/states" -ErrorAction SilentlyContinue
}
function mGBA_setupStorage(){
	Write-Output "true"
}
function mGBA_wipe(){
	Write-Output "true"
}
function mGBA_uninstall(){
	rm -fo -r "$emusPath\mGBA"
	if($?){
		Write-Output "true"
	}
}
function mGBA_migrate(){
	Write-Output "true"
}
function mGBA_setABXYstyle(){
	Write-Output "true"
}
function mGBA_wideScreenOn(){
	Write-Output "true"
}
function mGBA_wideScreenOff(){
	Write-Output "true"
}
function mGBA_bezelOn(){
	Write-Output "true"
}
function mGBA_bezelOff(){
	Write-Output "true"
}
function mGBA_finalize(){
	Write-Output "true"
}
function mGBA_IsInstalled(){
	$test=Test-Path -Path "$emusPath\mgba\mgba.exe"
	if($test){
		Write-Output "true"
	}else{
		Write-Output "false"
	}
}
function mGBA_resetConfig(){
	mGBA_init
	if($?){
		Write-Output "true"
	}
}$melonD_configFile="$emusPath\melonDS\melonDS.ini"

function melonDS_install(){
	setMSG "Downloading melonDS"
	$url_melonDS = getLatestReleaseURLGH "melonDS-emu/melonDS" "zip" "windows"
	download $url_melonDS "melonds.zip"
	moveFromTo "$temp/melonDS" "$emusPath/melonDS"
	Remove-Item -Recurse -Force melonds.zip -ErrorAction SilentlyContinue
	createLauncher "melonDS"
}
function melonDS_init(){
	setMSG "melonDS - Configuration"
	$destination="$emusPath/melonDS"

	copyFromTo "$env:APPDATA\EmuDeck\backend\configs\melonDS" "$destination"

	sedFile "$melonD_configFile" "/run/media/mmcblk0p1/Emulation" "$emulationPath"
	sedFile "$melonD_configFile" "\" "/"

	melonDS_setupSaves
	melonDS_setResolution $melondsResolution
}
function melonDS_update(){
	Write-Output "true"
}
function melonDS_setEmulationFolder(){
	Write-Output "true"
}
function melonDS_setupSaves(){
	mkdir "$savesPath\melonds\saves" -ErrorAction SilentlyContinue
	mkdir "$savesPath\melonds\states" -ErrorAction SilentlyContinue
	mkdir "$emulationPath\storage\melonDS\cheats" -ErrorAction SilentlyContinue
	Write-Output "true"
	#cloud_sync_save_hash "$savesPath\melonds"
}

function melonDS_setResolution($resolution){
	switch ( $resolution )
	{
		"720P" { $WindowWidth = 1024; $WindowHeight = 768 }
		"1080P" { $WindowWidth = 1536; $WindowHeight = 1152 }
		"1440P" { $WindowWidth = 2048; $WindowHeight = 1536 }
		"4K" { $WindowWidth = 2816;  $WindowHeight = 2112 }
	}
	$destination="$emusPath/melonDS"

	setConfig "WindowWidth" $WindowWidth "$melonD_configFile"
	setConfig "WindowHeight" $WindowHeight "$melonD_configFile"
}



function melonDS_setupStorage(){
	Write-Output "true"
}
function melonDS_wipe(){
	Write-Output "true"
}
function melonDS_uninstall(){
	Remove-Item -path "$emusPath\melonDS" -recurse -force
	if($?){
		Write-Output "true"
	}
}
function melonDS_migrate(){
	Write-Output "true"
}
function melonDS_setABXYstyle(){
	Write-Output "true"
}
function melonDS_wideScreenOn(){
	Write-Output "true"
}
function melonDS_wideScreenOff(){
	Write-Output "true"
}
function melonDS_bezelOn(){
	Write-Output "true"
}
function melonDS_bezelOff(){
	Write-Output "true"
}
function melonDS_finalize(){
	Write-Output "true"
}
function melonDS_IsInstalled(){
	$test=Test-Path -Path "$emusPath\melonDS\melonDS.exe"
	if($test){
		Write-Output "true"
	}else{
		Write-Output "false"
	}
}
function melonDS_resetConfig(){
	melonDS_init
	if($?){
		Write-Output "true"
	}
}
