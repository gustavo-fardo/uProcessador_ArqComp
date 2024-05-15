library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_tb is
end entity;

architecture rom_tb_arch of rom_tb is
    component rom is
        port (
            clk : in std_logic;
            address : in unsigned(7 downto 0);
            data : out unsigned(11 downto 0)
        );
    end component;

    signal data : unsigned(11 downto 0) := "000000000000";
    signal address : unsigned(2 downto 0) := "0000000";
    signal clk : std_logic := '0';

    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';

begin
    rom_comp : rom
    port map(
        clk => clk, address => address, data => data
    );

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

    process
    begin
        wait for period_time * 3;
        address <= "0000001";
        wait for period_time;
        address <= "0000010";
        wait for period_time;
        address <= "0000011";
        wait for period_time;
        address <= "0000100";
        wait for period_time;
        address <= "0000101";
        wait for 2 * period_time;
        wait;
    end process;

end architecture rom_tb_arch;