#!/bin/bash

if [ ! -f fs1.vp ]; then
    gunzip fs1.vp.gz
fi

if [ ! -f intro.mve ]; then
    ln -rsf ./data1/Data/movies/Intro.mve ./intro.mve
    ln -rsf ./data1/Data/movies/ancients1.mve ./ancients1.mve
    ln -rsf ./data1/Data/movies/CommandBrief.mve ./commandbrief.mve
    ln -rsf ./data1/Data/movies/lab.mve ./lab.mve

    ln -rsf ./data2/data/movies/ancients2.mve ./ancients2.mve
    ln -rsf ./data2/data/movies/ancients3.mve ./ancients3.mve
    ln -rsf ./data2/data/movies/ancients4.mve ./ancients4.mve
    ln -rsf ./data2/data/movies/ancients5.mve ./ancients5.mve
    ln -rsf ./data2/data/movies/ENDGAME.MVE ./endgame.mve
    ln -rsf ./data2/data/movies/hallfight.mve ./hallfight.mve
fi

LD_LIBRARY_PATH="./lib:$LD_LIBRARY_PATH" ./freespace
