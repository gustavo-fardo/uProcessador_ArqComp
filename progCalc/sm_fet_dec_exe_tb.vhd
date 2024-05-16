library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sm_fet_dec_exe_tb is
end entity;

architecture sm_fet_dec_exe_tb_arch of sm_fet_dec_exe_tb is
    component sm_fet_dec_exe is
        port (
            clk, rst : in std_logic;
            state : out unsigned(1 downto 0)
        );
    end component;

    signal clk, rst : std_logic := '0';
    signal state : unsigned(1 downto 0) := "00"; 

    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';

begin
    sm_unit : sm_fet_dec_exe
    port map(
        clk, rst,
        state
    );

    process -- sinal de reset
    begin
        rst <= '1';
        wait for period_time * 1;
        rst <= '0';
        wait;
    end process;

    sim_time_proc : process
    begin
        wait for 10 us;
        finished <= '1';
        wait;
    end process sim_time_proc;

    clk_proc : process
    begin
        while finished /= '1' loop
            clk <= '0';
            wait for period_time/2;
            clk <= '1';
            wait for period_time/2;
        end loop;
        wait;
    end process clk_proc;

end architecture;