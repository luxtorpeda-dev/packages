#!/bin/bash

export LD_LIBRARY_PATH=lib:$LD_LIBRARY_PATH

set -e

# openmw.cfg is overriden during package update
# import default ini file to handle changes in OpenMW support
#
./openmw-iniimporter Morrowind.ini openmw.cfg

./openmw --data-local "Data Files" "$@" 
