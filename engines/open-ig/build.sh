#!/bin/bash

# CLONE PHASE
wget https://raw.githubusercontent.com/akarnokd/open-ig/refs/heads/master/LICENSE.txt

# COPY PHASE
cp -rfv assets/* "$diststart/573790/dist/"
