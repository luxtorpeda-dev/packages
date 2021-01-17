#!/bin/bash

lowercase () {
	echo "$@" | tr '[:upper:]' '[:lower:]'
}

create_relative_symlink () {
	local -r target=$1
	local -r symlink="res/$(lowercase "$target")"
	mkdir -p "$(dirname "$symlink")"
	ln -rsf "$target" "$symlink"
}

# http://wiki.arx-libertatis.org/Required_data_files_and_checksums

find DATA -type f  | while read -r file_name ; do
	create_relative_symlink "$file_name"
done

find SOUND -type f  | while read -r file_name ; do
	create_relative_symlink "$file_name"
done

LD_LIBRARY_PATH="$LD_LIBRARY_PATH:lib" ./systemshock "$@"
