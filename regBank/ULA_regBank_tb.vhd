library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity ULA_regBank_tb is
end entity;

library work;
use work.muxInput_pkg.all;

architecture ULA_regBank_tb_a of ULA_regBank_tb is
    component ULA_regBank is
        port (
            clk : in std_logic;
            rst : in std_logic;
            wr_en : in std_logic;
            regWrite_add : in unsigned(2 downto 0);
            ct_data : in unsigned(15 downto 0);
            reg1_add : in unsigned(2 downto 0);
            reg2_add : in unsigned(2 downto 0);
            reg1_data : out unsigned(15 downto 0);
            reg2_data : out unsigned(15 downto 0);
            op_sel : in unsigned(1 downto 0);
            reg_Dst, ULAsrc : in std_logic;
            ULAout : out unsigned(15 downto 0) -- non registered
        );

    end component;

    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal wr_en : std_logic := '0';
    signal regWrite_add : unsigned(2 downto 0) := "000";
    signal ct_data : unsigned(15 downto 0) := "0000000000000000";
    signal reg1_add : unsigned(2 downto 0) := "000";
    signal reg2_add : unsigned(2 downto 0) := "000";
    signal reg1_data : unsigned(15 downto 0) := "0000000000000000";
    signal reg2_data : unsigned(15 downto 0) := "0000000000000000";
    signal op_sel : unsigned(1 downto 0) := "00";
    signal reg_Dst, ULAsrc : std_logic := '0';
    signal ULAout : unsigned(15 downto 0) := "0000000000000000";

    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';

begin
    ula_reg_bank00 : ULA_regBank
    port map(
        clk,
        rst,
        wr_en,
        regWrite_add,
        ct_data,
        reg1_add,
        reg2_add,
        reg1_data,
        reg2_data,
        op_sel,
        reg_Dst, ULAsrc,
        ULAout
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
        regWrite_add <= "100";--carrega em x8 0x000F
        ct_data <= "0000000000001111";
        reg1_add <= "000";
        reg2_add <= "000";
        op_sel <= "00";
        reg_Dst <= '1';
        ULAsrc <= '1';
        wait for period_time;
        wr_en <= '1';
        regWrite_add <= "010";
        ct_data <= "0000000011110000";--soma reg x8 com constante 0x00F0 e armazena em x4
        reg1_add <= "100";
        reg2_add <= "000";
        op_sel <= "00";
        reg_Dst <= '1';
        ULAsrc <= '1';
        wait for period_time;
        wr_en <= '1';
        regWrite_add <= "001";
        ct_data <= "0000000000001111";-- faz operacao reg x8 subtracao reg x4 e carrega em reg x1
        reg1_add <= "100";
        reg2_add <= "010";
        op_sel <= "01";
        reg_Dst <= '1';
        ULAsrc <= '0';
        wait;
    end process;

end ULA_regBank_tb_a;