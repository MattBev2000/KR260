--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
--Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
--Date        : Sun Dec 22 14:42:32 2024
--Host        : Goose running 64-bit major release  (build 9200)
--Command     : generate_target kria_starter_kit_wrapper.bd
--Design      : kria_starter_kit_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity kria_starter_kit_wrapper is
  port (
    fan_en_b : out STD_LOGIC_VECTOR ( 0 to 0 );
    rpi_16 : in STD_LOGIC;
    rpi_18 : in STD_LOGIC;
    uf1 : out STD_LOGIC
  );
end kria_starter_kit_wrapper;

architecture STRUCTURE of kria_starter_kit_wrapper is
  component kria_starter_kit is
  port (
    fan_en_b : out STD_LOGIC_VECTOR ( 0 to 0 );
    uf1 : out STD_LOGIC;
    rpi_16 : in STD_LOGIC;
    rpi_18 : in STD_LOGIC
  );
  end component kria_starter_kit;
begin
kria_starter_kit_i: component kria_starter_kit
     port map (
      fan_en_b(0) => fan_en_b(0),
      rpi_16 => rpi_16,
      rpi_18 => rpi_18,
      uf1 => uf1
    );
end STRUCTURE;
