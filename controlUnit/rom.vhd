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
      0 => "1100000111110000", --LD  R7, 0x20
      1 => "1100000111110000", --LD  R6, 0x00
      2 => "1100000111110000", --LD  R5, 0x02
      --Inicializacao
      3 => "0100110100000000", --MOV A, R5
      4 => "1101110100000000", --SW  A, R5
      5 => "1000100000000001", --ADDI A, 0x01
      6 => "0100010100000000", --MOV R5, A
      7 => "0001011100000000", --CMP A, R7
      8 => "1110001111111011", --BGE -5
      9 => "0101000000000000", --HALT
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