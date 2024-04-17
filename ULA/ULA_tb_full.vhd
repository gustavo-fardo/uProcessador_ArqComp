library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA_tb_full is
end entity;

architecture a_ULA_tb_full of ULA_tb_full is
    component ULA
        port(
            sel   : in unsigned(1 downto 0);
            ent_a : in unsigned(15 downto 0);
            ent_b : in unsigned(15 downto 0);
            saida : out unsigned(15 downto 0);
            zero  : out std_logic;  --flag zero
            carry : out std_logic;  --flag carry
            overflow : out std_logic  --flag overflow
        );
    end component;
    --definicao dos sinais
    signal sel : unsigned(1 downto 0):="00";
    signal ent_a, ent_b, saida : unsigned(15 downto 0);

    signal zero, carry, overflow: std_logic;

    begin
        --instancia do component porta
        -- map(pino => sinal)
        uut: ULA port map(sel => sel,
                          ent_a => ent_a,
                          ent_b => ent_b,
                          saida => saida,
                          zero => zero,
                          carry => carry,
                          overflow => overflow);
                            
        process
        variable a_var , b_var , sel_var : integer := 0;
        begin
            loop0: for i in 0 to 7 loop
                a_var:=i;
                ent_a  <=  to_unsigned(a_var, ent_a'length)  ;
                    loop1: for j in 0 to 7 loop
                        b_var:=j;
                        ent_b  <=  to_unsigned(b_var, ent_b'length);
                        loop2: for k in 0 to 3 loop
                            sel_var:=k;
                            sel  <=  to_unsigned(sel_var, sel'length);
                            wait for 5 ns;
                        end loop loop2;
                    end loop loop1;
            end loop loop0;
            wait;
        end process;
end architecture;