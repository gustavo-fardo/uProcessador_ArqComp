library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sttMac1 is
    port (
        rst, clk : in std_logic := '0';
        stt : out std_logic := '0'--state '0' or '1'
    );
end entity;

architecture sttMac1_arch of sttMac1 is

    signal stt_s : std_logic := '0';
begin
    process (rst, clk)
    begin
        if rst = '1'
            then
            stt_s <= '0';
        elsif rising_edge(clk) then
            stt_s <= not stt_s;
        end if;
    end process;
    stt <= stt_s;

end sttMac1_arch; -- sttMac1_arch