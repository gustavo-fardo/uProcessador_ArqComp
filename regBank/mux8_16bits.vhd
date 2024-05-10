library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package muxInput_pkg is
    type u_array_8x16 is array (7 downto 0) of unsigned (15 downto 0);

    subtype muxInput_t is u_array_8x16;

end muxInput_pkg;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.muxInput_pkg.all;

entity mux8_16bits is
    port (
        muxInput : in muxInput_t;
        muxCtrl : in unsigned (2 downto 0);
        muxOut : out unsigned (15 downto 0)
    );
end entity;

architecture mux8_16bits_arch of mux8_16bits is
begin
    --p_mux: process muxCtrl,muxInput
    --begin
    muxOut <= muxInput(to_integer(muxCtrl));
    --end process;

end mux8_16bits_arch;