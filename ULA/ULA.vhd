library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA is
    port(
        sel   : in unsigned(1 downto 0);
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

    component mux4x1_16bits
        port(
            sel   : in  unsigned(1 downto 0);
            ent0  : in  unsigned(15 downto 0);  --adder
            ent1  : in  unsigned(15 downto 0); 
            ent2  : in  unsigned(15 downto 0); 
            ent3  : in  unsigned(15 downto 0);
            saida : out unsigned(15 downto 0)
        );
    end component;

    signal saida_add, saida_sub, saida_op3, saida_op4, saida_mux : unsigned(15 downto 0);

begin
    adder : adder_16bits port map(  ent_a => ent_a,
                                    ent_b => ent_b,
                                    car_in => '0',
                                    saida => saida_add,
                                    car_out => carry);

    mux : mux4x1_16bits port map(   sel => sel,
                                    ent0 => saida_add,
                                    ent1 => saida_sub,
                                    ent2 => saida_op3,
                                    ent3 => saida_op4,
                                    saida => saida_mux);

    saida <= saida_mux;
    zero <= not(saida_mux(0) or saida_mux(1) or saida_mux(2) or saida_mux(3) 
                or saida_mux(4) or saida_mux(5) or saida_mux(6) or saida_mux(7) 
                or saida_mux(8) or saida_mux(9) or saida_mux(10) or saida_mux(11) 
                or saida_mux(12) or saida_mux(13) or saida_mux(14) or saida_mux(15));

end architecture;