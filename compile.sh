#!/bin/bash
echo "Managing $2"

find ./ -type f -name "*.vhd" -print0 |
while IFS= read -r -d '' file; do
    echo "Compiling $file"
    ghdl -a "$file"
done

ghdl -e $2