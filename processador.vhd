library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador is
    port (
        clk, rst : in std_logic := '0';
        state : out unsigned(1 downto 0) := "00";
        PC_data : out unsigned(7 downto 0) := "00000000";
        inst : out unsigned(15 downto 0) := "0000000000000000";
        reg1_data : out unsigned(15 downto 0) := "0000000000000000";
        reg2_data : out unsigned(15 downto 0) := "0000000000000000";
        ac_data : out unsigned(15 downto 0) := "0000000000000000";
        ULAout : out unsigned(15 downto 0) := "0000000000000000"
    );
end entity;

architecture a_processador of processador is

    component sm_fet_dec_exe is
        port (
            clk, rst : in std_logic := '0';
            state : out unsigned(1 downto 0) := "00"
        );
    end component;

    component PC is
        port (
            clk, wr_en, rst : in std_logic := '0';
            data_in : in unsigned(7 downto 0) := "00000000";
            data_out : out unsigned(7 downto 0) := "00000000"
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


    component flagReg is
        port (
        clk :     in std_logic;
        rst :     in std_logic;
        wr_en :   in unsigned(7 downto 0);
        data_in : in unsigned(7 downto 0);
        data_out:out unsigned(7 downto 0)
        );
    end component;

    -- sinais de clock
    signal fetch : std_logic := '0';
    signal wr_inst_reg : std_logic := '0';
    signal decode : std_logic := '0';
    signal execute : std_logic := '0';

    -- extensão de imediato
    signal immediate : unsigned(7 downto 0) := "00000000";
    signal ext_signal : unsigned(7 downto 0) := "00000000";
    signal ext_immediate : unsigned(15 downto 0) := "0000000000000000";

    -- sinais de conexão
    signal state_s : unsigned(1 downto 0) := "00";
    signal PC_src_s : std_logic := '0'; -- MUX source do PC
    signal PC_wr_en_s : std_logic := '0'; -- wr_en do PC
    signal PC_in_s : unsigned(7 downto 0) := "00000000";
    signal PC_out_s : unsigned(7 downto 0) := "00000000";
    signal ROM_data_s : unsigned(15 downto 0) := "0000000000000000";
    signal inst_reg_out_s : unsigned(15 downto 0) := "0000000000000000";
    signal regBank_wr_en_s : std_logic := '0'; -- wr_en do regBank
    signal regWr_src_s : std_logic := '0'; -- MUX memória ou acumulador
    signal regWr_address_s : unsigned(2 downto 0) := "000"; -- endereco banco de registradores
    signal regWr_data_s : unsigned(15 downto 0) := "0000000000000000";
    signal reg1_data_s : unsigned(15 downto 0) := "0000000000000000";
    signal ULAop_s : unsigned (1 downto 0) := "00";
    signal ULA_srcA_s : std_logic := '0'; -- MUX source do RegA da ULA
    signal ULA_srcB_s : std_logic := '0'; -- MUX source do RegB da ULA
    signal ULAentA_s, ULAentB_s, ULAout_s : unsigned(15 downto 0) := "0000000000000000"; -- ULA
    signal flags_in_s, flags_out_s : unsigned(15 downto 0) := "0000000000000000"; -- flags
    signal flag_wr_en : std_logic := '0'; -- wr_en do flag
    signal flagReg_wr_en : unsigned(7 downto 0) := "00000000"; -- wr_en do flag 
    signal ACM_wr_en_s : std_logic := '0'; -- wr_en do ACM
    signal ACM_data_s : unsigned(15 downto 0) := "0000000000000000";

begin
    sm_unit : sm_fet_dec_exe
    port map(
        clk => clk, 
        rst => rst,
        state => state_s
    );

    --clk_0 (ROM) => fetch
    --clk_1 (Instruction Reg) => wr_inst_reg
    --clk_2 (REG_Bank) => decode
    --clk_3 (ACM e PC) => execute
    state <= state_s;
    fetch <= '1' when state_s = "00" else
        '0';
    wr_inst_reg <= '1' when state_s = "01" else
        '0';
    decode <= '1' when state_s = "10" else
        '0';
    execute <= '1' when state_s = "11" else
        '0';

    -- muxPC
    PC_in_s <= immediate when PC_src_s = '1' else
        (PC_out_s + 1);

    pc_unit : PC
    port map(
        clk => execute,
        wr_en => PC_wr_en_s,
        rst => rst,
        data_in => PC_in_s,
        data_out => PC_out_s
    );
    PC_data <= PC_out_s;

    rom_unit : rom
    port map(
        clk => fetch,
        address => PC_out_s,
        data => ROM_data_s
    );

    inst_reg_unit : reg16bits
    port map(
        clk => wr_inst_reg,
        rst => rst,
        wr_en => '1',
        data_in => ROM_data_s,
        data_out => inst_reg_out_s
    );
    inst <= inst_reg_out_s;

    immediate <= ROM_data_s(7 downto 0);
    ext_signal <= "11111111" when ROM_data_s(7) = '1' else
        "00000000";
    ext_immediate <= ext_signal & immediate;

    ctrl_unit : ctrlUnit
    port map(
        instr => inst_reg_out_s,
        ULAop => ULAop_s,
        ULA_srcA => ULA_srcA_s,
        ULA_srcB => ULA_srcB_s,
        regBank_wr_en => regBank_wr_en_s,
        regWr_src => regWr_src_s,
        regWr_address => regWr_address_s,
        ACM_wr_en => ACM_wr_en_s,
        PC_src => PC_src_s,
        PC_wr_en => PC_wr_en_s
    );

    -- muxRegBankWrite
    regWr_data_s <= ext_immediate when regWr_src_s = '1' else
        ACM_data_s;

    regBank_unit : regBank
    port map(
        clk => decode,
        rst => rst,
        wr_en => regBank_wr_en_s,
        wr_add => regWr_address_s,
        wr_data => regWr_data_s,
        reg1_add => regWr_address_s,
        reg1_data => reg1_data_s,
        reg2_add => "000"
        -- reg2_data
    );
    reg1_data <= reg1_data_s;
    --- reg2_data

    -- muxULAa
    ULAentB_s <= ext_immediate when ULA_srcA_s = '1' else
        reg1_data_s;
    -- muxULAb
    ULAentA_s <= "0000000000000000" when ULA_srcB_s = '1' else
        ACM_data_s;

    ULA_unit : ULA
    port map(
        sel => ULAop_s,
        ent_a => ULAentA_s,
        ent_b => ULAentB_s,
        saida => ULAout_s
        negative => flag_in_s(0),
        carry => flag_in_s(1),
        zero => flag_in_s(2),
        overflow => flag_in_s(3)
    );
    ULAout <= ULAout_s;

    flags_reg_unit : reg16bits
    port map(
        clk => execute,
        rst => rst,
        wr_en => flag_wr_en,
        data_in => flag_in_s,
        data_out => flag_out_s
    );

    flagReg_unit: flagReg 
        port map (
            clk => execute,
            rst => rst,
            wr_en => flagReg_wr_en,
            data_in => flag_in_s,
            data_out => flag_out_s
        );

    flag_wr_en <= '1' when opcode (3 downto 2) = "10" else
                  '1' when opcode = "0001" else
                  '0';
    flagReg_wr_en<= "00000000" when flag_wr_en= '0' else
                    "00100000" when opcode (1 downto 0) = "0001" else
                    "01110000" when opcode (1 downto 0) = "1000" else
                    "11111111" when opcode (1 downto 0) = "1001" else
                    "00000000" when opcode (1 downto 0) = "1010" else
                    "00000000" when opcode (1 downto 0) = "1011" else
                    "00000000";


    --relembrando...
    -- negative => flag_in_s(0),
    -- carry => flag_in_s(1),
    -- zero => flag_in_s(2),
    -- overflow => flag_in_s(3)

    -- BEQ <= Zero AND NOT Overflow
    flag_in_s(4) <= flag_in_s(2) AND NOT flag_in_s(3); 
    -- BNE <= NOT Zero AND NOT Overflow
    flag_in_s(5) <= NOT flag_in_s(2) AND NOT flag_in_s(3);
    -- BLT <= Negative AND NOT Zero AND NOT Overflow
    flag_in_s(6) <= flag_in_s(0) AND NOT flag_in_s(2) AND NOT flag_in_s(3);
    -- BGE <= NOT Negative OR Zero 
    flag_in_s(7) <= NOT flag_in_s(0) OR flag_in_s(2); 

    -- BNC <= NOT Carry -- Usar o proprio carry
    -- BC  <= Carry -- Usar o proprio carry

    acm_unit : reg16bits
    port map(
        clk => execute,
        rst => rst,
        wr_en => ACM_wr_en_s,
        data_in => ULAout_s,
        data_out => ACM_data_s
    );
    ac_data <= ACM_data_s;

end architecture;
