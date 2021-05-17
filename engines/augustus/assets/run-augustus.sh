#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

ln -rsf ./assets ./C3/assets
ln -rsf ./maps ./C3/maps

./augustus ./C3
