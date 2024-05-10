library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity demux_tb is

end entity;

architecture demux_tb_a of demux_tb is

    component demux8_1bits is
        port (
            demuxInput : in unsigned (2 downto 0);
            demuxCtrl : in std_logic := '0';
            demuxOut : out std_logic_vector(7 downto 0)
        );
    end component;

    signal demuxInput : unsigned (2 downto 0) := "000";
    signal demuxCtrl : std_logic := '0';
    signal demuxOut : std_logic_vector(7 downto 0) := "00000000";
begin
    demux00 : demux8_1bits
    port map(
        demuxInput,
        demuxCtrl,
        demuxOut
    );
    process
    begin
        wait for 20 ns;
        demuxInput <= "000";
        demuxCtrl <= '1';
        wait for 20 ns;
        demuxCtrl <= '0';
        wait for 20 ns;
        demuxInput <= "010";
        demuxCtrl <= '1';
        wait for 20 ns;
        demuxInput <= "100";
        wait for 20 ns;
        demuxCtrl <= '0';
        wait for 20 ns;
        wait;
    end process;
end demux_tb_a; -- demux_tb_a