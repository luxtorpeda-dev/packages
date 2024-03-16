#!/bin/bash

if [ ! -d linuxdata-ra ]; then
    mkdir -p linuxdata-ra/aftermath
    mkdir -p linuxdata-ra/allied
    mkdir -p linuxdata-ra/counterstrike
    mkdir -p linuxdata-ra/soviet
    LD_PRELOAD="" ln -rsf MAIN1.MIX ./linuxdata-ra/allied/MAIN.MIX
    LD_PRELOAD="" ln -rsf MAIN2.MIX ./linuxdata-ra/soviet/MAIN.MIX
    LD_PRELOAD="" ln -rsf MAIN3.MIX ./linuxdata-ra/counterstrike/MAIN.MIX
    LD_PRELOAD="" ln -rsf MAIN4.MIX ./linuxdata-ra/aftermath/MAIN.MIX
    LD_PRELOAD="" ln -rsf EXPAND.MIX ./linuxdata-ra/EXPAND.MIX
    LD_PRELOAD="" ln -rsf EXPAND2.MIX ./linuxdata-ra/EXPAND2.MIX
    LD_PRELOAD="" ln -rsf REDALERT.MIX ./linuxdata-ra/REDALERT.MIX
fi

ln -rsf ./vanillara ./linuxdata-ra/vanillara
cd linuxdata-ra
./vanillara "$@"
