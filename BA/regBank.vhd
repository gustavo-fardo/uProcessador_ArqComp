library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.muxInput_pkg.all;

entity regBank is
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
end entity;

architecture regBank_arch of regBank is
      component mux8_16bits is 
            port(
            muxInput : in muxInput_t;
            muxCtrl  : in unsigned (2 downto 0);
            muxOut   : out unsigned (15 downto 0)
            );
      end component;

      component reg16bits is
            port( clk      : in std_logic;
                  rst      : in std_logic;
                  wr_en    : in std_logic;
                  data_in  : in unsigned(15 downto 0);
                  data_out : out unsigned(15 downto 0)
            );
      end component;
         
      component demux8_1bits is 
      port(
          demuxInput : in unsigned (2 downto 0);
          demuxCtrl  : in std_logic := '0';
          demuxOut   : out std_logic_vector(7 downto 0)
      );
      end component;

      ----SIGNAL----
      signal regs_data_array : muxInput_t;
     -- signal regWrite_add_s , reg1_add_s, reg2_add_s   :  unsigned(3 downto 0); 
      --signal regWrite_data, reg1_data_s , reg2_data_s  :  unsigned(15 downto 0);
      signal wr_en_s   : std_logic_vector(7 downto 0);
      
      begin

      reg_gen: for i in 7 downto 1 generate
            reg_map: reg16bits 
                  port map( clk => clk,
                        rst => rst,
                        wr_en => wr_en_s(i),
                        data_in=>regWrite_data,
                        data_out=>regs_data_array(i)
                  );
      end generate;
      reg_zero:   reg16bits 
            port map( clk => clk,
                  rst => '1',
                  wr_en => '0',
                  data_in=>"0000000000000000",
                  data_out=>regs_data_array(0)
      );

      demux_wr_en: demux8_1bits  
            port map(
            demuxInput=>regWrite_add,
            demuxCtrl=>wr_en,
            demuxOut=>wr_en_s
      ); 

      mux_regs1: mux8_16bits
            port map(
            muxInput => regs_data_array,
            muxCtrl=>reg1_add,
            muxOut=>reg1_data
      );

      mux_regs2: mux8_16bits
            port map(
            muxInput => regs_data_array,
            muxCtrl=>reg2_add,
            muxOut=>reg2_data
      );
      

      
end regBank_arch;