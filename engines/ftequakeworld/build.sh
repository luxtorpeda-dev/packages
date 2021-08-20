#!/bin/bash

# CLONE PHASE
svn checkout https://svn.code.sf.net/p/fteqw/code/trunk fteqw-code

# COPY PHASE
cp -v assets/ftequakeworld.sh "$diststart/common/dist/"
