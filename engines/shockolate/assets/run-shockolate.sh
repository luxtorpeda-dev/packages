#!/bin/bash

cd "../SSHOCK"

echo "$PWD"

lowercase () {
	echo "$@" | tr '[:upper:]' '[:lower:]'
}

create_relative_symlink () {
	local -r target=$1
	local -r symlink="res/$(lowercase "$target")"
	mkdir -p "$(dirname "$symlink")"
	ln -rsf "$target" "$symlink"
}


if [ ! -d "./res" ] 
then
    find DATA -type f  | while read -r file_name ; do
        create_relative_symlink "$file_name"
    done

    find SOUND -type f  | while read -r file_name ; do
        create_relative_symlink "$file_name"
    done
fi

LD_LIBRARY_PATH="$LD_LIBRARY_PATH:lib" ./systemshock "$@"
