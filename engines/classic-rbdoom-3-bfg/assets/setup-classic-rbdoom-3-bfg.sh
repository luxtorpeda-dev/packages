#!/bin/bash

create_relative_symlink () {
    local -r target=$1
    local -r symlink="classic/$target"
    mkdir -p "$(dirname "$symlink")"
    ln -rsf "$target" "$symlink"
}

find base -type f  | while read -r file_name ; do
    create_relative_symlink "$file_name"
done

cp -rfv classic/updatedbase/* classic/base
