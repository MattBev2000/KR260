-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
-- Date        : Tue Feb 18 11:21:19 2025
-- Host        : Goose running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/ASUS/Documents/PhD/kriask/prj/blink_mk_VII/blink_mk_VII.gen/sources_1/bd/design_1/ip/design_1_demux_0_0/design_1_demux_0_0_stub.vhdl
-- Design      : design_1_demux_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xck26-sfvc784-2LV-c
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_demux_0_0 is
  Port ( 
    d_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    d_out : out STD_LOGIC
  );

end design_1_demux_0_0;

architecture stub of design_1_demux_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "d_in[31:0],d_out";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "demux,Vivado 2024.1";
begin
end;
