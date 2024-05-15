library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity rom is
   port (
      clk : in std_logic;
      address : in unsigned(7 downto 0);
      data : out unsigned(15 downto 0)
   );
end entity;
architecture a_rom of rom is
   type mem is array (7 downto 0) of unsigned(15 downto 0);
   constant rom_content : mem := (
      -- caso address => conteudo
      0 => "0000000000000000",
      1 => "1000000000010000",
      2 => "1111111000100000",
      3 => "0000000000110000",
      4 => "1000000101000000",
      5 => "0000000001010000",
      6 => "1111010001100000",
      7 => "0000000001110000",
      -- => (zero em todos os bits)
      others => (others => '0')
   );
begin
   process (clk)
   begin
      if (rising_edge(clk)) then
         data <= rom_content(to_integer(address));
      end if;
   end process;
end architecture;