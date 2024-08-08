#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR" && cd ..

sed -i 's/ACD -Ssbpdig.adv -IOS220 -IRQS7 -DMAS1 -Mgenmidi.adv -IOM330 -IRQM2 -DMAM1/ACD -Ssbdig.adv -IOS220 -IRQS7 -DMAS1 -Msbfm.adv -IOM220 -IRQM7 -DMAM1/' arena.conf

shopt -s nocasematch
cur_args=($@)
new_args=(./dosbox-staging/dosbox)
new_args+=("-fullscreen")
new_args+=("-exit")

if [[ -z $cur_args && $LUX_ORIGINAL_EXE_FILE == *"bat" ]]; then
    cur_args=$(cat "$LUX_ORIGINAL_EXE" | grep dosbox)
fi

for var in ${cur_args[@]}
do
    tmp_arg="${var//\\//}"
    if [[ ! -f "$tmp_arg" && $tmp_arg == *"conf" && $tmp_arg != "-"* ]]; then
        tmp_arg=$(basename $tmp_arg | xargs -I% find .. -type f -iname "%")
    elif [[ $tmp_arg == *"bat" ]]; then
        tmp_arg=$(basename $tmp_arg | xargs -I% find .. -type f -iname "%")
    elif [[ $tmp_arg == "-fullscreen" || $tmp_arg == "-noconsole" || $tmp_arg == "-exit" ]]; then
        tmp_arg=""
    fi
    if [[ -n $tmp_arg ]]; then
        new_args+=("$tmp_arg")
    fi
done

echo "run-dosbox-staging.sh: Launching with, ${new_args[@]}"
LD_LIBRARY_PATH="dosbox-staging/lib:$LD_LIBRARY_PATH" "${new_args[@]}"
