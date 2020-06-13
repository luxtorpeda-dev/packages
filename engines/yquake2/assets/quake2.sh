#!/bin/bash

# Some genius packaging Quake 2 for Steam decided to upload default
# config.cfg as a game file. In result:
# - user settings will be reset when installation files are verified
# - yquake2 default configuration can't override some crucial settings
#
# If the default file is removed, yquake2 will pick up defaults from
# pak files and yq2.cfg correctly.

is_in_default_state () {
	echo "$1  $2" | md5sum --status --check -
}

rm_default_config () {
	local -r checksum=$1
	local -r config=$2
	if [ ! -f "$config" ] ; then
		return
	fi
	if is_in_default_state "$checksum" "$config" ; then
		rm -f "$config"
	fi
}

rm_default_config b69548e2817943cb007f1dd147574900 baseq2/config.cfg
rm_default_config 11bf27caf2595b540c5b2700e73dc545 rogue/config.cfg
rm_default_config b5cdf60549ac832497899f739dc89182 xatrix/config.cfg

./quake2 -portable "$@"
