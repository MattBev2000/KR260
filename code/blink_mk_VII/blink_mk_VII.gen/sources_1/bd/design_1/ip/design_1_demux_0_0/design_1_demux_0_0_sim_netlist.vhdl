-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
-- Date        : Tue Feb 18 11:21:19 2025
-- Host        : Goose running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Users/ASUS/Documents/PhD/kriask/prj/blink_mk_VII/blink_mk_VII.gen/sources_1/bd/design_1/ip/design_1_demux_0_0/design_1_demux_0_0_sim_netlist.vhdl
-- Design      : design_1_demux_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xck26-sfvc784-2LV-c
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_demux_0_0 is
  port (
    d_in : in STD_LOGIC_VECTOR ( 31 downto 0 );
    d_out : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_demux_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_demux_0_0 : entity is "design_1_demux_0_0,demux,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of design_1_demux_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of design_1_demux_0_0 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of design_1_demux_0_0 : entity is "demux,Vivado 2024.1";
end design_1_demux_0_0;

architecture STRUCTURE of design_1_demux_0_0 is
  signal \^d_in\ : STD_LOGIC_VECTOR ( 31 downto 0 );
begin
  \^d_in\(0) <= d_in(0);
  d_out <= \^d_in\(0);
end STRUCTURE;
