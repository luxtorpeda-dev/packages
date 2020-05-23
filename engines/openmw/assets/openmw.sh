#!/bin/bash

export LD_LIBRARY_PATH=lib:$LD_LIBRARY_PATH

set -e

# openmw.cfg is overriden during package update
# import default ini file to handle changes in OpenMW support
#
./bin/openmw-iniimporter Morrowind.ini openmw.cfg

# run OpenMW
#
./bin/openmw --data-local "Data Files" "$@" 
