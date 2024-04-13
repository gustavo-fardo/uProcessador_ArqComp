library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA is
    port(
        ent_a : in unsigned(15 downto 0);
        ent_b : in unsigned(15 downto 0);
        saida : out unsigned(15 downto 0);
        zero  : out std_logic;  --flag zero
        carry : out std_logic   --flag carry
    );
end entity;

architecture a_ULA of ULA is
    component adder_16bits
        port(
            ent_a  : in  unsigned(15 downto 0);
            ent_b  : in  unsigned(15 downto 0);
            car_in : in std_logic;
            saida  : out unsigned(15 downto 0);
            car_out: out std_logic
        );
    end component;

    -- component mux
    --     port(
    --         sel   : in  unsigned(1 downto 0);
    --         ent0  : in  unsigned(15 downto 0);  --adder
    --         ent1  : in  unsigned(15 downto 0); 
    --         ent2  : in  unsigned(15 downto 0); 
    --         ent3  : in  unsigned(15 downto 0);
    --         saida : out unsigned(15 downto 0)
    --     );
    -- end component;

begin
    adder : adder_16bits port map(ent_a=>ent_a,
                                    ent_b=>ent_b,
                                    car_in=>'0',
                                    saida=>saida,
                                    car_out=>carry);
end architecture;