#!/bin/bash

sudo apt-get -y install svn

# CLONE PHASE
svn checkout https://svn.code.sf.net/p/fteqw/code/trunk source

# COPY PHASE
cp -v assets/ftequakeworld.sh "$diststart/common/dist/"
