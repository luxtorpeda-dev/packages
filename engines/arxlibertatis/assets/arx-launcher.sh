#!/bin/bash

lowercase () {
	LD_PRELOAD="" echo "$@" | LD_PRELOAD="" tr '[:upper:]' '[:lower:]'
}

create_relative_symlink () {
	LD_PRELOAD="" local -r target=$1
	LD_PRELOAD="" local -r symlink="share/arx/data/$(LD_PRELOAD="" lowercase "$target")"
	LD_PRELOAD="" mkdir -p "$(LD_PRELOAD="" dirname "$symlink")"
	LD_PRELOAD="" ln -rsf "$target" "$symlink"
}

# http://wiki.arx-libertatis.org/Required_data_files_and_checksums

LD_PRELOAD="" find {misc,Graph} -type f  | while LD_PRELOAD="" read -r file_name ; do
	create_relative_symlink "$file_name"
done
for pak in *.pak ; do
	create_relative_symlink "$pak"
done

./arx-bin --data-dir=share/arx/data "$@"
