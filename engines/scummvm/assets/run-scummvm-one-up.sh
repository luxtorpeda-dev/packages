#!/bin/bash

ORIGINALPWD="$PWD"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

if [ ! -f scummvm.ini ]; then
    echo "No scummvm.ini file detected, so creating"
    echo -e "[scummvm]" >> scummvm.ini
    echo -e "gfx_mode=surfacesdl" >> scummvm.ini
fi

if ! [[ -d "../iso_data" ]]; then
    iso_find=$(find ../ -type f -name "*.iso")
    if ! [ -z "$iso_find" ]; then
        echo "Found iso - $iso_find"

        LD_PRELOAD="" ./xorriso -osirrox on -indev "$iso_find" -extract / ../iso_data
        chmod -R u+w ../iso_data

        for SRC in `find ../iso_data -depth`
        do
            DST=`dirname "${SRC}"`/`basename "${SRC}" | LD_PRELOAD="" tr '[A-Z]' '[a-z]'`
            if [ "${SRC}" != "${DST}" ]
            then
                [ ! -e "${DST}" ] && LD_PRELOAD="" mv -T "${SRC}" "${DST}" || LD_PRELOAD="" echo "${SRC} was not renamed"
            fi
        done

        if [[ -d "../iso_data/wetlands" ]]; then
            LD_PRELOAD="" echo "Found wetlands, fixing files"
            LD_PRELOAD="" ln -rsf ../iso_data/wetlands/* ../iso_data
        fi

        LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/scummvm -c scummvm.ini --add --path=../iso_data --recursive
    fi
fi

if [[ -d "../Original" ]]; then
    echo "Assuming original path for scummvm"
    LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/scummvm -c scummvm.ini --add --path=../Original --recursive
else
    if [[ $DIR == *"ScummVM_Windows"* ]]; then
        echo "Running parent path"
        LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/scummvm -c scummvm.ini --add --path=../../ --recursive
    else
        echo "Running normal path"
        LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./bin/scummvm -c scummvm.ini --add --path=../ --recursive
    fi

fi

cd "$ORIGINALPWD"
cd ..

LD_LIBRARY_PATH="$ORIGINALPWD/scum/lib:$LD_LIBRARY_PATH" "$ORIGINALPWD/scum/bin/scummvm" -c "$ORIGINALPWD/scum/scummvm.ini" --fullscreen --themepath="$ORIGINALPWD/scum/share/scummvm" --add --path=.
LD_LIBRARY_PATH="$ORIGINALPWD/scum/lib:$LD_LIBRARY_PATH" "$ORIGINALPWD/scum/bin/scummvm" -c "$ORIGINALPWD/scum/scummvm.ini" --fullscreen --themepath="$ORIGINALPWD/scum/share/scummvm"
