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
      0 => "1100001100000101",
      1 => "1100010000001000",
      2 => "0100100000000000",
      3 => "1000010000000000",
      4 => "1000001100000000",
      5 => "0100010100000000",
      6 => "1001100000000001",
      7 => "0100010100000000",
      8 => "1111000000010100",
      9 => "1100001100000000",
      10 => "0000000000000000",
      11 => "0000000000000000",
      12 => "0000000000000000",
      13 => "0000000000000000",
      14 => "0000000000000000",
      15 => "0000000000000000",
      16 => "0000000000000000",
      17 => "0000000000000000",
      18 => "0000000000000000",
      19 => "0000000000000000",
      20 => "0100110100000000",
      21 => "0100001100000000",
      22 => "1111000000000010",
      23 => "1100001100000000",
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