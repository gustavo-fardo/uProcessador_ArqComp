LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;       
use ieee.numeric_std.all;


entity demux8_1bits is 
    port(
        demuxInput : in unsigned (2 downto 0);
        demuxCtrl  : in std_logic := '0';
        demuxOut   : out std_logic_vector(7 downto 0)
    );
end entity;

architecture demux8_1bits_arch of demux8_1bits is
    begin

    gen00: for i in 7 downto 0 generate
        demuxOut(i)<= demuxCtrl when ((to_integer(demuxInput)) = i) else '0';
    end generate ;
end demux8_1bits_arch;


-- p_demux: process 
-- begin
--     -- p_lp0: process
--     -- variable a_var : unsigned (7 donwto 0);
--     -- begin
--         lp0 : for i in 7 downto 0 loop
--             if i /= (to_integer( demuxInput)) then
--                 demuxOut<='0';
--             else 
--                 demuxOut (to_integer (demuxInput))<= demuxCtrl;
--             end if;
--         end loop lp0;
--     -- end process;
-- end process;

