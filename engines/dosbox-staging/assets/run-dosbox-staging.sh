#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

new_args=(./dosbox)
new_args+=("-fullscreen")

for var in "$@"
do
    tmp_arg="${var/\\//}"
    if [[ $tmp_arg != *"-"* ]]; then
        tmp_arg=$(basename $tmp_arg | xargs -I% find .. -type f -iname "%")
    fi
    echo "$tmp_arg"
    new_args+=("$tmp_arg")
done

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" "${new_args[@]}"
