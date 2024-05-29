library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ctrlUnit is
    port (
        instr : in unsigned (15 downto 0) := "0000000000000000";
        ULAop : out unsigned (1 downto 0) := "00"; -- selecao de operacoes da ULA
        ULA_srcA : out std_logic := '0'; -- MUX source do RegA da ULA
        ULA_srcB : out std_logic := '0'; -- MUX source do RegB da ULA
        regBank_wr_en : out std_logic := '0'; -- wr_en do regBank
        regWr_src : out std_logic := '0'; -- MUX memória ou acumulador
        regWr_address : out unsigned(2 downto 0) := "000"; -- endereco banco de registradores
        ACM_wr_en : out std_logic := '0'; -- wr_en do ACM
        PC_src : out unsigned(1 downto 0) := "00"; -- MUX source do PC
        PC_wr_en : out std_logic := '0' -- wr_en do PC
    );
end entity;

architecture ctrlUnit_Arch of ctrlUnit is

    signal opcode : unsigned(3 downto 0);
    signal funct : std_logic := '0';

begin
    opcode <= instr(15 downto 12);
    funct <= instr(11);
    regWr_address <= instr(10 downto 8);

    -- OP_ctrl (só soma e sub)
    ULAop <= "01" when opcode = "1001" else
        "00";

    -- funct = 1 (com imediato)
    ULA_srcA <= '0' when opcode = "0100" else
        funct;

    -- 1 quando LD para Acumulador ou Mov para Acumulador (Reg ZERO)
    ULA_srcB <= '1' when opcode = "0100" and funct = '1' else
        '1' when opcode = "1100" and funct = '1' else
        '0';

    -- 1 quando LD para Registrador
    regWr_src <= '1' when opcode = "1100" and funct = '0' else
        '0';

    -- 1 quando LD para Registrador e MOV para Registrador
    regBank_wr_en <= '1' when opcode = "0100" and funct = '0' else
        '1' when opcode = "1100" and funct = '0' else
        '0';

    --- 0 quando CMP, LD para Registrador, MOV para Registrador, JMP e CMP
    ACM_wr_en <= '0' when opcode = "0001" and funct = '0' else
        '0' when opcode = "0100" and funct = '0' else
        '0' when opcode = "1100" and funct = '0' else
        '0' when opcode = "1111" else
        '0' when opcode = "0001" else
        '1';

    -- Sempre, por enquanto
    PC_wr_en <= '1';

    -- 1 quando JMP
    PC_src <= "01" when opcode = "1111" else
              "10" when opcode = "1110" else
              "00";

end architecture;