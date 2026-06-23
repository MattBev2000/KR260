-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
-- Date        : Sat Dec 28 10:25:38 2024
-- Host        : Goose running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Users/ASUS/iCloudDrive/PhD-kriask/prj/blink_mk_IV/blink_mk_IV.gen/sources_1/bd/kria_starter_kit/ip/kria_starter_kit_not_gate_0_2/kria_starter_kit_not_gate_0_2_sim_netlist.vhdl
-- Design      : kria_starter_kit_not_gate_0_2
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xck26-sfvc784-2LV-c
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity kria_starter_kit_not_gate_0_2 is
  port (
    a : in STD_LOGIC;
    y : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of kria_starter_kit_not_gate_0_2 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of kria_starter_kit_not_gate_0_2 : entity is "kria_starter_kit_not_gate_0_2,not_gate,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of kria_starter_kit_not_gate_0_2 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of kria_starter_kit_not_gate_0_2 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of kria_starter_kit_not_gate_0_2 : entity is "not_gate,Vivado 2024.1";
end kria_starter_kit_not_gate_0_2;

architecture STRUCTURE of kria_starter_kit_not_gate_0_2 is
begin
y_INST_0: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => a,
      O => y
    );
end STRUCTURE;
