#!/bin/bash
echo "Managing $1/$2"

ghdl -a ULA/adder_16bits.vhd  ULA/mux4x1_16bits.vhd ULA/ULA.vhd ULA/full_adder.vhd regBank/demux8_1bits.vhd regBank/dff_e.vhd regBank/mux2_3bits.vhd regBank/mux2_16bits.vhd regBank/mux8_16bits.vhd regBank/reg16bit.vhd regBank/regBank.vhd regBank/ULA_regBank.vhd regBank/ULA_regBank_tb.vhd controlUnit/PC.vhd controlUnit/PC_add.vhd controlUnit/PC_add_tb.vhd controlUnit/rom.vhd controlUnit/sttMac1.vhd controlUnit/rom_tb.vhd controlUnit/romPC.vhd

ghdl -a $2.vhd

ghdl -e $2

ghdl -r $2 --wave=$2.ghw

gtkwave $2.ghw