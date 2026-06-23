-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
-- Date        : Thu Dec 26 16:57:18 2024
-- Host        : Goose running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ kria_starter_kit_zynq_ultra_ps_e_0_0_stub.vhdl
-- Design      : kria_starter_kit_zynq_ultra_ps_e_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xck26-sfvc784-2LV-c
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  Port ( 
    emio_enet0_enet_tsu_timer_cnt : out STD_LOGIC_VECTOR ( 93 downto 0 );
    emio_ttc0_wave_o : out STD_LOGIC_VECTOR ( 2 downto 0 );
    pl_ps_irq0 : in STD_LOGIC_VECTOR ( 0 to 0 );
    pl_resetn0 : out STD_LOGIC;
    pl_clk0 : out STD_LOGIC;
    pl_clk1 : out STD_LOGIC
  );

end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture stub of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "emio_enet0_enet_tsu_timer_cnt[93:0],emio_ttc0_wave_o[2:0],pl_ps_irq0[0:0],pl_resetn0,pl_clk0,pl_clk1";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "zynq_ultra_ps_e_v3_5_3_zynq_ultra_ps_e,Vivado 2024.1";
begin
end;
