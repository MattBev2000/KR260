// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
// Date        : Tue Feb 18 11:21:19 2025
// Host        : Goose running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/ASUS/Documents/PhD/kriask/prj/blink_mk_VII/blink_mk_VII.gen/sources_1/bd/design_1/ip/design_1_demux_0_0/design_1_demux_0_0_stub.v
// Design      : design_1_demux_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xck26-sfvc784-2LV-c
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "demux,Vivado 2024.1" *)
module design_1_demux_0_0(d_in, d_out)
/* synthesis syn_black_box black_box_pad_pin="d_in[31:0],d_out" */;
  input [31:0]d_in;
  output d_out;
endmodule
