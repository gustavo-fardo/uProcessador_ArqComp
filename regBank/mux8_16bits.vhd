LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                
use ieee.numeric_std.all;

PACKAGE muxInput_pkg IS 
TYPE u_array_8x16 IS ARRAY (7 DOWNTO 0) OF unsigned (15 downto 0);

SUBTYPE muxInput_t IS u_array_8x16;

END muxInput_pkg;

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;       
use ieee.numeric_std.all;

library work;
use work.muxInput_pkg.all;

entity mux8_16bits is 
    port(
        muxInput : in muxInput_t;
        muxCtrl  : in unsigned (2 downto 0);
        muxOut   : out unsigned (15 downto 0)
    );
end entity;

architecture mux8_16bits_arch of mux8_16bits is
    begin
    --p_mux: process muxCtrl,muxInput
    --begin
    muxOut <= muxInput(to_integer( muxCtrl));
    --end process;

end mux8_16bits_arch;