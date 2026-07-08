-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
-- Date        : Mon Jul  6 14:12:17 2026
-- Host        : win1217 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/bevilacqua/Documents/projects/KR260/code/blink_mk_VI/blink_mk_VI.gen/sources_1/bd/design_1/ip/design_1_and_gate_0_2/design_1_and_gate_0_2_stub.vhdl
-- Design      : design_1_and_gate_0_2
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xck26-sfvc784-2LV-c
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_and_gate_0_2 is
  Port ( 
    a : in STD_LOGIC;
    b : in STD_LOGIC;
    y : out STD_LOGIC
  );

  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_and_gate_0_2 : entity is "design_1_and_gate_0_2,and_gate,{}";
  attribute core_generation_info : string;
  attribute core_generation_info of design_1_and_gate_0_2 : entity is "design_1_and_gate_0_2,and_gate,{x_ipProduct=Vivado 2024.2,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=and_gate,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of design_1_and_gate_0_2 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of design_1_and_gate_0_2 : entity is "module_ref";
end design_1_and_gate_0_2;

architecture stub of design_1_and_gate_0_2 is
  attribute syn_black_box : boolean;
  attribute black_box_pad_pin : string;
  attribute syn_black_box of stub : architecture is true;
  attribute black_box_pad_pin of stub : architecture is "a,b,y";
  attribute x_core_info : string;
  attribute x_core_info of stub : architecture is "and_gate,Vivado 2024.2";
begin
end;
