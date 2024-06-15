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
      0 => "1100011100100000", --LD  R7, 0x20
      1 => "1100011011111111", --LD  R6, 0xFF
      2 => "1100010100000010", --LD  R5, 0x02
      --Inicializacao
      3 => "0100110100000000", --MOV A, R5
      4 => "1101110100000000", --SW  A, R5
      5 => "1000100000000001", --ADDI A, 0x01
      6 => "0100010100000000", --MOV R5, A
      7 => "0001011100000000", --CMP A, R7
      8 => "1110001011111011", --BLT -5
      --Crivo
      9 => "1100010100000010", --LD  R5, 0x02 
      
      10 => "0100110100000000", --MOV A, R5
      11 => "0100010000000000", --MOV R4, A     --R4 recebe o valor do número primo
      12 => "1000010100000000", --ADD A, R5     --Acum deve ter o valor de R4, incrementando-se R5 (o numero primo)
      13 => "0100010000000000", --MOV R4, A     --Atualiza R4
      14 => "0100111000000000", --MOV A, R6     --A = 0xFF
      15 => "1101110000000000", --SW A, R4      --Escreve 0xFF na posicao R4
      16 => "0100110000000000", --MOV A, R4
      17 => "0001011100000000", --CMP A, R7
      18 => "1110001011111001", --BLT -7
      19 => "0100110100000000", --MOV A, R5
      --Incrementa posicao R5
      20 => "1000100000000001", --ADDI A, 0x01
      21 => "0100010100000000", --MOV R5, A
      22 => "1101010100000000", --LW A, R5
      --Incrementa mais um se for 0xFF
      23 => "0001011000000000", --CMP A, R6
      24 => "1110000011111011", --BEQ -5
      --Conta enquanto R5 for menor que 32
      25 => "0001011100000000", --CMP A, R7
      26 => "1110001011110000", --BLT -16

      --Organiza os primos encontrados na memória
      27 => "1100010100000010", --LD  R5, 0x02 
      28 => "1100010000000000", --LD  R4, 0x00 
      29 => "1101010100000000", --LW A, R5
      --Incrementa mais um se for 0xFF
      30 => "0001011000000000", --CMP A, R6
      31 => "1110000000000101", --BEQ 5
      32 => "1101110000000000", --SW A, R4
      33 => "0100110000000000", --MOV A, R4
      34 => "1000100000000001", --ADDI A, 0x01
      35 => "0100010000000000", --MOV R4, A
      36 => "0100110100000000", --MOV A, R5
      37 => "1000100000000001", --ADDI A, 0x01
      38 => "0100010100000000", --MOV R5, A
      39 => "0001011100000000", --CMP A, R7
      40 => "1110001011110101", --BLT -11
      
      41 => "0101000000000000", --HALT      
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