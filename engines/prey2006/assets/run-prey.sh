#!/bin/bash

mkdir -p ./linuxdata/

create_relative_symlink () {
        local -r target=$1
        local -r symlink="linuxdata/$target"
        mkdir -p "$(dirname "$symlink")"
        ln -rsf "$target" "$symlink"
}

if [ ! -f ready ]; then
	find base -type f  | while read -r file_name ; do
        	create_relative_symlink "$file_name"
	done

	cp -r linuxofficial/* linuxdata # Copying instead of symlink, because the engine can't find the original data (it changes the path to linuxofficial incorrectly)
	ln -rsf libSDL-1.2.so.0 linuxdata/libSDL-1.2.so.0

	touch ready
fi

cd linuxdata
./prey
