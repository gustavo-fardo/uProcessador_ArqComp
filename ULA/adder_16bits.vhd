library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_16bits is
    port(
        ent_a  : in  unsigned(15 downto 0);
        ent_b  : in  unsigned(15 downto 0);
        car_in : in std_logic;
        saida  : out unsigned(15 downto 0);
        car_out: out std_logic
    );
end entity;

architecture a_adder_16bits of adder_16bits is
    component full_adder
        port(
            ent_a  : in std_logic;
            ent_b  : in std_logic;
            car_in : in std_logic;
            saida  : out std_logic;
            car_out: out std_logic
        );
    end component;

    signal carry_s : unsigned(16 downto 0);
begin

    gen00: for i in 15 downto 0 generate:
        addi: full_adder port map
            (ent_a=>ent_a(i),
            ent_b=>ent_b(i),
            car_in=>carry_s(i),
            saida=>saida(i),
            car_out=>carry_s(i+1));
    end generate;
        carry_s(0)<=car_in;
        car_out<=carry_s(16);
end architecture; 
    