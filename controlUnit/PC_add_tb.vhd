library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_add_tb is
end entity;

architecture PC_add_tb_arch of PC_add_tb  is
    component PC_add is
        port (
            clk , wr_en,rst : in std_logic :='0';
            --data_in : in unsigned(15 downto 0) :="0000000000000000"
            --data_out : out unsigned(15 downto 0) :="0000000000000000"
            data_out : out unsigned(2 downto 0) :="000"

        );
    end component;
--    signal data_out : unsigned(15 downto 0) :="0000000000000000" ;
    signal data_out : unsigned(2 downto 0) :="000" ;

    signal clk , wr_en,rst : std_logic :='0';

    constant period_time : time      := 100 ns;
    signal   finished    : std_logic := '0';

begin
    PC_comp: PC_add 
        port map (
            clk=>clk , wr_en=> wr_en, rst=>rst, 
            data_out => data_out 
        ); 
    
        process    -- sinal de reset
        begin
           rst <= '1';
           wait for period_time*1 ;
           rst <= '0';
           wait;
        end process;
    
        sim_time_proc: process
        begin
            wait for 10 us;         
            finished <= '1';
            wait;
        end process sim_time_proc;
    
        clk_proc: process
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
           wait for period_time*3;
           wr_en      <='1';

           wait for period_time;
           wr_en      <='0';

           wait for period_time;
           wr_en      <='1';
           wait for period_time;
           wr_en      <='0';
           wait for period_time;
           --wr_en      <='1';
           wait for 2*period_time;
           wr_en      <='1';
           --rst<='0';
           wait;                     
        end process;

end architecture PC_add_tb_arch;