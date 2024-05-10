library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ctrlUnit_romPC is
    port (
        clk, rst : in std_logic;
        --instr : in unsigned (11 downto 0) :="000000000000";
        ULAsrcA, ULAsrcB, regWrite, memToReg, memRead, PCwrite, PCsource : out std_logic;
        ULAop : out unsigned (1 downto 0)
    );
end entity;

architecture ctrlUnit_romPC_arch of ctrlUnit_romPC is

    component ctrlUnit is
        port (
            instr : in unsigned (11 downto 0) := "000000000000";
            ULAsrcA, ULAsrcB, regWrite, memToReg, memRead, PCwrite, PCsource : out std_logic := '0';
            ULAop : out unsigned (1 downto 0) := "00"
        );
    end component;

    component romPC is
        port (
            clk_pc, clk_rom, wr_en, rst, jmp : in std_logic := '0';
            -- PC_jmp_add : in unsigned(15 downto 0) :="0000000000000000";
            PC_jmp_add : in unsigned(2 downto 0) := "000";
            add_out : out unsigned(2 downto 0) := "000"; --espelhamento do PC
            rom_data_out : out unsigned(11 downto 0) := "000000000000"
        );
    end component;

    component sttMac1 is
        port (
            rst, clk : in std_logic := '0';
            stt : out std_logic := '0'--state '0' or '1'
        );
    end component;

    -- signal PC_jmp_add : in unsigned(15 downto 0) :="0000000000000000";
    signal PC_jmp_add : unsigned(2 downto 0) := "000";
    signal add_out : unsigned(2 downto 0) := "000";
    signal instr : unsigned (11 downto 0) := "000000000000";
    signal ULAsrcA_s, ULAsrcB_s, regWrite_s, memToReg_s, memRead_s, PCwrite_s, PCsource_s : std_logic;

    -- signal clk , wr_en, rst , jmp :  std_logic :='0';
    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';
    signal decode, execute, stt : std_logic := '0';

begin
    sttMac_cmp : sttMac1
    port map(
        rst, clk,
        stt
    );

    decode <= stt; -- when stt = 1
    execute <= not stt; -- when stt = 0

    romPC_cmp : romPC
    port map(
        clk_pc => execute,
        clk_rom => decode,
        wr_en => PCwrite_s,
        rst => rst,
        jmp => PCsource_s,
        PC_jmp_add => PC_jmp_add,
        add_out => add_out,
        rom_data_out => instr -- rom_data_out
    );

    PC_jmp_add <= instr (7 downto 5);

    ctrlUnit_cmp : ctrlUnit
    port map(
        instr => instr,
        -- ULAsrcA, 
        --ULAsrcB, 
        --regWrite , 
        --memToReg , 
        --memRead , 
        PCwrite => PCwrite_s,
        PCsource => PCsource_s --,
        --ULAop 
    );

end architecture;