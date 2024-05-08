
LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;       
use ieee.numeric_std.all;



PACKAGE muxInputC_pkg IS 
TYPE u_array_2x3 IS ARRAY ( 1 DOWNTO 0) OF unsigned (2 downto 0);


SUBTYPE muxInput3_t is u_array_2x3;

END muxInputC_pkg;

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;       
use ieee.numeric_std.all;
library work;
use work.muxInputC_pkg.all;

entity mux2_3bits is 
    port(
        muxInput : in muxInput3_t;
        muxCtrl  : in std_logic;
        muxOut   : out unsigned (2 downto 0)
    );
end entity;

architecture mux2_3bits_a of mux2_3bits is
    begin
    --p_mux: process muxCtrl,muxInput
    --begin
    --muxOut <= muxInput(to_integer( muxCtrl));
    muxOut <=    muxInput(0) when muxCtrl='0' else
                muxInput(1) when muxCtrl='1' else
                "000";
    --end process;

end mux2_3bits_a;