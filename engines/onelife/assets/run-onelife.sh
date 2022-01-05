#!/bin/bash

cp -rfv ./settings/* ./linuxdata/settings
cd linuxdata
LD_LIBRARY_PATH=./lib ./OneLifeApp
