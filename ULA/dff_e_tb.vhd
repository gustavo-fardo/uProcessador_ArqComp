library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dff_e_tb is
 end entity;

 architecture dff_e_tb_arch of dff_e_tb is
    component dff_e is
        port( clk      : in std_logic;
              rst      : in std_logic;
              wr_en    : in std_logic;
              data_in  : in std_logic;
              data_out : out std_logic
        );
     end component;
    signal registro,clk     ,
    rst      ,
    wr_en  ,
    data_in   : std_logic:='0';
    signal data_out : std_logic;

    constant period_time : time      := 100 ns;
    signal   finished    : std_logic := '0';

 begin
      dff_e_c: dff_e 
        port map( clk     ,
              rst      ,
              wr_en  ,
              data_in  ,
              data_out 
        );
        process    -- sinal de reset
        begin
           rst <= '1';
           wait for period_time*3 ;
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
           wait for period_time*4;
           data_in <='1'; 

           wait for period_time;
           wr_en      <='0';
           data_in <='0'; 
           wait for period_time;
           --wr_en      <='1';
           rst<='1'; 
           wait for period_time;
           --wr_en      <='0';
           rst<='0';
           data_in <='1'; 
           wait for period_time;
           wr_en      <='1';
           --rst<='0';  
           wait for 2*period_time;
           --wr_en      <='1';
           --rst<='0';
           wait;                     
        end process;
 end architecture dff_e_tb_arch;