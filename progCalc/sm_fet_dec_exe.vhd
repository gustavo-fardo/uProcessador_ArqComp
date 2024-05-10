library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sm_fet_dec_exe is
    port (
        clk, rst : in std_logic;
        state : out unsigned(1 downto 0)
    );
end entity;

architecture a_sm_fet_dec_exe of sm_fet_dec_exe is
    signal state_s : unsigned(1 downto 0);
begin
    process (clk, rst)
    begin
        if rst = '1' then
            state_s <= "00";
        elsif rising_edge(clk) then
            if state_s = "10" then -- se agora esta em 2
                state_s <= "00"; -- o prox vai voltar ao zero
            else
                state_s <= state_s + 1; -- senao avanca
            end if;
        end if;
    end process;
    state <= state_s;
end architecture;