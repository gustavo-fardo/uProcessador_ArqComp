library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg16bits is
   port( clk      : in std_logic;
         rst      : in std_logic;
         wr_en    : in std_logic;
         data_in  : in unsigned(15 downto 0);
         data_out : out unsigned(15 downto 0)
   );
end entity;

architecture reg16bits_arch of reg16bits is
   
   component dff_e is
      port( clk      : in std_logic;
            rst      : in std_logic;
            wr_en    : in std_logic;
            data_in  : in std_logic;
            data_out : out std_logic
      );
   end component;

   signal data_out_s, data_in_s: unsigned(15 downto 0);
begin

   gen00: 
   for i in 15 downto 0 generate
      dff_i: dff_e 
      port map( clk=>clk,
      rst=>rst,
      wr_en=>wr_en,
      data_in=>data_in(i),
      data_out=>data_out_s(i)
      );
   end generate;
   
   data_in_s<=data_in;
   data_out <= data_out_s;
end reg16bits_arch;