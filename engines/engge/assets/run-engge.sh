#!/bin/bash

ln -rsf ./Resources/ThimbleweedPark.ggpack1 ./ThimbleweedPark.ggpack1
ln -rsf ./Resources/ThimbleweedPark.ggpack2 ./ThimbleweedPark.ggpack2

LD_LIBRARY_PATH="lib:$LD_LIBRARY_PATH" ./engge
