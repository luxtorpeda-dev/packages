#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

new_args=(./dosbox)

for var in "$@"
do
    tmp_arg="${var/\\//}"
    echo "$tmp_arg"
    new_args+=("$tmp_arg")
done

new_args+=("-fullscreen")

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" "${new_args[@]}"
