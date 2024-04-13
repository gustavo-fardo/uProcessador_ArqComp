library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA_tb is
end entity;

architecture a_ULA_tb of ULA_tb is
    component ULA
        port(
            sel   : in unsigned(1 downto 0);
            ent_a : in unsigned(15 downto 0);
            ent_b : in unsigned(15 downto 0);
            saida : out unsigned(15 downto 0);
            zero  : out std_logic;  --flag zero
            carry : out std_logic   --flag carry
        );
    end component;
    --definicao dos sinais
    signal sel : unsigned(1 downto 0);
    signal ent_a, ent_b, saida : unsigned(15 downto 0);
    signal zero, carry: std_logic;

    begin
        --instancia do component porta
        -- map(pino => sinal)
        uut: ULA port map(sel => sel,
                          ent_a => ent_a,
                          ent_b => ent_b,
                          saida => saida,
                          zero => zero,
                          carry => carry);
                            
        process
        begin
            sel <= "01";
            ent_a <= "0000000000000000";
            ent_b <= "0000000000000001";
            wait for 50 ns;
            ent_a <= "1111111111111111";
            ent_b <= "0000000000000001";
            wait for 50 ns;
            ent_a <= "0000000000000001";
            ent_b <= "0000000000000001";
            wait for 50 ns;
            wait;
        end process;
    end architecture;