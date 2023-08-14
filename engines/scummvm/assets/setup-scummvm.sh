#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

if [ ! -f scummvm.ini ]; then
    echo "No scummvm.ini file detected, so creating"
    echo -e "[scummvm]" >> scummvm.ini
    echo -e "gfx_mode=surfacesdl" >> scummvm.ini
fi

if [[ -d "../iso_data" ]]; then
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
