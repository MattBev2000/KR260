-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
-- Date        : Sat Dec 28 10:25:38 2024
-- Host        : Goose running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/ASUS/iCloudDrive/PhD-kriask/prj/blink_mk_IV/blink_mk_IV.gen/sources_1/bd/kria_starter_kit/ip/kria_starter_kit_not_gate_0_2/kria_starter_kit_not_gate_0_2_stub.vhdl
-- Design      : kria_starter_kit_not_gate_0_2
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xck26-sfvc784-2LV-c
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity kria_starter_kit_not_gate_0_2 is
  Port ( 
    a : in STD_LOGIC;
    y : out STD_LOGIC
  );

end kria_starter_kit_not_gate_0_2;

architecture stub of kria_starter_kit_not_gate_0_2 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "a,y";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "not_gate,Vivado 2024.1";
begin
end;
