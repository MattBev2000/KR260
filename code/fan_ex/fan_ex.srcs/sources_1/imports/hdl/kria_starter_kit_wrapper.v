//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
//Date        : Sat Dec 28 07:47:49 2024
//Host        : Goose running 64-bit major release  (build 9200)
//Command     : generate_target kria_starter_kit_wrapper.bd
//Design      : kria_starter_kit_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module kria_starter_kit_wrapper
   (fan_en_b,
    som240_1_connector_pmod1_gpio_tri_io);
  output [0:0]fan_en_b;
  inout [7:0]som240_1_connector_pmod1_gpio_tri_io;

  wire [0:0]fan_en_b;
  wire [0:0]som240_1_connector_pmod1_gpio_tri_i_0;
  wire [1:1]som240_1_connector_pmod1_gpio_tri_i_1;
  wire [2:2]som240_1_connector_pmod1_gpio_tri_i_2;
  wire [3:3]som240_1_connector_pmod1_gpio_tri_i_3;
  wire [4:4]som240_1_connector_pmod1_gpio_tri_i_4;
  wire [5:5]som240_1_connector_pmod1_gpio_tri_i_5;
  wire [6:6]som240_1_connector_pmod1_gpio_tri_i_6;
  wire [7:7]som240_1_connector_pmod1_gpio_tri_i_7;
  wire [0:0]som240_1_connector_pmod1_gpio_tri_io_0;
  wire [1:1]som240_1_connector_pmod1_gpio_tri_io_1;
  wire [2:2]som240_1_connector_pmod1_gpio_tri_io_2;
  wire [3:3]som240_1_connector_pmod1_gpio_tri_io_3;
  wire [4:4]som240_1_connector_pmod1_gpio_tri_io_4;
  wire [5:5]som240_1_connector_pmod1_gpio_tri_io_5;
  wire [6:6]som240_1_connector_pmod1_gpio_tri_io_6;
  wire [7:7]som240_1_connector_pmod1_gpio_tri_io_7;
  wire [0:0]som240_1_connector_pmod1_gpio_tri_o_0;
  wire [1:1]som240_1_connector_pmod1_gpio_tri_o_1;
  wire [2:2]som240_1_connector_pmod1_gpio_tri_o_2;
  wire [3:3]som240_1_connector_pmod1_gpio_tri_o_3;
  wire [4:4]som240_1_connector_pmod1_gpio_tri_o_4;
  wire [5:5]som240_1_connector_pmod1_gpio_tri_o_5;
  wire [6:6]som240_1_connector_pmod1_gpio_tri_o_6;
  wire [7:7]som240_1_connector_pmod1_gpio_tri_o_7;
  wire [0:0]som240_1_connector_pmod1_gpio_tri_t_0;
  wire [1:1]som240_1_connector_pmod1_gpio_tri_t_1;
  wire [2:2]som240_1_connector_pmod1_gpio_tri_t_2;
  wire [3:3]som240_1_connector_pmod1_gpio_tri_t_3;
  wire [4:4]som240_1_connector_pmod1_gpio_tri_t_4;
  wire [5:5]som240_1_connector_pmod1_gpio_tri_t_5;
  wire [6:6]som240_1_connector_pmod1_gpio_tri_t_6;
  wire [7:7]som240_1_connector_pmod1_gpio_tri_t_7;

  kria_starter_kit kria_starter_kit_i
       (.fan_en_b(fan_en_b),
        .som240_1_connector_pmod1_gpio_tri_i({som240_1_connector_pmod1_gpio_tri_i_7,som240_1_connector_pmod1_gpio_tri_i_6,som240_1_connector_pmod1_gpio_tri_i_5,som240_1_connector_pmod1_gpio_tri_i_4,som240_1_connector_pmod1_gpio_tri_i_3,som240_1_connector_pmod1_gpio_tri_i_2,som240_1_connector_pmod1_gpio_tri_i_1,som240_1_connector_pmod1_gpio_tri_i_0}),
        .som240_1_connector_pmod1_gpio_tri_o({som240_1_connector_pmod1_gpio_tri_o_7,som240_1_connector_pmod1_gpio_tri_o_6,som240_1_connector_pmod1_gpio_tri_o_5,som240_1_connector_pmod1_gpio_tri_o_4,som240_1_connector_pmod1_gpio_tri_o_3,som240_1_connector_pmod1_gpio_tri_o_2,som240_1_connector_pmod1_gpio_tri_o_1,som240_1_connector_pmod1_gpio_tri_o_0}),
        .som240_1_connector_pmod1_gpio_tri_t({som240_1_connector_pmod1_gpio_tri_t_7,som240_1_connector_pmod1_gpio_tri_t_6,som240_1_connector_pmod1_gpio_tri_t_5,som240_1_connector_pmod1_gpio_tri_t_4,som240_1_connector_pmod1_gpio_tri_t_3,som240_1_connector_pmod1_gpio_tri_t_2,som240_1_connector_pmod1_gpio_tri_t_1,som240_1_connector_pmod1_gpio_tri_t_0}));
  IOBUF som240_1_connector_pmod1_gpio_tri_iobuf_0
       (.I(som240_1_connector_pmod1_gpio_tri_o_0),
        .IO(som240_1_connector_pmod1_gpio_tri_io[0]),
        .O(som240_1_connector_pmod1_gpio_tri_i_0),
        .T(som240_1_connector_pmod1_gpio_tri_t_0));
  IOBUF som240_1_connector_pmod1_gpio_tri_iobuf_1
       (.I(som240_1_connector_pmod1_gpio_tri_o_1),
        .IO(som240_1_connector_pmod1_gpio_tri_io[1]),
        .O(som240_1_connector_pmod1_gpio_tri_i_1),
        .T(som240_1_connector_pmod1_gpio_tri_t_1));
  IOBUF som240_1_connector_pmod1_gpio_tri_iobuf_2
       (.I(som240_1_connector_pmod1_gpio_tri_o_2),
        .IO(som240_1_connector_pmod1_gpio_tri_io[2]),
        .O(som240_1_connector_pmod1_gpio_tri_i_2),
        .T(som240_1_connector_pmod1_gpio_tri_t_2));
  IOBUF som240_1_connector_pmod1_gpio_tri_iobuf_3
       (.I(som240_1_connector_pmod1_gpio_tri_o_3),
        .IO(som240_1_connector_pmod1_gpio_tri_io[3]),
        .O(som240_1_connector_pmod1_gpio_tri_i_3),
        .T(som240_1_connector_pmod1_gpio_tri_t_3));
  IOBUF som240_1_connector_pmod1_gpio_tri_iobuf_4
       (.I(som240_1_connector_pmod1_gpio_tri_o_4),
        .IO(som240_1_connector_pmod1_gpio_tri_io[4]),
        .O(som240_1_connector_pmod1_gpio_tri_i_4),
        .T(som240_1_connector_pmod1_gpio_tri_t_4));
  IOBUF som240_1_connector_pmod1_gpio_tri_iobuf_5
       (.I(som240_1_connector_pmod1_gpio_tri_o_5),
        .IO(som240_1_connector_pmod1_gpio_tri_io[5]),
        .O(som240_1_connector_pmod1_gpio_tri_i_5),
        .T(som240_1_connector_pmod1_gpio_tri_t_5));
  IOBUF som240_1_connector_pmod1_gpio_tri_iobuf_6
       (.I(som240_1_connector_pmod1_gpio_tri_o_6),
        .IO(som240_1_connector_pmod1_gpio_tri_io[6]),
        .O(som240_1_connector_pmod1_gpio_tri_i_6),
        .T(som240_1_connector_pmod1_gpio_tri_t_6));
  IOBUF som240_1_connector_pmod1_gpio_tri_iobuf_7
       (.I(som240_1_connector_pmod1_gpio_tri_o_7),
        .IO(som240_1_connector_pmod1_gpio_tri_io[7]),
        .O(som240_1_connector_pmod1_gpio_tri_i_7),
        .T(som240_1_connector_pmod1_gpio_tri_t_7));
endmodule
