library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ctrlUnit_romPC_tb is
end entity;

architecture ctrlUnit_romPC_tb_arch of ctrlUnit_romPC_tb is
    component ctrlUnit_romPC is
        port(
            clk ,  rst : in std_logic;
            --instr : in unsigned (11 downto 0) :="000000000000";
            ALUsrcA, ALUsrcB, regWrite , memToReg , memRead , PCwrite , PCsource  : out std_logic ;
            ALUop : out unsigned (1 downto 0) 
        );
    end component;

    signal clk , rst : std_logic :='0';

    constant period_time : time      := 100 ns;
    signal   finished    : std_logic := '0';

begin

    ctrlUnit_romPC_comp: ctrlUnit_romPC 
        port map(
            clk ,  rst --,
            --instr : in unsigned (11 downto 0) :="000000000000";
            --ALUsrcA, ALUsrcB, regWrite , memToReg , memRead , PCwrite , PCsource  : out std_logic ;
            --ALUop : out unsigned (1 downto 0) 
        );


    -- process    -- sinal de reset
    -- begin
    --    rst <= '1';
    --    wait for period_time*1 ;
    --    rst <= '0';
    --    wait;
    -- end process;

    sim_time_proc: process
    begin
        wait for 10 us;         
        finished <= '1';
        wait;
    end process sim_time_proc;

    clk_proc: process
    begin
        wait for period_time*3 ;                       
        while finished /= '1' loop
            clk <= '1';
            wait for period_time/2;
            clk <= '0';
            wait for period_time/2;
        end loop;
        wait;
    end process clk_proc;


end architecture;