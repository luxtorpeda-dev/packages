#!/bin/bash

cd ../ # game tries to start in system directory, so have to get out and back to the normal directory

cd linuxdata
LD_PRELOAD="$LD_PRELOAD /usr/lib/i386-linux-gnu/pulseaudio/libpulsedsp.so" padsp ./ut
