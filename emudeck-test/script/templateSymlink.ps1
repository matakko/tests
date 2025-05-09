$emusPath = "D:\Emulation\Emulators"
$emulationPath = "D:\Emulation"

# Safe symlink creator
function createSaveLink($target, $linkPath) {
    # check if path exist
    if (Test-Path $target) {
        # Crée le dossier parent du lien s’il n’existe pas
        $parent = Split-Path -Path $linkPath -Parent
        if (-not (Test-Path $parent)) {
            New-Item -ItemType Directory -Path $parent -Force | Out-Null
        }

        # Supprime l'ancien lien s'il existe
        if (Test-Path $linkPath) {
            Remove-Item -Path $linkPath -Force
        }

        # Crée le lien symbolique
        New-Item -ItemType SymbolicLink -Path $linkPath -Target $target | Out-Null
        Write-Host "Created symlink: $linkPath -> $target"
    } else {
        Write-Host "Target path does not exist: $target"
    }
}

# Azahar - 3DS
function Azahar_setupSaves() {
    # Crée le dossier states si absent
    #$statesPath = "$emusPath\azahar\user\states"
   # New-Item -ItemType Directory -Path $statesPath -Force -ErrorAction SilentlyContinue | Out-Null

    # Symlink : saves
	$simLinkPath = "$emusPath\azahar\user\sdmc"
	$emuSavePath = "$emulationPath\saves\azahar\saves"
	createSaveLink $simLinkPath $emuSavePath

    # Symlink : states
    $simLinkPath = "$emusPath\azahar\user\states"
    $emuSavePath = "$emulationPath\saves\azahar\states"
    createSaveLink $simLinkPath $emuSavePath

    # cloud_sync_save_hash "$savesPath\citra" 
}

Azahar_setupSaves
