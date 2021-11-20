#!/bin/bash

while getopts "acdemptw" opt; do
  case $opt in
    a) rom="ALEXKIDD_U.68K";;
    b) rom="BEYONDOA_U.68K";;
    c) rom="COMIXZON_U.68K";;
  esac
done

echo "launching $rom"
./blastem "uncompressed ROMs/$rom" # kolla om det funkar eller om det behöver vara typ ROMs/ + $rom eller nåt sånt
