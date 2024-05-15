library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity progCalc is
    port (
        clk, rst : in std_logic := '0';
        state : out unsigned(1 downto 0) := "00";
        PC_data : out unsigned(6 downto 0) := "0000000";
        inst : out unsigned(15 downto 0) := "0000000000000000";
        reg1_data : out unsigned(15 downto 0) := "0000000000000000";
        reg2_data : out unsigned(15 downto 0) := "0000000000000000";
        ac_data : out unsigned(15 downto 0) := "0000000000000000";
        ULAout : out unsigned(15 downto 0) := "0000000000000000"
    );
end entity;

architecture a_progCalc of progCalc is

    component sm_fet_dec_exe is
        port (
            clk, rst : in std_logic := '0';
            state : out unsigned(1 downto 0) := "00"
        );
    end component;

    component regBank is
        port (
            clk : in std_logic;
            rst : in std_logic;
            wr_en : in std_logic;
            wr_add : in unsigned(2 downto 0);
            wr_data : in unsigned(15 downto 0);
            reg1_add : in unsigned(2 downto 0);
            reg2_add : in unsigned(2 downto 0);
            reg1_data : out unsigned(15 downto 0);
            reg2_data : out unsigned(15 downto 0)
        );
    end component;

    component reg16bits is
        port (
            clk : in std_logic;
            rst : in std_logic;
            wr_en : in std_logic;
            data_in : in unsigned(15 downto 0);
            data_out : out unsigned(15 downto 0)
        );
    end component;

    component ULA
        port (
            sel : in unsigned(1 downto 0);
            ent_a : in unsigned(15 downto 0);
            ent_b : in unsigned(15 downto 0);
            saida : out unsigned(15 downto 0);
            zero : out std_logic; --flag zero
            carry : out std_logic; --flag carry
            overflow_adder : out std_logic --flag overflow_adder
        );
    end component;

    component PC is
        port (
            clk, wr_en, rst : in std_logic := '0';
            data_in : in unsigned(2 downto 0) := "000";
            data_out : out unsigned(2 downto 0) := "000"
        );
    end component;

    component rom is
        port (
            clk : in std_logic;
            address : in unsigned(7 downto 0);
            data : out unsigned(15 downto 0)
        );
    end component;

    component ctrlUnit is
        port (
            instr : in unsigned (15 downto 0) := "0000000000000000";
            ULAop : out unsigned (1 downto 0) := "00"; -- selecao de operacoes da ULA
            ULA_srcA : out std_logic := '0'; -- MUX source do RegA da ULA
            ULA_srcB : out std_logic := '0'; -- MUX source do RegB da ULA
            regBank_wr_en : out std_logic := '0'; -- wr_en do regBank
            regWr_src : out std_logic := '0'; -- MUX memória ou acumulador
            regWr_address : out unsigned(2 downto 0) := "000"; -- endereco banco de registradores
            ACM_wr_en : out std_logic := '0'; -- wr_en do ACM
            PC_src : out std_logic := '0'; -- MUX source do PC
            PC_wr_en : out std_logic := '0' -- wr_en do PC
        );
    end component;
begin
    sm_unit : sm_fet_dec_exe
    port map(
        clk, rst,
        state
    );

    --clk_0 (ROM) => fetch
    --clk_1 (REG_Bank) => decode
    --clk_2 (ACM e PC) => execute

end architecture;