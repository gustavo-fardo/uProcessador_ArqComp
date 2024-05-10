#!/bin/bash
echo "Managing $1"

ghdl -a regBank/mux8_16bits.vhd # EXCEPITON: Dependency

find ./ -type f -name "*.vhd" -print0 |
while IFS= read -r -d '' file; do
    echo "Compiling $file"
    ghdl -a "$file"
done

ghdl -e $1

ghdl -r $1 --wave=$1.ghw

gtkwave $1.ghw