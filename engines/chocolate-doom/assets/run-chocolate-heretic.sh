#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

export LD_LIBRARY_PATH="$DIR/lib:$LD_LIBRARY_PATH"

cur_args=($@)
new_args=()

one_after=""

for var in ${cur_args[@]}
do
    tmp_arg="${var//\\//}"

    if [ "$one_after" = "1" ]; then
        tmp_arg=""
        one_after=""
    fi

    if [[ $tmp_arg == *"-savedir"* ]]; then
        if [[ -z "${LUX_STEAM_CLOUD}" ]]; then
            # if steam cloud is disabled
            tmp_arg=""
            one_after="1"
        fi
    fi

    if [[ -n $tmp_arg ]]; then
        new_args+=("$tmp_arg")
    fi
done

echo "Launching with, ${new_args[@]}"
"$DIR/chocolate-heretic" "${new_args[@]}"
