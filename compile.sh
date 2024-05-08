#!/bin/bash
echo "Managing $2"

ghdl -a ULA/adder_16bits.vhd  ULA/mux4x1_16bits.vhd ULA/ULA.vhd ULA/full_adder.vhd regBank/demux8_1bits.vhd regBank/dff_e.vhd regBank/mux2_3bits.vhd regBank/mux2_16bits.vhd regBank/mux8_16bits.vhd regBank/reg16bit.vhd regBank/regBank.vhd regBank/ULA_regBank.vhd regBank/ULA_regBank_tb.vhd controlUnity/PC.vhd controlUnity/PC_add.vhd controlUnity/PC_add_tb.vhd controlUnity/rom.vhd controlUnity/sttMac1.vhd controlUnity/rom_tb.vhd 

ghdl -e $2