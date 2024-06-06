library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM_tb is
end entity;

architecture RAM_tb_arch of RAM_tb is
    signal address_s : unsigned(6 downto 0) := "0000000";
    signal data_in_s, data_out_s : unsigned(15 downto 0) := "0000000000000000";
    signal wr_en, clk : std_logic := '0';
    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';

    component ram is
        port (
            clk : in std_logic;
            endereco : in unsigned(6 downto 0);
            wr_en : in std_logic;
            dado_in : in unsigned(15 downto 0);
            dado_out : out unsigned(15 downto 0)
        );
    end component;

begin
    ram00 : ram
    port map(
        clk => clk,
        endereco => address_s,
        wr_en => wr_en,
        dado_in => data_in_s,
        dado_out => data_out_s
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
        wait for period_time * 2;
        wr_en <= '1';
        address_s <= "0000001";
        data_in_s <= "1111000011110000";
        wait for period_time * 2;
        address_s <= "0000010";
        data_in_s <= "0000111100001111";
        wait for period_time;
        wr_en <= '0';
        wait;
    end process;

end RAM_tb_arch;