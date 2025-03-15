#!/bin/bash

# CLONE PHASE
wget https://raw.githubusercontent.com/nwjs/nw.js/refs/heads/nw97/LICENSE

# COPY PHASE
cp -rfv assets/* "$diststart/common/dist/"
