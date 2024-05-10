library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity romPC_tb is
end entity;

architecture romPC_tb_arch of romPC_tb is

    component romPC is
        port (
            clk_pc, clk_rom, wr_en, rst, jmp : in std_logic := '0';
            -- PC_jmp_add : in unsigned(15 downto 0) :="0000000000000000";
            PC_jmp_add : in unsigned(2 downto 0) := "000";
            -- add_out : out unsigned(15 downto 0) :="0000000000000000";
            add_out : out unsigned(2 downto 0) := "000";
            rom_data_out : out unsigned(11 downto 0) := "000000000000"
        );
    end component;

    -- signal PC_jmp_add : in unsigned(15 downto 0) :="0000000000000000";
    signal PC_jmp_add : unsigned(2 downto 0) := "000";
    signal add_out : unsigned(2 downto 0) := "000";
    signal rom_data_out : unsigned(11 downto 0) := "000000000000";
    signal clk, wr_en, rst, jmp : std_logic := '0';

    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';

begin
    romPC_unit : romPC
    port map(
        clk, clk, wr_en, rst, jmp,
        PC_jmp_add,
        add_out,
        rom_data_out
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
        wait for period_time * 3;
        wr_en <= '1';
        wait for period_time;
        wr_en <= '0';
        wait for period_time;
        wr_en <= '1';
        wait for period_time;
        jmp <= '1';
        PC_jmp_add <= "100";
        wait for period_time;
        jmp <= '0';
        wait for 2 * period_time;
        --rst<='0';
        wait;
    end process;

end architecture;