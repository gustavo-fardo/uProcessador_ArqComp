library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity romPC is
    port (
        clk , wr_en, rst , jmp : in std_logic :='0';
        -- PC_jmp_add : in unsigned(15 downto 0) :="0000000000000000";
        PC_jmp_add : in unsigned(2 downto 0) :="000";
        add_out : out unsigned(2 downto 0) :="000"; --espelhamento do PC
        rom_data_out : out unsigned(11 downto 0) :="000000000000"
    );
end entity;

architecture romPC_arch of romPC is
    
    component PC is
        port (
            clk , wr_en, rst : in std_logic :='0';
            -- data_in : in unsigned(15 downto 0) :="0000000000000000";
            -- data_out : out unsigned(15 downto 0) :="0000000000000000"
            data_in : in unsigned(2 downto 0) :="000";
            data_out : out unsigned(2 downto 0) :="000"


        );
    end component;

     component rom is
        port( clk      : in std_logic;
              endereco : in unsigned(2 downto 0);
              dado     : out unsigned(11 downto 0) 
        );
     end component;
     --signal PC_in , PC_out , rom_in :  unsigned(15 downto 0) :="0000000000000000";
     signal PC_in , PC_out  :  unsigned(2 downto 0) :="000";
    --  signal clk_s,wr_en,rst_s,jmp_s : std_logic :='0';
begin
    PC_unit: PC
        port map (
            clk , wr_en, rst ,
            -- data_in : in unsigned(15 downto 0) :="0000000000000000";
            -- data_out : out unsigned(15 downto 0) :="0000000000000000"
            data_in => PC_in,
            data_out=> PC_out
        );

    rom_unit: rom
        port map ( clk ,
              endereco => PC_out , 
              dado => rom_data_out
        );
    
    PC_in <= (PC_out + 1)  when jmp = '0'  -- MULTIPLEXAR A ENTRADA DO PC
        else PC_jmp_add  when jmp = '1'  
        else "000" ; 
        --else "0000000000000000"; 
    
    
    
    
    
end architecture romPC_arch;