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

create_relative_symlink_fmvs () {
        local -r target="$(basename "$1")"
        local -r baselower="$(lowercase "$target")"
        if [ "$target" != "$baselower" ]; then
			local -r symlink="FMVs/$(lowercase "$target")"
			ln -rsf "$1" "$symlink"
        fi
}

if [ ! -f ready ]; then
	find {avp_huds,avp_rifs,fastfile,Text} -type f  | while read -r file_name ; do
        	create_relative_symlink "$file_name"
	done

	ln -rsf default.cfg dataconv/default.cfg
	ln -rsf language.txt dataconv/language.txt
	ln -rsf "CD Tracks.txt" dataconv/"cd tracks.txt"

	touch ready
fi

if [ ! -f fmv_ready ]; then
	find FMVs -type f  | while read -r file_name ; do
		create_relative_symlink "$file_name"
	done

	find FMVs -type f  | while read -r file_name ; do
		create_relative_symlink_fmvs "$file_name"
	done

	touch fmv_ready
fi

AVP_DATA=dataconv LD_LIBRARY_PATH=./lib ./avp --fullscreen -g /usr/lib/libGL.so.1
