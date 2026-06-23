--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
--Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
--Date        : Tue Feb 18 11:20:03 2025
--Host        : Goose running 64-bit major release  (build 9200)
--Command     : generate_target design_1_wrapper.bd
--Design      : design_1_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_wrapper is
  port (
    fan_en_b : out STD_LOGIC_VECTOR ( 0 to 0 );
    som240_1_connector_hpa_clk0p_clk : in STD_LOGIC;
    uf1 : out STD_LOGIC;
    uf2 : out STD_LOGIC
  );
end design_1_wrapper;

architecture STRUCTURE of design_1_wrapper is
  component design_1 is
  port (
    fan_en_b : out STD_LOGIC_VECTOR ( 0 to 0 );
    som240_1_connector_hpa_clk0p_clk : in STD_LOGIC;
    uf2 : out STD_LOGIC;
    uf1 : out STD_LOGIC
  );
  end component design_1;
begin
design_1_i: component design_1
     port map (
      fan_en_b(0) => fan_en_b(0),
      som240_1_connector_hpa_clk0p_clk => som240_1_connector_hpa_clk0p_clk,
      uf1 => uf1,
      uf2 => uf2
    );
end STRUCTURE;
