#!/bin/bash
echo "Managing $1/$2"

ghdl -a ULA/adder_16bits.vhd  ULA/mux4x1_16bits.vhd ULA/ULA.vhd ULA/full_adder.vhd BA/demux8_1bits.vhd BA/dff_e.vhd BA/mux2_3bits.vhd BA/mux2_16bits.vhd BA/mux8_16bits.vhd BA/reg16bit.vhd BA/regBank.vhd BA/ULA_regBank.vhd BA/ULA_regBank_tb.vhd controlUnity/PC.vhd controlUnity/PC_add.vhd controlUnity/PC_add_tb.vhd controlUnity/rom.vhd controlUnity/sttMac1.vhd controlUnity/rom_tb.vhd 

ghdl -e $2

ghdl -r $2 --wave=$2.ghw

gtkwave $2.ghw