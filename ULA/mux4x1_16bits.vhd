library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4x1_16bits is
    port(
        sel   : in  unsigned(1 downto 0);
        ent0  : in  unsigned(15 downto 0);
        ent1  : in  unsigned(15 downto 0); 
        ent2  : in  unsigned(15 downto 0); 
        ent3  : in  unsigned(15 downto 0);
        saida : out unsigned(15 downto 0)
    );
end entity;

architecture a_mux4x1_16bits of mux4x1_16bits is
begin
    saida <=    ent0 when sel="00" else
                ent1 when sel="01" else
                ent2 when sel="10" else
                ent3 when sel="11" else
                "0000000000000000";
end architecture;