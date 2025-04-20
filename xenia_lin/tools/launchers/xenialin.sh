#!/bin/bash
. "$HOME/.config/EmuDeck/backend/functions/all.sh"
emulatorInit "Xenia" # TODO maybe it need to be changed to xenialin ? 
emuName="xenia_canary" #parameterize me
emufolder="$emusFolder" # has to be applications for ES-DE to find it

#initialize execute array
exe=()

#find full path to emu executable
exe_path=$(find "$emufolder" -iname "${emuName}" | sort -n | cut -d' ' -f 2- | tail -n 1 2>/dev/null)

#if appimage doesn't exist fall back to TODOOOO.

    #make sure that file is executable
    chmod +x "$exe_path"
    
    #fill execute array
    exe=("$exe_path")

#run the executable with the params.
launch_args=()
for rom in "${@}"; do
    # Parsers previously had single quotes ("'/path/to/rom'" ), this allows those shortcuts to continue working.
    removedLegacySingleQuotes=$(echo "$rom" | sed "s/^'//; s/'$//; s/%$//") #TODO i added ; s/%$// because the game in ES-DE was presented with " in the end and breaks . i changed the command in ES-DE so might redo testing ?
    launch_args+=("$removedLegacySingleQuotes")
done

echo "Launching: ${exe[*]} ${launch_args[*]}"

if [[ -z "${*}" ]]; then
    echo "ROM not found. Launching $emuName directly"
    "${exe[@]}"
else
    echo "ROM found, launching game"
    "${exe[@]}" "${launch_args[@]}"
fi

rm -rf "$savesPath/.gaming"
