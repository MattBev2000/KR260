--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
--Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
--Date        : Sat Jan  4 14:41:55 2025
--Host        : Goose running 64-bit major release  (build 9200)
--Command     : generate_target core_init_mk_III.bd
--Design      : core_init_mk_III
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity core_init_mk_III is
  port (
    fan_en_b : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of core_init_mk_III : entity is "core_init_mk_III,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=core_init_mk_III,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=2,numReposBlks=2,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=Hierarchical}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of core_init_mk_III : entity is "core_init_mk_III.hwdef";
end core_init_mk_III;

architecture STRUCTURE of core_init_mk_III is
  component core_init_mk_III_xlslice_0_0 is
  port (
    Din : in STD_LOGIC_VECTOR ( 2 downto 0 );
    Dout : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component core_init_mk_III_xlslice_0_0;
  component core_init_mk_III_zynq_ultra_ps_e_0_0 is
  port (
    emio_enet0_enet_tsu_timer_cnt : out STD_LOGIC_VECTOR ( 93 downto 0 );
    emio_ttc0_wave_o : out STD_LOGIC_VECTOR ( 2 downto 0 );
    pl_ps_irq0 : in STD_LOGIC_VECTOR ( 0 to 0 );
    pl_resetn0 : out STD_LOGIC;
    pl_clk0 : out STD_LOGIC;
    pl_clk1 : out STD_LOGIC
  );
  end component core_init_mk_III_zynq_ultra_ps_e_0_0;
  signal xlslice_0_Dout : STD_LOGIC_VECTOR ( 0 to 0 );
  signal zynq_ultra_ps_e_0_emio_ttc0_wave_o : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal NLW_zynq_ultra_ps_e_0_pl_clk0_UNCONNECTED : STD_LOGIC;
  signal NLW_zynq_ultra_ps_e_0_pl_clk1_UNCONNECTED : STD_LOGIC;
  signal NLW_zynq_ultra_ps_e_0_pl_resetn0_UNCONNECTED : STD_LOGIC;
  signal NLW_zynq_ultra_ps_e_0_emio_enet0_enet_tsu_timer_cnt_UNCONNECTED : STD_LOGIC_VECTOR ( 93 downto 0 );
begin
  fan_en_b(0) <= xlslice_0_Dout(0);
xlslice_0: component core_init_mk_III_xlslice_0_0
     port map (
      Din(2 downto 0) => zynq_ultra_ps_e_0_emio_ttc0_wave_o(2 downto 0),
      Dout(0) => xlslice_0_Dout(0)
    );
zynq_ultra_ps_e_0: component core_init_mk_III_zynq_ultra_ps_e_0_0
     port map (
      emio_enet0_enet_tsu_timer_cnt(93 downto 0) => NLW_zynq_ultra_ps_e_0_emio_enet0_enet_tsu_timer_cnt_UNCONNECTED(93 downto 0),
      emio_ttc0_wave_o(2 downto 0) => zynq_ultra_ps_e_0_emio_ttc0_wave_o(2 downto 0),
      pl_clk0 => NLW_zynq_ultra_ps_e_0_pl_clk0_UNCONNECTED,
      pl_clk1 => NLW_zynq_ultra_ps_e_0_pl_clk1_UNCONNECTED,
      pl_ps_irq0(0) => '0',
      pl_resetn0 => NLW_zynq_ultra_ps_e_0_pl_resetn0_UNCONNECTED
    );
end STRUCTURE;
