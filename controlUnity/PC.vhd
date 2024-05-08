library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
    port (
        clk , wr_en, rst : in std_logic :='0';
        data_in : in unsigned(15 downto 0) :="0000000000000000";
        data_out : out unsigned(15 downto 0) :="0000000000000000"
    );
end entity;

architecture PC_arch of PC is
    component reg16bits is
        port( clk      : in std_logic;
              rst      : in std_logic;
              wr_en    : in std_logic;
              data_in  : in unsigned(15 downto 0);
              data_out : out unsigned(15 downto 0)
        );
     end component;
begin
    reg: reg16bits
        port map( clk=>clk, 
              rst=>rst,
              wr_en=>wr_en,
              data_in=> data_in,
              data_out=> data_out
        );
    
end architecture PC_arch;