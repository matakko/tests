
$verbose = $true
$emusPath = "D:\Emulation\Emulators"
$emulationPath = "D:\Emulation"

function createSaveLink($target, $linkPath) {
    if ($verbose) { Write-Host "`n[INFO] Preparing symbolic link..." }

    # Récupère le dossier racine de l’émulateur (ex: azahar)
    $targetRoot = (Split-Path -Path (Split-Path -Path $target -Parent) -Parent)

    # Si le dossier racine de l’émulateur n'existe pas, on ne fait rien
    if (-Not (Test-Path $targetRoot)) {
        if ($verbose) { Write-Host "[WARN] Emulator root folder '$targetRoot' does not exist. Skipping link creation." }
        return
    }

    # Création en cascade du dossier parent du target
    $targetParent = Split-Path -Path $target -Parent
    if (-Not (Test-Path $targetParent)) {
        if ($verbose) { Write-Host "[INFO] Creating target parent folder: '$targetParent'" }
        New-Item -ItemType Directory -Path $targetParent -Force #| Out-Null
    }

    # Si le dossier final du target n'existe pas, on peut quand même le créer vide (ex: sdmc vide)
    if (-Not (Test-Path $target)) {
        if ($verbose) { Write-Host "[INFO] Creating missing target directory: '$target'" }
        New-Item -ItemType Directory -Path $target -Force #| Out-Null
    }

    # Création du parent du lien symbolique si nécessaire
    $linkParent = Split-Path -Path $linkPath -Parent
    if (-Not (Test-Path $linkParent)) {
        if ($verbose) { Write-Host "[INFO] Creating parent directory for link: '$linkParent'" }
        New-Item -ItemType Directory -Path $linkParent -Force #| Out-Null
    }

    # Supprime le lien s’il existe déjà
    if (Test-Path $linkPath) {
    if ($verbose) { Write-Host "[INFO] Removing existing link: '$linkPath'" }
    Remove-Item -Path $linkPath -Force
    }
    # Si un fichier ou dossier existe déjà à l’emplacement du lien, on le déplace vers un dossier de sauvegarde
    if (Test-Path $linkPath -PathType Container -and -not (Get-Item $linkPath) -is [System.IO.DirectoryInfo] -and -not (Get-Item $linkPath).LinkType) {
    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"

    # Base du dossier saves : ex D:\Emulation\saves
    $savesBase = Join-Path $emulationPath "saves"
    
    # Nom du dossier émulateur (ex: "test")
    $emulatorFolder = ($linkPath -replace [regex]::Escape($savesBase + "\"), "").Split("\")[0]

    # Sous-chemin relatif à l'émulateur (ex: "states")
    $relativeSubPath = ($linkPath -replace [regex]::Escape("$savesBase\$emulatorFolder\"), "")

    # Nom final du dossier backup : states-20250410-183000
    $backupName = "$relativeSubPath-$timestamp"

    # Chemin final : D:\Emulation\saves\bkp\test\states-20250410-183000
    $backupPath = Join-Path -Path "$savesBase\bkp\$emulatorFolder" -ChildPath $backupName

    # Création du parent si besoin
    $backupParent = Split-Path -Path $backupPath -Parent
    if (-Not (Test-Path $backupParent)) {
        New-Item -ItemType Directory -Path $backupParent -Force | Out-Null
    }

    if ($verbose) { Write-Host "[INFO] Moving conflicting item to backup: '$backupPath'" }
    Move-Item -Path $linkPath -Destination $backupPath -Force
}

    # Crée le lien symbolique
    if ($verbose) { Write-Host "[INFO] Creating symbolic link: '$linkPath' => '$target'" }
    New-Item -ItemType SymbolicLink -Path $linkPath -Target $target #| Out-Null
}



function Azahar_setupSaves() {
    if ($verbose) { Write-Host "`n===== Setting up test saves =====" -ForegroundColor Magenta }

	$simLinkPath = "$emusPath\test\user\sdmc"
	$emuSavePath = "$emulationPath\saves\test\saves"
	createSaveLink $simLinkPath $emuSavePath

	$simLinkPath = "$emusPath\test\user\states"
	$emuSavePath = "$emulationPath\saves\test\states"
	createSaveLink $simLinkPath $emuSavePath
	#cloud_sync_save_hash "$savesPath\citra"

    if ($verbose) { Write-Host "test save setup complete.`n" -ForegroundColor Green }
}

Azahar_setupSaves
