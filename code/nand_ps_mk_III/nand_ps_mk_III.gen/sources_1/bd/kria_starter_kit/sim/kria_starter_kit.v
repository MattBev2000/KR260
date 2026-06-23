//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
//Date        : Sun Dec 22 14:38:30 2024
//Host        : Goose running 64-bit major release  (build 9200)
//Command     : generate_target kria_starter_kit.bd
//Design      : kria_starter_kit
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "kria_starter_kit,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=kria_starter_kit,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=2,numReposBlks=2,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,da_zynq_ultra_ps_e_cnt=1,synth_mode=Hierarchical}" *) (* HW_HANDOFF = "kria_starter_kit.hwdef" *) 
module kria_starter_kit
   (fan_en_b);
  output [0:0]fan_en_b;

  wire [0:0]xlslice_0_Dout;
  wire [2:0]zynq_ultra_ps_e_0_emio_ttc0_wave_o;

  assign fan_en_b[0] = xlslice_0_Dout;
  kria_starter_kit_xlslice_0_0 xlslice_0
       (.Din(zynq_ultra_ps_e_0_emio_ttc0_wave_o),
        .Dout(xlslice_0_Dout));
  kria_starter_kit_zynq_ultra_ps_e_0_0 zynq_ultra_ps_e_0
       (.emio_ttc0_wave_o(zynq_ultra_ps_e_0_emio_ttc0_wave_o),
        .pl_ps_irq0(1'b0));
endmodule
