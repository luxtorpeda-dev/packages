#!/bin/bash

mkdir -p ./dataconv/

lowercase () {
        echo "$@" | tr '[:upper:]' '[:lower:]'
}

create_relative_symlink () {
        local -r target=$1
        local -r symlink="dataconv/$(lowercase "$target")"
        mkdir -p "$(dirname "$symlink")"
        ln -rsf "$target" "$symlink"
}

if [ ! -f ready ]; then
	find {avp_huds,avp_rifs,fastfile,FMVs,Text} -type f  | while read -r file_name ; do
        	create_relative_symlink "$file_name"
	done

	ln -rsf default.cfg dataconv/default.cfg
	ln -rsf language.txt dataconv/language.txt
	ln -rsf "CD Tracks.txt" dataconv/"cd tracks.txt"

	touch ready
fi

AVP_DATA=dataconv LD_LIBRARY_PATH=./lib ./avp --fullscreen 
