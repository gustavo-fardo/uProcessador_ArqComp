library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ctrlUnit is
    port (
        instr : in unsigned (11 downto 0) := "000000000000";
        ULA_src : out std_logic := '0'; -- MUX source do RegA da ULA
        regWr_en: out std_logic := '0'; -- wr_en do regBank
        regWr_src : out std_logic := '0'; -- MUX memória ou acumulador
        PC_src : out std_logic := '0'; -- MUX source do PC
        PC_wr_en : out std_logic := '0'; -- wr_en do PC
        ACM_wr_en : out std_logic := '0'; -- wr_en do ACM
        ACM_src : out std_logic := '0'; -- MUX source do ACM
        ULAop : out unsigned (1 downto 0) := "00" -- selecao de operacoes da ULA
    );
end entity;

architecture ctrlUnit_Arch of ctrlUnit is

    signal opcode : unsigned(3 downto 0);

begin
    opcode <= instr(11 downto 8);

    PC_src <= '1' when opcode = "1111" else -- PCsrc será nosso jump_en
        '0';

    -- ULA_src <=  '0' when opcode="0000" else
    --             '0' when opcode="0001" else
    --             '0' when opcode="0010" else
    --             '0' when opcode="0011" else
    --             '1';
    
    -- ULAsrcB <=  '0' when opcode="0000" else
    --             '0' when opcode="0001" else
    --             '0' when opcode="0010" else
    --             '0' when opcode="0011" else
    --             '1';
    -- ULAop <="00" when opcode="0000" else
    --         "01" when opcode="0001" else
    --         "10" when opcode="0010" else
    --         "11" when opcode="0011" else
    --         "00";   

    regWrite <= '1';
    memToReg <= '1';
    memRead <= '1';
    PCwrite <= '1';
    ULAsrcA <= '0';
    ULAsrcB <= '0';
    ULAop <= "00";

end architecture;