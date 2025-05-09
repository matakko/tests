#!/bin/bash
. "$HOME/.config/EmuDeck/backend/functions/all.sh"
emulatorInit "shadps4"
emuName="Shadps4-qt" # parameterize me
emufolder="$emusFolder" # has to be applications for ES-DE to find it

# initialize execute array
exe=()

# find full path to emu executable
exe_path=$(find "$ShadPS4_emuPath" -iname "${ShadPS4_emuFileName}*.AppImage" | sort -n | cut -d' ' -f 2- | tail -n 1 2>/dev/null)

# if appimage doesn't exist fall back to flatpak
if [[ -z "$exe_path" ]]; then
    # flatpak
    flatpakApp=$(flatpak list --app --columns=application | grep "$ShadPS4_emuName")
    if [[ -z "$flatpakApp" ]]; then
        echo "Flatpak for '$ShadPS4_emuName' not found."
        exit 1
    fi
    exe=("flatpak" "run" "$flatpakApp")
else
    chmod +x "$exe_path"
    exe=("$exe_path")
fi

fileExtension="${@##*.}"

if [[ $fileExtension == "desktop" ]]; then
    # Parse the .desktop file to extract the game path from Exec=
    shadps4DesktopExec=$(grep -E "^Exec=" "${*}" | sed 's/^Exec=//' | sed 's/%%/%/g')

    # Try to extract the quoted game path
    launchParam=$(echo "$shadps4DesktopExec" | grep -oP '"\K[^"]+(?=")')

    # Fallback: take the last word in Exec= line if no quoted path found
    if [[ -z "$launchParam" ]]; then
        launchParam=$(echo "$shadps4DesktopExec" | awk '{print $NF}')
    fi

    launch_args=("-g" "$launchParam")
    echo "Launching: ${exe[*]} ${launch_args[*]}"
    "${exe[@]}" "${launch_args[@]}"
else
    launch_args=()
    for rom in "${@}"; do
        removedLegacySingleQuotes=$(echo "$rom" | sed "s/^'//; s/'$//")
        launch_args+=("$removedLegacySingleQuotes")
    done

    echo "Launching: ${exe[*]} ${launch_args[*]}"

    if [[ -z "${*}" ]]; then
        echo "ROM not found. Launching $ShadPS4_emuName directly"
        "${exe[@]}"
    else
        echo "ROM found, launching game"
        "${exe[@]}" "${launch_args[@]}"
    fi
fi

rm -rf "$savesPath/.gaming"
