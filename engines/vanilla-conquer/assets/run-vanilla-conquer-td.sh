#!/bin/bash

if [ ! -d linuxdata-td ]; then
    mkdir -p linuxdata-td
    LD_PRELOAD="" ln -rsf Data/CNCDATA/TIBERIAN_DAWN/CD3 ./linuxdata-td/covertops
    LD_PRELOAD="" ln -rsf Data/CNCDATA/TIBERIAN_DAWN/CD1 ./linuxdata-td/gdi
    LD_PRELOAD="" ln -rsf Data/CNCDATA/TIBERIAN_DAWN/CD2 ./linuxdata-td/nod
    LD_PRELOAD="" ln -rsf Data/CNCDATA/TIBERIAN_DAWN/CD1/* ./linuxdata-td
fi

ln -rsf ./vanillatd ./linuxdata-td/vanillatd
cd linuxdata-td
./vanillatd "$@"
