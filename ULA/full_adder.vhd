library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
    port (
        ent_a : in std_logic;
        ent_b : in std_logic;
        car_in : in std_logic;
        saida : out std_logic;
        car_out : out std_logic
    );
end entity;

architecture a_full_adder of full_adder is
begin
    car_out <= (ent_b and ent_a) or (car_in and (ent_a or ent_b));
    saida <= ((ent_a or ent_b) and not (ent_b and ent_a)) xor car_in;
end architecture;