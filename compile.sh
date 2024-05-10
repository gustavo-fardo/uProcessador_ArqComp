#!/bin/bash

ghdl -a regBank/mux8_16bits.vhd # EXCEPITON: Dependency

find ./ -type f -name "*.vhd" -print0 |
while IFS= read -r -d '' file; do
    echo "Compiling $file"
    ghdl -a "$file"
done