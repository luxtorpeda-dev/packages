#!/bin/bash

lowercase () {
	echo "$@" | tr '[:upper:]' '[:lower:]'
}

create_relative_symlink () {
	local -r target=$1
	local -r symlink="share/arx/data/$(lowercase "$target")"
	LD_PRELOAD="" mkdir -p "$(dirname "$symlink")"
	LD_PRELOAD="" ln -rsf "$target" "$symlink"
}

# http://wiki.arx-libertatis.org/Required_data_files_and_checksums

LD_PRELOAD="" find {misc,Graph} -type f  | while read -r file_name ; do
	create_relative_symlink "$file_name"
done
for pak in *.pak ; do
	create_relative_symlink "$pak"
done

./arx-bin --data-dir=share/arx/data "$@"
