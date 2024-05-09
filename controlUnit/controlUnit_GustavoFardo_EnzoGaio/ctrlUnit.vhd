library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ctrlUnit is
    port(
        instr : in unsigned (11 downto 0) := "000000000000";
        ALUsrcA, ALUsrcB, regWrite , memToReg , memRead , PCwrite , PCsource  : out std_logic := '0';
        ALUop : out unsigned (1 downto 0) := "00" 
    );
end entity;

architecture ctrlUnit_Arch of ctrlUnit is

    signal opcode: unsigned(3 downto 0);

    begin
        opcode <= instr(11 downto 8);

        PCsource <=  '1' when opcode="1111" else -- PCsource será nosso jump_en
                    '0';

        -- ALUsrcA <=  '0' when opcode="0000" else
        --             '0' when opcode="0001" else
        --             '0' when opcode="0010" else
        --             '0' when opcode="0011" else
        --             '1';
        -- ALUsrcB <=  '0' when opcode="0000" else
        --             '0' when opcode="0001" else
        --             '0' when opcode="0010" else
        --             '0' when opcode="0011" else
        --             '1';
        -- ALUop <="00" when opcode="0000" else
        --         "01" when opcode="0001" else
        --         "10" when opcode="0010" else
        --         "11" when opcode="0011" else
        --         "00";   
         
        regWrite <='1' ; memToReg <='1'; memRead <= '1'; PCwrite <= '1'; ALUsrcA <=  '0' ;ALUsrcB <=  '0';ALUop <="00";

end architecture;