library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA is
    port (
        sel : in unsigned(1 downto 0);
        borrow, carry_borrow : in std_logic ;
        ent_a : in unsigned(15 downto 0);
        ent_b : in unsigned(15 downto 0);
        saida : out unsigned(15 downto 0);
        negative : out std_logic; --flag negative ; )
        zero : out std_logic; --flag zero
        carry : out std_logic; --flag carry
        overflow : out std_logic --flag overflow_adder // 'Flags obrigatórias': ['Carry', 'Overflow', 'Negative'],
    );
end entity;

architecture a_ULA of ULA is
    component adder_16bits
        port (
            ent_a : in unsigned(15 downto 0);
            ent_b : in unsigned(15 downto 0);
            car_in : in std_logic;
            saida : out unsigned(15 downto 0);
            car_out : out std_logic
        );
    end component;

    component mux4x1_16bits
        port (
            sel : in unsigned(1 downto 0);
            ent0 : in unsigned(15 downto 0); --adder
            ent1 : in unsigned(15 downto 0);
            ent2 : in unsigned(15 downto 0);
            ent3 : in unsigned(15 downto 0);
            saida : out unsigned(15 downto 0)
        );
    end component;

    signal saida_add, saida_sub, saida_XOR, saida_AND, saida_mux : unsigned(15 downto 0);
    signal compl2_ent_b , borrow_ent_b : unsigned(15 downto 0);
    signal carry_add, carry_sub : std_logic := '0';

begin
    -- Adicao
    adder : adder_16bits port map(
        ent_a => ent_a,
        ent_b => ent_b,
        car_in => '0',
        saida => saida_add,
        car_out => carry_add);

    -- Subtracao
    compl2_ent_b <= (not(ent_b) + 1) when ent_b(15) = '0' else
        not(ent_b - 1) when ent_b(15) = '1' else
        "0000000000000000";
    borrow_ent_b <= (compl2_ent_b - 1) when borrow = '1' and carry_borrow ='1' else
                     compl2_ent_b     when borrow = '0' else
                     "0000000000000000";


    subtractor : adder_16bits port map(
        ent_a => ent_a,
        ent_b => borrow_ent_b,
        car_in => '0',
        saida => saida_sub,
        car_out => carry_sub);

    --XOR
    saida_XOR <= ent_a xor ent_b;
    --AND
    saida_AND <= ent_a and ent_b;
    -- Multiplexacao do CARRY para subtração e adição -- (é necessário...)

    carry <= (carry_sub and (sel (0) and not sel (1))) --01
        or (carry_add and (not sel(0) and not sel(1))); --00
    --recebe '0' em op3 e op4       

    -- Multiplexacao do resultado
    mux : mux4x1_16bits port map(
        sel => sel,
        ent0 => saida_add,
        ent1 => saida_sub,
        ent2 => saida_XOR,
        ent3 => saida_AND,
        saida => saida_mux);
    saida <= saida_mux;

    -- flag zero
    zero <= not(saida_mux(0) or saida_mux(1) or saida_mux(2) or saida_mux(3)
        or saida_mux(4) or saida_mux(5) or saida_mux(6) or saida_mux(7)
        or saida_mux(8) or saida_mux(9) or saida_mux(10) or saida_mux(11)
        or saida_mux(12) or saida_mux(13) or saida_mux(14) or saida_mux(15));

    -- flag overflow
    overflow <= (
        (ent_a(15) and ent_b(15) and not saida_mux(15)) or
        (not ent_a(15) and not ent_b(15) and saida_mux(15))
        ) when sel = "00" else
        (
        (not ent_a(15) and ent_b(15) and not saida_mux(15)) or
        (ent_a(15) and not ent_b(15) and saida_mux(15))
        ) when sel = "01" else
        '0';
    negative <= saida_mux(15);

end architecture;