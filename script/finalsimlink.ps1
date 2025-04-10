# 
#
#
#


$verbose = $true
$emusPath = "D:\Emulation\Emulators"
$emulationPath = "D:\Emulation"

function createSaveLink($target, $linkPath) {
    if ($verbose) { Write-Host "`n[INFO] Preparing symbolic link..." }

    $targetRoot = (Split-Path -Path (Split-Path -Path $target -Parent) -Parent)

    if (-Not (Test-Path $targetRoot)) {
        if ($verbose) { Write-Host "[WARN] Emulator root folder '$targetRoot' does not exist. Skipping link creation." }
        return
    }

    $targetParent = Split-Path -Path $target -Parent
    if (-Not (Test-Path $targetParent)) {
        if ($verbose) { Write-Host "[INFO] Creating target parent folder: '$targetParent'" }
        New-Item -ItemType Directory -Path $targetParent -Force  #| Out-Null
    }

    if (-Not (Test-Path $target)) {
        if ($verbose) { Write-Host "[INFO] Creating missing target directory: '$target'" }
        New-Item -ItemType Directory -Path $target -Force  #| Out-Null
    }

    $linkParent = Split-Path -Path $linkPath -Parent
    if (-Not (Test-Path $linkParent)) {
        if ($verbose) { Write-Host "[INFO] Creating parent directory for link: '$linkParent'" }
        New-Item -ItemType Directory -Path $linkParent -Force  #| Out-Null
    }
	
    # If a symbolic link already exists, do nothing
    if (Test-Path $linkPath) {
        $linkItem = Get-Item $linkPath -Force
        if ($linkItem.Attributes -band [System.IO.FileAttributes]::ReparsePoint) {
            if ($verbose) { Write-Host "[INFO] Symbolic link already exists. Skipping: '$linkPath'" }
            return
        }

        # Otherwise, move the real folder to backup
        $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
        $savesBase = Join-Path $emulationPath "saves"
        $relativePath = $linkPath -replace [regex]::Escape("$savesBase\"), ""
        $emulatorFolder = $relativePath.Split("\")[0]
        $subPath = $relativePath -replace [regex]::Escape("$emulatorFolder\"), ""
        $backupName = "$subPath-$timestamp"
        $backupPath = Join-Path "$savesBase\bkp\$emulatorFolder" $backupName

        $backupParent = Split-Path $backupPath -Parent
        if (-Not (Test-Path $backupParent)) {
            New-Item -ItemType Directory -Path $backupParent -Force #| Out-Null
        }

        if ($verbose) { Write-Host "[INFO] Moving conflicting folder to backup: '$backupPath'" }
        Move-Item -Path $linkPath -Destination $backupPath -Force
    }

    # Create the new symbolic link
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




