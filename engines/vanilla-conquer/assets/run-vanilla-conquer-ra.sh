#!/bin/bash

if [ ! -d linuxdata-ra ]; then
    mkdir -p linuxdata-ra
    LD_PRELOAD="" ln -rsf Data/CNCDATA/RED_ALERT/CD1 ./linuxdata-ra/allied
    LD_PRELOAD="" ln -rsf Data/CNCDATA/RED_ALERT/CD1 ./linuxdata-ra/soviet
    LD_PRELOAD="" ln -rsf Data/CNCDATA/RED_ALERT/CD1/EXPAND.MIX ./linuxdata-ra
    LD_PRELOAD="" ln -rsf Data/CNCDATA/RED_ALERT/CD1/EXPAND2.MIX ./linuxdata-ra
    LD_PRELOAD="" ln -rsf Data/CNCDATA/RED_ALERT/CD1/EXPAND2.MIX ./linuxdata-ra
    LD_PRELOAD="" ln -rsf Data/CNCDATA/RED_ALERT/CD1/HIRES.MIX ./linuxdata-ra
    LD_PRELOAD="" ln -rsf Data/CNCDATA/RED_ALERT/CD1/LORES1.MIX ./linuxdata-ra
    LD_PRELOAD="" cp -rfv Data/CNCDATA/RED_ALERT/CD1/REDALERT.INI ./linuxdata-ra
    LD_PRELOAD="" ln -rsf Data/CNCDATA/RED_ALERT/CD1/REDALERT.MIX ./linuxdata-ra
    LD_PRELOAD="" ln -rsf Data/CNCDATA/RED_ALERT/CD1/snow_vtx.pal ./linuxdata-ra
    LD_PRELOAD="" ln -rsf Data/CNCDATA/RED_ALERT/CD1/temp_vtx.pal ./linuxdata-ra
    LD_PRELOAD="" ln -rsf Data/CNCDATA/RED_ALERT/AFTERMATH ./linuxdata-ra/aftermath
    LD_PRELOAD="" ln -rsf Data/CNCDATA/RED_ALERT/COUNTERSTRIKE ./linuxdata-ra/counterstrike
fi

ln -rsf ./vanillara ./linuxdata-ra/vanillara
cd linuxdata-ra
./vanillara "$@"
