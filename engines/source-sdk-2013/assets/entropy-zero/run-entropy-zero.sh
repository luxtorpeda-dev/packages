#!/bin/bash


if [ ! -f "sdkpath.txt" ]; then
    HL_PATH=$("$STEAM_ZENITY" --file-selection --title="Browse to Source SDK Base 2013 Singleplayer Installation" --directory)

    if [ -z "$HL_PATH" ]; then
        "$STEAM_ZENITY" --error --title="Setup Error" --text="Path to Half Life not given"
        exit 1
    fi

    if [ ! -d "$HL_PATH/sdktools" ]; then
        "$STEAM_ZENITY" --error --title="Setup Error" --text="Path to Source SDK 2013 incorrect"
        exit 1
    fi
    
    echo "$HL_PATH" >> sdkpath.txt
    
    pushd "Entropy Zero/EntropyZero"
    # from z33ky script
    for d in sound materials resource; do
		find "${d}/" -exec sh -eux -c "echo {} | grep -q '[A-Z]' && ln -vs \"\$(basename {})\" \"\$(echo {}|tr '[A-Z]' '[a-z]')\"" \;
	done
	
	sed -Ei -e 's/("clip_size".*)".*"/\1"-1"/p;s/"clip_size"(.*)".*"/"default_clip"\1"1"' -e 's/("item_flags".*)".*"/\1"4" \/\/ ITEM_FLAG_EXHAUSTIBLE/' scripts/weapon_manhacktoss.txt
    popd
fi

sdkpath=`cat sdkpath.txt`

"$sdkpath"/hl2.sh -game "$PWD/Entropy Zero/EntropyZero" -steam
