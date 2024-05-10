#!/bin/bash
echo "Managing $1/$2"

ghdl -a regBank/mux8_16bits.vhd # EXCEPITON: Dependency

find ./ -type f -name "*.vhd" -print0 |
while IFS= read -r -d '' file; do
    echo "Compiling $file"
    ghdl -a "$file"
done

ghdl -e $2

ghdl -r $2 --wave=$2.ghw

gtkwave $2.ghw