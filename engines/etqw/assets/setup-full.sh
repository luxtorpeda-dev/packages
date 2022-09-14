#!/bin/bash

create_relative_symlink () {
        local -r target=$1
        local -r symlink="linuxdata/$target"
        mkdir -p "$(dirname "$symlink")"
        ln -rsf "$target" "$symlink"
}

mkdir -p ./linuxdata

sh -c "unzip -o ./ETQW-client-1.5-full.x86.run -d ./ linuxdata/*; true"
    
find base -type f  | while read -r file_name ; do
    create_relative_symlink "$file_name"
done
    
rm ./linuxdata/libgcc_s.so.1
rm ./linuxdata/libstdc++.so.6
chmod +x ./linuxdata/{etqw,etqw-dedicated,etqw.x86,*.so,*.so.*,pb/*.so}

chmod 755 ./linuxdata/base/bots
    
rm ETQW-client-1.5-full.x86.run
