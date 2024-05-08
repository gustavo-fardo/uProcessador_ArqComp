library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.muxInput_pkg.all;
use work.muxInputB_pkg.all;
use work.muxInputC_pkg.all;


entity ULA_regBank is
    port( clk            : in std_logic;
          rst            : in std_logic;
          wr_en          : in std_logic;
          regWrite_add   : in unsigned(2 downto 0); 
          ct_data  : in unsigned(15 downto 0);
          reg1_add       : in unsigned(2 downto 0);
          reg2_add       : in unsigned(2 downto 0);
          reg1_data      : out unsigned(15 downto 0);
          reg2_data      : out unsigned(15 downto 0);
          op_sel   : in unsigned(1 downto 0);
          reg_Dst, ULAsrc  : in std_logic;
          ULAout : out unsigned(15 downto 0) -- non registered


    );
 end entity;

architecture ULA_regBank_arch of ULA_regBank is

    component regBank is
        port( clk            : in std_logic;
              rst            : in std_logic;
              wr_en          : in std_logic;
              regWrite_add   : in unsigned(2 downto 0); 
              regWrite_data  : in unsigned(15 downto 0);
              reg1_add       : in unsigned(2 downto 0);
              reg2_add       : in unsigned(2 downto 0);
              reg1_data      : out unsigned(15 downto 0);
              reg2_data      : out unsigned(15 downto 0)
        );
     end component;

     component ULA
     port(
         sel   : in unsigned(1 downto 0);
         ent_a : in unsigned(15 downto 0);
         ent_b : in unsigned(15 downto 0);
         saida : out unsigned(15 downto 0);
         zero  : out std_logic;  --flag zero
         carry : out std_logic;  --flag carry
         overflow_adder : out std_logic  --flag overflow_adder
     );

 end component;

 component mux2_16bits is 
    port(
        muxInput : in muxInput2_t;
        muxCtrl  : in std_logic;
        muxOut   : out unsigned (15 downto 0)
    );
    end component;

    component mux2_3bits is 
    port(
        muxInput : in muxInput3_t;
        muxCtrl  : in std_logic;
        muxOut   : out unsigned (2 downto 0)
    );
    end component;

        signal regWrite_add_s,regWrite_add_mux  : unsigned (2 downto 0);
        signal ULA_in2_s ,ULA_out_s,reg1_data_s,reg2_data_s: unsigned   (15 downto 0);
        signal muxInput2 :muxInput2_t;
        signal muxInput3: muxInput3_t;
        begin
     regbank00: regBank 
        port map( clk,
              rst         ,   
              wr_en          ,
              regWrite_add_mux ,
              ULA_out_s,
              reg1_add       ,
              reg2_add       ,
              reg1_data_s      ,
              reg2_data_s      
        );
        muxULAin: mux2_16bits 
        port map(
           -- muxInput(1)=> ct_data ,muxInput(0)=>reg2_data_s,
           muxInput=>muxInput2,
            muxCtrl=>ULAsrc,  
            muxOut=> ULA_in2_s
        );
        muxInput2(1)<= ct_data ;muxInput2(0)<=reg2_data_s;

        muxInput3(1)<=regWrite_add_s; muxInput3(0)<=reg2_add ;

        muxREGSin: mux2_3bits 
        port map(
        --muxInput(1)=> regWrite_add_s, muxInput(0)=>reg2_add ,
        muxInput=>muxInput3,
        muxCtrl  => reg_Dst,
        muxOut   => regWrite_add_mux
        );

        ULA00: ULA
        port map(
            sel=>  op_sel ,
            ent_a=> reg1_data_s,
            ent_b =>ULA_in2_s,
            saida =>ULA_out_s
            --zero  =>zero,
            --carry =>carry,
            --overflow_adder=> overflow_adder
        );
        regWrite_add_s<=regWrite_add;
        reg1_data<=reg1_data_s;
        reg2_data<=reg2_data_s;
        ULAout<=ULA_out_s;

end ULA_regBank_arch;