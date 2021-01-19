#!/bin/bash

currentDir="$PWD"

create_relative_symlink () {
        local -r target=$1
        local -r symlink="../vkquake2/$2/$target"
        mkdir -p "$(dirname "$symlink")"
        ln -rsf "$target" "$symlink"
}

create_relative_symlink_music () {
        local -r target=$1
        local -r symlink="../vkquake2/$2/$(dirname "$target")/track$(basename "$target")"
        mkdir -p "$(dirname "$symlink")"
        ln -rsf "$target" "$symlink"
}

pushd baseq2
find {pak0.pak,pak1.pak,pak2.pak,players,video} -type f  | while read -r file_name ; do
    create_relative_symlink "$file_name" "baseq2"
done

find music -type f  | while read -r file_name ; do
    create_relative_symlink_music "$file_name" "baseq2"
done

popd

if [ -d "ctf" ]
then
    pushd ctf
    find {pak0.pak,server.cfg} -type f  | while read -r file_name ; do
        create_relative_symlink "$file_name" "ctf"
    done
    popd
fi

if [ -d "rogue" ]
then
    pushd rogue
    find {pak0.pak,video} -type f  | while read -r file_name ; do
        create_relative_symlink "$file_name" "rogue"
    done
    
    find music -type f  | while read -r file_name ; do
        echo "$file_name"
        create_relative_symlink_music "$file_name" "rogue"
    done
    popd
fi

if [ -d "xatrix" ]
then
    pushd xatrix
    find {pak0.pak,video} -type f  | while read -r file_name ; do
        create_relative_symlink "$file_name" "xatrix"
    done
    
    find music -type f  | while read -r file_name ; do
        create_relative_symlink_music "$file_name" "xatrix"
    done
    popd
fi
