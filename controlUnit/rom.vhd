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
      0 => "1100010000000101", --LD  R4, 0x05
      1 => "1100010111110000", --LD  R5, 0xF0
      2 => "0100110011110000", --MOV A, R4
      3 => "1101110100000000", --SW  R5, A
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