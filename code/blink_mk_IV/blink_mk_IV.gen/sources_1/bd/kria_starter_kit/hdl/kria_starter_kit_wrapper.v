//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
//Date        : Sat Dec 28 09:39:30 2024
//Host        : Goose running 64-bit major release  (build 9200)
//Command     : generate_target kria_starter_kit_wrapper.bd
//Design      : kria_starter_kit_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module kria_starter_kit_wrapper
   (fan_en_b);
  output [0:0]fan_en_b;

  wire [0:0]fan_en_b;

  kria_starter_kit kria_starter_kit_i
       (.fan_en_b(fan_en_b));
endmodule
