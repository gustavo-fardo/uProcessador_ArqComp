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
   type mem is array (0 to 255) of unsigned(15 downto 0);
   constant rom_content : mem := (
      -- caso address => conteudo
      0 => "1100001100000000",
      1 => "1100010000000000",
      2 => "0100100000000000",
      3 => "1000010000000000",
      4 => "1000001100000000",
      5 => "0100010000000000",
      6 => "0100101100000000",
      7 => "1000100000000001",
      8 => "0100001100000000",
      9 => "1100010100011110",
      10 => "0001010100000000",
      11 => "1110001011110111",
      12 => "0100100000000000",
      13 => "1000010000000000",
      14 => "0100010100000000",
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
