
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package muxInputB_pkg is
    type u_array_2x16 is array (1 downto 0) of unsigned (15 downto 0);

    subtype muxInput2_t is u_array_2x16;

end muxInputB_pkg;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.muxInputB_pkg.all;

entity mux2_16bits is
    port (
        muxInput : in muxInput2_t;
        muxCtrl : in std_logic;
        muxOut : out unsigned (15 downto 0)
    );
end entity;

architecture mux2_16bits_a of mux2_16bits is
begin
    --p_mux: process muxCtrl,muxInput
    --begin
    muxOut <= muxInput(0) when muxCtrl = '0' else
        muxInput(1) when muxCtrl = '1' else
        "0000000000000000";
    --end process;

end mux2_16bits_a;