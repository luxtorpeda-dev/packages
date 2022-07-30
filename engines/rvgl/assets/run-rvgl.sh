#!/bin/bash

if [ ! -f ./rvgl ]; then
    LD_PRELOAD="" LD_LIBRARY_PATH=.7z ./7z/7z x -aoa ./rvgl_21.0930a-1_linux.7z

    #from setup script
    echo "Fixing filenames..."
    shopt -s globstar
    re="^\./[^/]*\.dll$\|^\./lib/.*\.so.*$|^\./licenses/.*$"
    for file in **; do
        dest="./${file,,}"
        file="${dest%/*}"/"${file##*/}"
        if [[ "$file" != "$dest" && ! "$file" =~ $re ]]; then
            [ ! -e "$dest" ] && LD_PRELOAD="" mv -T "$file" "$dest" || LD_PRELOAD="" echo "$file was not renamed"
        fi
    done

    chmod -R ugo+rw ./cache
    chmod -R ugo+rw ./profiles
    chmod -R ugo+rw ./replays
    chmod -R ugo+rw ./times
    chmod ugo+rw ./lib
    chmod ugo+x ./rvgl
    chmod ugo+x ./rvgl.32
    chmod ugo+x ./rvgl.64
    chmod ugo+x ./alsoft_log
    chmod ugo+x ./fix_cases
fi

LD_PRELOAD="" ln -rsf ./music ./redbook

LD_LIBRARY_PATH="$LD_LIBRARY_PATH:lib/lib64:lib" ./rvgl.64
