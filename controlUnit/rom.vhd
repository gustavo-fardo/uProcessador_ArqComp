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
      --Escreve 0xF0 no endereço 0x05
      0 => "1100000111110000", --LD  R1, 0xF0
      1 => "0100100100000000", --MOV A, R1
      2 => "1100000100000101", --LD  R1, 0x05
      3 => "1101100100000000", --SW  A, R1
      --Escreve 0x42 no endereço 0x42
      4 => "1100001001000010", --LD  R2, 0x42
      5 => "0100101000000000", --MOV A, R2
      6 => "1100000101000010", --LD  R1, 0x42
      7 => "1101100100000000", --SW  A, R1
      --Le os endereços 0x42 e 0x05
      8 => "0100100000000000", --MOV A, zero
      9 => "1100001101000010", --LD  R3, 0x42
      10 => "1101001100000000", --LW  A, R3
      11 => "1100001100000101", --LD  R3, 0x05
      12 => "1101001100000000", --LW  A, R3
      --Escreve o valor do endereço 0x05 no endereço 0x42
      13 => "1100010001000010", --LD  R4, 0x42
      14 => "1101110000000000", --SW  A, R4
      --Escreve FF nos endereços 0x11, 0x22, 0x33, 0x44 e 0x55
      15 => "1100010111111111", --LD  R5, 0xFF
      16 => "0100110100000000", --MOV A, R5
      17 => "1100011000010001", --LD  R6, 0x11
      18 => "1101111000000000", --SW  A, R6
      19 => "1100011000100010", --LD  R6, 0x22
      20 => "1101111000000000", --SW  A, R6
      21 => "1100011100110011", --LD  R7, 0x33
      22 => "1101111100000000", --SW  A, R7
      23 => "1100011001000100", --LD  R6, 0x44
      24 => "1101111000000000", --SW  A, R6
      25 => "1100011001010101", --LD  R6, 0x55
      26 => "1101111000000000", --SW  A, R6
      --Le 0x33
      27 => "1100011100110011", --LD  R7, 0x33
      28 => "0100100000000000", --MOV A, zero
      29 => "1101011100000000", --LW  A, R7
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