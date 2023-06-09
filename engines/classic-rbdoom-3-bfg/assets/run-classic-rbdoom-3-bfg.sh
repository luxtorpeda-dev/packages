#!/bin/bash

create_relative_symlink () {
    local -r target=$1
    local -r symlink="classic/$target"
    LD_PRELOAD="" mkdir -p "$(LD_PRELOAD="" dirname "$symlink")"
    LD_PRELOAD="" ln -rsf "$target" "$symlink"
}

LD_PRELOAD="" find base -type f  | while LD_PRELOAD="" read -r file_name ; do
    create_relative_symlink "$file_name"
done

LD_PRELOAD="" cp -rfv classic/updatedbase/* classic/base

cd classic
mkdir lib
LD_PRELOAD="" ln -rsf ./open-platform/linux64/OpenPlatformx86_64.so ./base/OpenPlatformx86_64.so
LD_PRELOAD="" ln -rsf ./open-platform/linux64/libsteam_api.so ./lib/libsteam_api.so

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./DoomBFA "$@"
