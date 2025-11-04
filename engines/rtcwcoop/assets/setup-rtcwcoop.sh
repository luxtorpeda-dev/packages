#!/bin/bash

ln -rsf Main rtcwcoop/Main
cp rtcwcoop/rtcwcoop-1.0.2-linux-x86_64/coopmain/bin.pk3 rtcwcoop/coopmain/
cp rtcwcoop/rtcwcoop-1.0.2-linux-x86_64/coopmain/sp_pak_coop1.pk3 rtcwcoop/coopmain/
rm -rf rtcwcoop/rtcwcoop-1.0.2-linux-x86_64/ # we only needed the pk3s
