--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
--Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
--Date        : Sat Dec 28 09:33:56 2024
--Host        : Goose running 64-bit major release  (build 9200)
--Command     : generate_target kria_starter_kit.bd
--Design      : kria_starter_kit
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity kria_starter_kit is
  port (
    fan_en_b : out STD_LOGIC_VECTOR ( 0 to 0 );
    uf1 : out STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of kria_starter_kit : entity is "kria_starter_kit,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=kria_starter_kit,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=4,numReposBlks=4,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=1,numPkgbdBlks=0,bdsource=USER,da_board_cnt=2,da_clkrst_cnt=1,da_zynq_ultra_ps_e_cnt=1,synth_mode=Hierarchical}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of kria_starter_kit : entity is "kria_starter_kit.hwdef";
end kria_starter_kit;

architecture STRUCTURE of kria_starter_kit is
  component kria_starter_kit_xlslice_0_0 is
  port (
    Din : in STD_LOGIC_VECTOR ( 2 downto 0 );
    Dout : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component kria_starter_kit_xlslice_0_0;
  component kria_starter_kit_zynq_ultra_ps_e_0_0 is
  port (
    emio_enet0_enet_tsu_timer_cnt : out STD_LOGIC_VECTOR ( 93 downto 0 );
    emio_ttc0_wave_o : out STD_LOGIC_VECTOR ( 2 downto 0 );
    pl_ps_irq0 : in STD_LOGIC_VECTOR ( 0 to 0 );
    pl_resetn0 : out STD_LOGIC;
    pl_clk0 : out STD_LOGIC;
    pl_clk1 : out STD_LOGIC
  );
  end component kria_starter_kit_zynq_ultra_ps_e_0_0;
  component kria_starter_kit_ila_0_0 is
  port (
    clk : in STD_LOGIC;
    probe0 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe2 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe3 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component kria_starter_kit_ila_0_0;
  component kria_starter_kit_prescaler_0_0 is
  port (
    data_in : in STD_LOGIC;
    data_out : out STD_LOGIC
  );
  end component kria_starter_kit_prescaler_0_0;
  signal prescaler_0_data_out : STD_LOGIC;
  signal xlslice_0_Dout : STD_LOGIC_VECTOR ( 0 to 0 );
  signal zynq_ultra_ps_e_0_emio_ttc0_wave_o : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal zynq_ultra_ps_e_0_pl_clk0 : STD_LOGIC;
  signal zynq_ultra_ps_e_0_pl_clk1 : STD_LOGIC;
  signal NLW_zynq_ultra_ps_e_0_pl_resetn0_UNCONNECTED : STD_LOGIC;
  signal NLW_zynq_ultra_ps_e_0_emio_enet0_enet_tsu_timer_cnt_UNCONNECTED : STD_LOGIC_VECTOR ( 93 downto 0 );
begin
  fan_en_b(0) <= xlslice_0_Dout(0);
  uf1 <= prescaler_0_data_out;
ila_0: component kria_starter_kit_ila_0_0
     port map (
      clk => zynq_ultra_ps_e_0_pl_clk0,
      probe0(0) => zynq_ultra_ps_e_0_pl_clk1,
      probe1(0) => prescaler_0_data_out,
      probe2(0) => '0',
      probe3(0) => '0'
    );
prescaler_0: component kria_starter_kit_prescaler_0_0
     port map (
      data_in => zynq_ultra_ps_e_0_pl_clk1,
      data_out => prescaler_0_data_out
    );
xlslice_0: component kria_starter_kit_xlslice_0_0
     port map (
      Din(2 downto 0) => zynq_ultra_ps_e_0_emio_ttc0_wave_o(2 downto 0),
      Dout(0) => xlslice_0_Dout(0)
    );
zynq_ultra_ps_e_0: component kria_starter_kit_zynq_ultra_ps_e_0_0
     port map (
      emio_enet0_enet_tsu_timer_cnt(93 downto 0) => NLW_zynq_ultra_ps_e_0_emio_enet0_enet_tsu_timer_cnt_UNCONNECTED(93 downto 0),
      emio_ttc0_wave_o(2 downto 0) => zynq_ultra_ps_e_0_emio_ttc0_wave_o(2 downto 0),
      pl_clk0 => zynq_ultra_ps_e_0_pl_clk0,
      pl_clk1 => zynq_ultra_ps_e_0_pl_clk1,
      pl_ps_irq0(0) => '0',
      pl_resetn0 => NLW_zynq_ultra_ps_e_0_pl_resetn0_UNCONNECTED
    );
end STRUCTURE;
