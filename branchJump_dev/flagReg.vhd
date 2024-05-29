library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity flagReg is
   port (
      clk :     in std_logic;
      rst :     in std_logic;
      wr_en :   in unsigned(7 downto 0);
      data_in : in unsigned(7 downto 0);
      data_out:out unsigned(7 downto 0)
   );
end entity;

architecture flagReg_arch of flagReg is

   component dff_e is
      port (
         clk : in std_logic;
         rst : in std_logic;
         wr_en : in std_logic;
         data_in : in std_logic;
         data_out : out std_logic
      );
   end component;

begin

   gen00 :
   for i in 15 downto 0 generate
      dff_i : dff_e
      port map(
         clk => clk,
         rst => rst,
         wr_en => wr_en(i),
         data_in => data_in(i),
         data_out => data_out(i)
      );
   end generate;


end flagReg_arch;