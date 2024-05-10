library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regBank_tb is
end entity;

architecture regBank_tb_arch of regBank_tb is
    signal regWrite_add_s, reg1_add_s, reg2_add_s : unsigned(2 downto 0) := "000";
    signal regWrite_data_s, reg1_data_s, reg2_data_s : unsigned(15 downto 0) := "0000000000000000";
    signal wr_en, rst, clk : std_logic := '0';
    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';

    component regBank is
        port (
            clk : in std_logic;
            rst : in std_logic;
            wr_en : in std_logic;
            regWrite_add : in unsigned(2 downto 0);
            regWrite_data : in unsigned(15 downto 0);
            reg1_add : in unsigned(2 downto 0);
            reg2_add : in unsigned(2 downto 0);
            reg1_data : out unsigned(15 downto 0);
            reg2_data : out unsigned(15 downto 0)
        );
    end component;

begin
    regbank00 : regBank
    port map(
        clk => clk,
        rst => rst,
        wr_en => wr_en,
        regWrite_add => regWrite_add_s,
        regWrite_data => regWrite_data_s,
        reg1_add => reg1_add_s,
        reg2_add => reg2_add_s,
        reg1_data => reg1_data_s,
        reg2_data => reg2_data_s
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

    process
    begin
        wait for period_time * 2;
        wr_en <= '1';
        regWrite_add_s <= "001";
        regWrite_data_s <= "1111000011110000";
        reg1_add_s <= "000";
        reg2_add_s <= "001";
        wait for period_time * 2;
        --data_in <= "10001101";
        regWrite_add_s <= "010";
        regWrite_data_s <= "0000111100001111";
        reg1_add_s <= "010";
        wait for period_time;
        wr_en <= '0';
        wait;
    end process;

end regBank_tb_arch;