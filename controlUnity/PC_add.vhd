library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_add is
    port (
        clk , wr_en,rst : in std_logic :='0';
        --data_in : in unsigned(15 downto 0) :="0000000000000000"
        data_out : out unsigned(2 downto 0) :="000"
    );
end entity;

architecture PC_add_Arch of PC_add  is
    component PC is
        port (
            clk , wr_en, rst : in std_logic :='0';
            -- data_in : in unsigned(15 downto 0) :="0000000000000000";
            -- data_out : out unsigned(15 downto 0) :="0000000000000000"
            data_in : in unsigned(2 downto 0) :="000";
            data_out : out unsigned(2 downto 0) :="000"
        );
    end component;
    -- signal data_out_s,data_in : unsigned(15 downto 0) :="0000000000000000" ;
    signal data_out_s,data_in : unsigned(2 downto 0) :="000" ;
    signal rst_s : std_logic :='0';
begin
    PC_comp: PC 
        port map (
            clk=>clk , wr_en=> wr_en, rst=>rst_s, 
            data_in=>data_in, data_out => data_out_s 
        ); 
    data_in<=(data_out_s + 1);
    data_out<=data_out_s;
    rst_s<=rst;
end architecture PC_add_Arch;