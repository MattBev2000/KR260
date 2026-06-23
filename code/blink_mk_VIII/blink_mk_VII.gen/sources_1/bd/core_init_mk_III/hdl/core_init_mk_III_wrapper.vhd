--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
--Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
--Date        : Sat Jan  4 14:41:55 2025
--Host        : Goose running 64-bit major release  (build 9200)
--Command     : generate_target core_init_mk_III_wrapper.bd
--Design      : core_init_mk_III_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity core_init_mk_III_wrapper is
  port (
    fan_en_b : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
end core_init_mk_III_wrapper;

architecture STRUCTURE of core_init_mk_III_wrapper is
  component core_init_mk_III is
  port (
    fan_en_b : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component core_init_mk_III;
begin
core_init_mk_III_i: component core_init_mk_III
     port map (
      fan_en_b(0) => fan_en_b(0)
    );
end STRUCTURE;
