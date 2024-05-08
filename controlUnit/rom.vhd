library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity rom is
   port( clk      : in std_logic;
         endereco : in unsigned(2 downto 0);
         dado     : out unsigned(11 downto 0) 
   );
end entity;
architecture a_rom of rom is
   type mem is array (7 downto 0) of unsigned(11 downto 0);
   constant conteudo_rom : mem := (
      -- caso endereco => conteudo
      0  => "000000000000",
      1  => "100000000001",
      2  => "111111100010",
      3  => "000000000011",
      4  => "100000010100",
      5  => "000000000101",
      6  => "111101000110",
      7  => "000000000111",
      -- => (zero em todos os bits)
      others => (others=>'0')
   );
begin
   process(clk)
   begin
      if(rising_edge(clk)) then
         dado <= conteudo_rom(to_integer(endereco));
      end if;
   end process;
end architecture;