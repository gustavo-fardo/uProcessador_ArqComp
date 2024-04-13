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

    signal carry : unsigned(14 downto 0);
begin
    add0 : full_adder port map(ent_a=>ent_a(0),
                               ent_b=>ent_b(0),
                               car_in=>car_in,
                               saida=>saida(0),
                               car_out=>carry(0));
                               
    add1 : full_adder port map(ent_a=>ent_a(1),
                               ent_b=>ent_b(1),
                               car_in=>carry(0),
                               saida=>saida(1),
                               car_out=>carry(1));
    
    add2 : full_adder port map(ent_a=>ent_a(2),
                               ent_b=>ent_b(2),
                               car_in=>carry(1),
                               saida=>saida(2),
                               car_out=>carry(2));
    
    add3 : full_adder port map(ent_a=>ent_a(3),
                               ent_b=>ent_b(3),
                               car_in=>carry(2),
                               saida=>saida(3),
                               car_out=>carry(3));
    
    add4 : full_adder port map(ent_a=>ent_a(4),
                               ent_b=>ent_b(4),
                               car_in=>carry(3),
                               saida=>saida(4),
                               car_out=>carry(4));
    
    add5 : full_adder port map(ent_a=>ent_a(5),
                               ent_b=>ent_b(5),
                               car_in=>carry(4),
                               saida=>saida(5),
                               car_out=>carry(5));
    
    add6 : full_adder port map(ent_a=>ent_a(6),
                               ent_b=>ent_b(6),
                               car_in=>carry(5),
                               saida=>saida(6),
                               car_out=>carry(6));
    
    add7 : full_adder port map(ent_a=>ent_a(7),
                               ent_b=>ent_b(7),
                               car_in=>carry(6),
                               saida=>saida(7),
                               car_out=>carry(7));
    
    add8 : full_adder port map(ent_a=>ent_a(8),
                               ent_b=>ent_b(8),
                               car_in=>carry(7),
                               saida=>saida(8),
                               car_out=>carry(8));
    
    add9 : full_adder port map(ent_a=>ent_a(9),
                               ent_b=>ent_b(9),
                               car_in=>carry(8),
                               saida=>saida(9),
                               car_out=>carry(9));
    
    add10 : full_adder port map(ent_a=>ent_a(10),
                                ent_b=>ent_b(10),
                                car_in=>carry(9),
                                saida=>saida(10),
                                car_out=>carry(10));
    
    add11 : full_adder port map(ent_a=>ent_a(11),
                                ent_b=>ent_b(11),
                                car_in=>carry(10),
                                saida=>saida(11),
                                car_out=>carry(11));
    
    add12 : full_adder port map(ent_a=>ent_a(12),
                                ent_b=>ent_b(12),
                                car_in=>carry(11),
                                saida=>saida(12),
                                car_out=>carry(12));
    
    add13 : full_adder port map(ent_a=>ent_a(13),
                                ent_b=>ent_b(13),
                                car_in=>carry(12),
                                saida=>saida(13),
                                car_out=>carry(13));
    
    add14 : full_adder port map(ent_a=>ent_a(14),
                                ent_b=>ent_b(14),
                                car_in=>carry(13),
                                saida=>saida(14),
                                car_out=>carry(14));
    
    add15 : full_adder port map(ent_a=>ent_a(15),
                                ent_b=>ent_b(15),
                                car_in=>carry(14),
                                saida=>saida(15),
                                car_out=>car_out); 
end architecture; 
    