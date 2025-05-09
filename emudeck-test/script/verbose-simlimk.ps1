
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

    # Crée le lien symbolique
    if ($verbose) { Write-Host "[INFO] Creating symbolic link: '$linkPath' => '$target'" }
    New-Item -ItemType SymbolicLink -Path $linkPath -Target $target #| Out-Null
}



function Azahar_setupSaves() {
    if ($verbose) { Write-Host "`n===== Setting up Azahar saves =====" -ForegroundColor Magenta }

   # $statesPath = "$emusPath\azahar\user\states"
    #if (-not (Test-Path $statesPath)) {
     #   if ($verbose) { Write-Host "Creating states directory: $statesPath" -ForegroundColor DarkGray }
     #   New-Item -ItemType Directory -Path $statesPath -Force -ErrorAction SilentlyContinue | Out-Null
    #}

    $target1 = "$emusPath\azahar\user\sdmc"
    $link1 = "$emulationPath\saves\azahar\saves"
    createSaveLink $target1 $link1

    $target2 = "$emusPath\azahar\user\states"
    $link2 = "$emulationPath\saves\azahar\states"
    createSaveLink $target2 $link2

    if ($verbose) { Write-Host "Azahar save setup complete.`n" -ForegroundColor Green }
}

Azahar_setupSaves
