library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity progCalc is
    port (
        clk, rst : in std_logic := '0';
        state : out unsigned(1 downto 0) := "00";
        PC : out unsigned(6 downto 0) := "0000000";
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

begin
    sm_unit : sm_fet_dec_exe
    port map(
        clk, rst,
        state
    );

end architecture;