library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity progCalc_tb is
end entity;

architecture progCalc_tb_arch of progCalc_tb is
    component progCalc is
        port (
            clk, rst : in std_logic := '0';
            state : out unsigned(1 downto 0) := "00";
            PC_data : out unsigned(7 downto 0) := "00000000";
            inst : out unsigned(15 downto 0) := "0000000000000000";
            reg1_data : out unsigned(15 downto 0) := "0000000000000000";
            reg2_data : out unsigned(15 downto 0) := "0000000000000000";
            ac_data : out unsigned(15 downto 0) := "0000000000000000";
            ULAout : out unsigned(15 downto 0) := "0000000000000000"
        );
    end component;

    signal clk, rst : std_logic := '0';

    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';

    signal state : unsigned(1 downto 0) := "00";
    signal PC_data : unsigned(7 downto 0) := "00000000";
    signal inst : unsigned(15 downto 0) := "0000000000000000";
    signal reg1_data : unsigned(15 downto 0) := "0000000000000000";
    signal reg2_data : unsigned(15 downto 0) := "0000000000000000";
    signal ac_data : unsigned(15 downto 0) := "0000000000000000";
    signal ULAout : unsigned(15 downto 0) := "0000000000000000";

begin
    progCalc_comp : progCalc
    port map(
        clk,
        rst,
        state,
        PC_data,
        reg1_data,
        reg2_data,
        ac_data,
        ULAout
    );

    sim_time_proc : process
    begin
        wait for 10 us;
        finished <= '1';
        wait;
    end process sim_time_proc;

    process -- sinal de reset
    begin
        rst <= '1';
        wait for period_time * 1;
        rst <= '0';
        wait;
    end process;

    clk_proc : process
    begin
        wait for period_time * 3;
        while finished /= '1' loop
            clk <= '1';
            wait for period_time/2;
            clk <= '0';
            wait for period_time/2;
        end loop;
        wait;
    end process clk_proc;

end architecture;