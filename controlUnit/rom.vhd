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
      0=>"0100100000000000", --MV A, R0    
      1=>"1000100000001000", --ADDI A, 0x08
      2=>"0100010000000000" ,--MV R4 , A    
      3=>"1000100000000111", --ADDI A, 0x07 
      4=>"1101010000000000", --SUBB A,R4    
      5=>"0100100000000000", --MV A, R0     
      6=>"1000100000001110", --ADDI A, 0x14
      7=>"1001010000000000", --SUB  A , R4  
      8=>"0100010100000000", --SUB  A , R4  
      9=>"0101000000000000", --HALT         
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