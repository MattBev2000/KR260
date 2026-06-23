--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
--Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
--Date        : Thu Jan  2 17:08:02 2025
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
    som240_1_connector_hpa_clk0p_clk : in STD_LOGIC;
    uf1 : out STD_LOGIC
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of kria_starter_kit : entity is "kria_starter_kit,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=kria_starter_kit,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=7,numReposBlks=7,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=3,numPkgbdBlks=0,bdsource=USER,da_board_cnt=3,da_clkrst_cnt=1,da_zynq_ultra_ps_e_cnt=1,synth_mode=Hierarchical}";
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
    pl_clk0 : out STD_LOGIC
  );
  end component kria_starter_kit_zynq_ultra_ps_e_0_0;
  component kria_starter_kit_prescaler_0_0 is
  port (
    data_in : in STD_LOGIC;
    data_out : out STD_LOGIC
  );
  end component kria_starter_kit_prescaler_0_0;
  component kria_starter_kit_clk_wiz_0_0 is
  port (
    reset : in STD_LOGIC;
    clk_in1 : in STD_LOGIC;
    clk_out1 : out STD_LOGIC;
    locked : out STD_LOGIC
  );
  end component kria_starter_kit_clk_wiz_0_0;
  component kria_starter_kit_not_gate_0_2 is
  port (
    a : in STD_LOGIC;
    y : out STD_LOGIC
  );
  end component kria_starter_kit_not_gate_0_2;
  component kria_starter_kit_and_gate_0_0 is
  port (
    a : in STD_LOGIC;
    b : in STD_LOGIC;
    y : out STD_LOGIC
  );
  end component kria_starter_kit_and_gate_0_0;
  component kria_starter_kit_ila_0_1 is
  port (
    clk : in STD_LOGIC;
    probe0 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe2 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe3 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe4 : in STD_LOGIC_VECTOR ( 0 to 0 );
    probe5 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component kria_starter_kit_ila_0_1;
  signal and_gate_0_y : STD_LOGIC;
  signal clk_wiz_0_clk_out1 : STD_LOGIC;
  signal clk_wiz_0_locked : STD_LOGIC;
  signal not_gate_0_y1 : STD_LOGIC;
  signal prescaler_0_data_out : STD_LOGIC;
  signal som240_1_connector_hpa_clk0p_clk_1 : STD_LOGIC;
  signal xlslice_0_Dout : STD_LOGIC_VECTOR ( 0 to 0 );
  signal zynq_ultra_ps_e_0_emio_ttc0_wave_o : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal zynq_ultra_ps_e_0_pl_clk0 : STD_LOGIC;
  signal zynq_ultra_ps_e_0_pl_resetn0 : STD_LOGIC;
  signal NLW_zynq_ultra_ps_e_0_emio_enet0_enet_tsu_timer_cnt_UNCONNECTED : STD_LOGIC_VECTOR ( 93 downto 0 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of som240_1_connector_hpa_clk0p_clk : signal is "xilinx.com:signal:clock:1.0 CLK.SOM240_1_CONNECTOR_HPA_CLK0P_CLK CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of som240_1_connector_hpa_clk0p_clk : signal is "XIL_INTERFACENAME CLK.SOM240_1_CONNECTOR_HPA_CLK0P_CLK, CLK_DOMAIN kria_starter_kit_som240_1_connector_hpa_clk0p_clk, FREQ_HZ 25000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0";
begin
  fan_en_b(0) <= xlslice_0_Dout(0);
  som240_1_connector_hpa_clk0p_clk_1 <= som240_1_connector_hpa_clk0p_clk;
  uf1 <= prescaler_0_data_out;
and_gate_0: component kria_starter_kit_and_gate_0_0
     port map (
      a => clk_wiz_0_clk_out1,
      b => clk_wiz_0_locked,
      y => and_gate_0_y
    );
clk_wiz_0: component kria_starter_kit_clk_wiz_0_0
     port map (
      clk_in1 => som240_1_connector_hpa_clk0p_clk_1,
      clk_out1 => clk_wiz_0_clk_out1,
      locked => clk_wiz_0_locked,
      reset => not_gate_0_y1
    );
ila_0: component kria_starter_kit_ila_0_1
     port map (
      clk => zynq_ultra_ps_e_0_pl_clk0,
      probe0(0) => som240_1_connector_hpa_clk0p_clk_1,
      probe1(0) => not_gate_0_y1,
      probe2(0) => clk_wiz_0_clk_out1,
      probe3(0) => clk_wiz_0_locked,
      probe4(0) => and_gate_0_y,
      probe5(0) => prescaler_0_data_out
    );
not_gate_0: component kria_starter_kit_not_gate_0_2
     port map (
      a => zynq_ultra_ps_e_0_pl_resetn0,
      y => not_gate_0_y1
    );
prescaler_0: component kria_starter_kit_prescaler_0_0
     port map (
      data_in => and_gate_0_y,
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
      pl_ps_irq0(0) => '0',
      pl_resetn0 => zynq_ultra_ps_e_0_pl_resetn0
    );
end STRUCTURE;
