// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.1 (lin64) Build 5076996 Wed May 22 18:36:09 MDT 2024
// Date        : Fri Feb 21 11:18:15 2025
// Host        : aidevel running 64-bit unknown
// Command     : write_verilog -force -mode funcsim
//               /data/devel/kria_mb/vivado/blink_mk_VIII/blink_mk_VII.gen/sources_1/bd/design_1/ip/design_1_rampgen_0_0/design_1_rampgen_0_0_sim_netlist.v
// Design      : design_1_rampgen_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xck26-sfvc784-2LV-c
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_rampgen_0_0,rampgen,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* ip_definition_source = "module_ref" *) 
(* x_core_info = "rampgen,Vivado 2024.1" *) 
(* NotValidForBitStream *)
module design_1_rampgen_0_0
   (aclk,
    cfg_reg,
    m_axis_tdata,
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tlast,
    led);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 aclk CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME aclk, ASSOCIATED_BUSIF m_axis, FREQ_HZ 99999001, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, INSERT_VIP 0" *) input aclk;
  input [31:0]cfg_reg;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis TDATA" *) (* x_interface_parameter = "XIL_INTERFACENAME m_axis, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 99999001, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, LAYERED_METADATA undef, INSERT_VIP 0" *) output [31:0]m_axis_tdata;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis TVALID" *) output m_axis_tvalid;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis TREADY" *) input m_axis_tready;
  (* x_interface_info = "xilinx.com:interface:axis:1.0 m_axis TLAST" *) output m_axis_tlast;
  output led;

  wire aclk;
  wire [31:0]cfg_reg;
  wire led;
  wire [31:0]m_axis_tdata;
  wire m_axis_tlast;
  wire m_axis_tready;

  assign m_axis_tvalid = m_axis_tlast;
  design_1_rampgen_0_0_rampgen U0
       (.aclk(aclk),
        .cfg_reg(cfg_reg),
        .led(led),
        .m_axis_tdata(m_axis_tdata),
        .m_axis_tlast(m_axis_tlast),
        .m_axis_tready(m_axis_tready));
endmodule

(* ORIG_REF_NAME = "rampgen" *) 
module design_1_rampgen_0_0_rampgen
   (m_axis_tdata,
    m_axis_tlast,
    led,
    cfg_reg,
    aclk,
    m_axis_tready);
  output [31:0]m_axis_tdata;
  output m_axis_tlast;
  output led;
  input [31:0]cfg_reg;
  input aclk;
  input m_axis_tready;

  wire aclk;
  wire [31:0]cfg_reg;
  wire \handle_ramp.out_count_reg_n_0_[0] ;
  wire \handle_ramp.out_count_reg_n_0_[10] ;
  wire \handle_ramp.out_count_reg_n_0_[11] ;
  wire \handle_ramp.out_count_reg_n_0_[12] ;
  wire \handle_ramp.out_count_reg_n_0_[13] ;
  wire \handle_ramp.out_count_reg_n_0_[14] ;
  wire \handle_ramp.out_count_reg_n_0_[15] ;
  wire \handle_ramp.out_count_reg_n_0_[16] ;
  wire \handle_ramp.out_count_reg_n_0_[17] ;
  wire \handle_ramp.out_count_reg_n_0_[18] ;
  wire \handle_ramp.out_count_reg_n_0_[19] ;
  wire \handle_ramp.out_count_reg_n_0_[1] ;
  wire \handle_ramp.out_count_reg_n_0_[20] ;
  wire \handle_ramp.out_count_reg_n_0_[21] ;
  wire \handle_ramp.out_count_reg_n_0_[22] ;
  wire \handle_ramp.out_count_reg_n_0_[23] ;
  wire \handle_ramp.out_count_reg_n_0_[24] ;
  wire \handle_ramp.out_count_reg_n_0_[25] ;
  wire \handle_ramp.out_count_reg_n_0_[26] ;
  wire \handle_ramp.out_count_reg_n_0_[27] ;
  wire \handle_ramp.out_count_reg_n_0_[28] ;
  wire \handle_ramp.out_count_reg_n_0_[29] ;
  wire \handle_ramp.out_count_reg_n_0_[2] ;
  wire \handle_ramp.out_count_reg_n_0_[30] ;
  wire \handle_ramp.out_count_reg_n_0_[31] ;
  wire \handle_ramp.out_count_reg_n_0_[3] ;
  wire \handle_ramp.out_count_reg_n_0_[4] ;
  wire \handle_ramp.out_count_reg_n_0_[5] ;
  wire \handle_ramp.out_count_reg_n_0_[6] ;
  wire \handle_ramp.out_count_reg_n_0_[7] ;
  wire \handle_ramp.out_count_reg_n_0_[8] ;
  wire \handle_ramp.out_count_reg_n_0_[9] ;
  wire led;
  wire led_out_i_1_n_0;
  wire [31:0]m_axis_tdata;
  wire \m_axis_tdata[0]_i_10_n_0 ;
  wire \m_axis_tdata[0]_i_11_n_0 ;
  wire \m_axis_tdata[0]_i_12_n_0 ;
  wire \m_axis_tdata[0]_i_13_n_0 ;
  wire \m_axis_tdata[0]_i_14_n_0 ;
  wire \m_axis_tdata[0]_i_15_n_0 ;
  wire \m_axis_tdata[0]_i_16_n_0 ;
  wire \m_axis_tdata[0]_i_17_n_0 ;
  wire \m_axis_tdata[0]_i_18_n_0 ;
  wire \m_axis_tdata[0]_i_19_n_0 ;
  wire \m_axis_tdata[0]_i_20_n_0 ;
  wire \m_axis_tdata[0]_i_3_n_0 ;
  wire \m_axis_tdata[0]_i_4_n_0 ;
  wire \m_axis_tdata[0]_i_5_n_0 ;
  wire \m_axis_tdata[0]_i_6_n_0 ;
  wire \m_axis_tdata[0]_i_7_n_0 ;
  wire \m_axis_tdata[0]_i_8_n_0 ;
  wire \m_axis_tdata[0]_i_9_n_0 ;
  wire \m_axis_tdata[16]_i_2_n_0 ;
  wire \m_axis_tdata[16]_i_3_n_0 ;
  wire \m_axis_tdata[16]_i_4_n_0 ;
  wire \m_axis_tdata[16]_i_5_n_0 ;
  wire \m_axis_tdata[16]_i_6_n_0 ;
  wire \m_axis_tdata[16]_i_7_n_0 ;
  wire \m_axis_tdata[16]_i_8_n_0 ;
  wire \m_axis_tdata[16]_i_9_n_0 ;
  wire \m_axis_tdata[24]_i_2_n_0 ;
  wire \m_axis_tdata[24]_i_3_n_0 ;
  wire \m_axis_tdata[24]_i_4_n_0 ;
  wire \m_axis_tdata[24]_i_5_n_0 ;
  wire \m_axis_tdata[24]_i_6_n_0 ;
  wire \m_axis_tdata[24]_i_7_n_0 ;
  wire \m_axis_tdata[24]_i_8_n_0 ;
  wire \m_axis_tdata[24]_i_9_n_0 ;
  wire \m_axis_tdata[31]_i_3_n_0 ;
  wire \m_axis_tdata[31]_i_4_n_0 ;
  wire \m_axis_tdata[31]_i_5_n_0 ;
  wire \m_axis_tdata[31]_i_6_n_0 ;
  wire \m_axis_tdata[31]_i_7_n_0 ;
  wire \m_axis_tdata[31]_i_8_n_0 ;
  wire \m_axis_tdata[31]_i_9_n_0 ;
  wire \m_axis_tdata[8]_i_10_n_0 ;
  wire \m_axis_tdata[8]_i_3_n_0 ;
  wire \m_axis_tdata[8]_i_4_n_0 ;
  wire \m_axis_tdata[8]_i_5_n_0 ;
  wire \m_axis_tdata[8]_i_6_n_0 ;
  wire \m_axis_tdata[8]_i_7_n_0 ;
  wire \m_axis_tdata[8]_i_8_n_0 ;
  wire \m_axis_tdata[8]_i_9_n_0 ;
  wire \m_axis_tdata_reg[16]_i_1_n_0 ;
  wire \m_axis_tdata_reg[16]_i_1_n_1 ;
  wire \m_axis_tdata_reg[16]_i_1_n_2 ;
  wire \m_axis_tdata_reg[16]_i_1_n_3 ;
  wire \m_axis_tdata_reg[16]_i_1_n_4 ;
  wire \m_axis_tdata_reg[16]_i_1_n_5 ;
  wire \m_axis_tdata_reg[16]_i_1_n_6 ;
  wire \m_axis_tdata_reg[16]_i_1_n_7 ;
  wire \m_axis_tdata_reg[24]_i_1_n_0 ;
  wire \m_axis_tdata_reg[24]_i_1_n_1 ;
  wire \m_axis_tdata_reg[24]_i_1_n_2 ;
  wire \m_axis_tdata_reg[24]_i_1_n_3 ;
  wire \m_axis_tdata_reg[24]_i_1_n_4 ;
  wire \m_axis_tdata_reg[24]_i_1_n_5 ;
  wire \m_axis_tdata_reg[24]_i_1_n_6 ;
  wire \m_axis_tdata_reg[24]_i_1_n_7 ;
  wire \m_axis_tdata_reg[31]_i_2_n_2 ;
  wire \m_axis_tdata_reg[31]_i_2_n_3 ;
  wire \m_axis_tdata_reg[31]_i_2_n_4 ;
  wire \m_axis_tdata_reg[31]_i_2_n_5 ;
  wire \m_axis_tdata_reg[31]_i_2_n_6 ;
  wire \m_axis_tdata_reg[31]_i_2_n_7 ;
  wire \m_axis_tdata_reg[8]_i_1_n_0 ;
  wire \m_axis_tdata_reg[8]_i_1_n_1 ;
  wire \m_axis_tdata_reg[8]_i_1_n_2 ;
  wire \m_axis_tdata_reg[8]_i_1_n_3 ;
  wire \m_axis_tdata_reg[8]_i_1_n_4 ;
  wire \m_axis_tdata_reg[8]_i_1_n_5 ;
  wire \m_axis_tdata_reg[8]_i_1_n_6 ;
  wire \m_axis_tdata_reg[8]_i_1_n_7 ;
  wire m_axis_tlast;
  wire m_axis_tready;
  wire [0:0]out_count;
  wire [31:0]out_count0;
  wire out_count12_out;
  wire out_count1__62;
  wire out_count21_in;
  wire out_count2_carry__0_i_10_n_0;
  wire out_count2_carry__0_i_11_n_0;
  wire out_count2_carry__0_i_12_n_0;
  wire out_count2_carry__0_i_13_n_0;
  wire out_count2_carry__0_i_14_n_0;
  wire out_count2_carry__0_i_15_n_0;
  wire out_count2_carry__0_i_16_n_0;
  wire out_count2_carry__0_i_1_n_0;
  wire out_count2_carry__0_i_2_n_0;
  wire out_count2_carry__0_i_3_n_0;
  wire out_count2_carry__0_i_4_n_0;
  wire out_count2_carry__0_i_5_n_0;
  wire out_count2_carry__0_i_6_n_0;
  wire out_count2_carry__0_i_7_n_0;
  wire out_count2_carry__0_i_8_n_0;
  wire out_count2_carry__0_i_9_n_0;
  wire out_count2_carry__0_n_1;
  wire out_count2_carry__0_n_2;
  wire out_count2_carry__0_n_3;
  wire out_count2_carry__0_n_4;
  wire out_count2_carry__0_n_5;
  wire out_count2_carry__0_n_6;
  wire out_count2_carry__0_n_7;
  wire out_count2_carry_i_10_n_0;
  wire out_count2_carry_i_11_n_0;
  wire out_count2_carry_i_12_n_0;
  wire out_count2_carry_i_13_n_0;
  wire out_count2_carry_i_14_n_0;
  wire out_count2_carry_i_15_n_0;
  wire out_count2_carry_i_16_n_0;
  wire out_count2_carry_i_1_n_0;
  wire out_count2_carry_i_2_n_0;
  wire out_count2_carry_i_3_n_0;
  wire out_count2_carry_i_4_n_0;
  wire out_count2_carry_i_5_n_0;
  wire out_count2_carry_i_6_n_0;
  wire out_count2_carry_i_7_n_0;
  wire out_count2_carry_i_8_n_0;
  wire out_count2_carry_i_9_n_0;
  wire out_count2_carry_n_0;
  wire out_count2_carry_n_1;
  wire out_count2_carry_n_2;
  wire out_count2_carry_n_3;
  wire out_count2_carry_n_4;
  wire out_count2_carry_n_5;
  wire out_count2_carry_n_6;
  wire out_count2_carry_n_7;
  wire [31:0]p_0_in;
  wire [31:0]prev_reg;
  wire [7:6]\NLW_m_axis_tdata_reg[31]_i_2_CO_UNCONNECTED ;
  wire [7:7]\NLW_m_axis_tdata_reg[31]_i_2_O_UNCONNECTED ;
  wire [7:0]NLW_out_count2_carry_O_UNCONNECTED;
  wire [7:0]NLW_out_count2_carry__0_O_UNCONNECTED;

  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h1EEE)) 
    \handle_ramp.out_count[0]_i_1 
       (.I0(\handle_ramp.out_count_reg_n_0_[0] ),
        .I1(out_count1__62),
        .I2(out_count21_in),
        .I3(m_axis_tready),
        .O(p_0_in[0]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[10]_i_1 
       (.I0(out_count0[10]),
        .I1(\handle_ramp.out_count_reg_n_0_[10] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[10]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[11]_i_1 
       (.I0(out_count0[11]),
        .I1(\handle_ramp.out_count_reg_n_0_[11] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[11]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[12]_i_1 
       (.I0(out_count0[12]),
        .I1(\handle_ramp.out_count_reg_n_0_[12] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[12]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[13]_i_1 
       (.I0(out_count0[13]),
        .I1(\handle_ramp.out_count_reg_n_0_[13] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[13]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[14]_i_1 
       (.I0(out_count0[14]),
        .I1(\handle_ramp.out_count_reg_n_0_[14] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[14]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[15]_i_1 
       (.I0(out_count0[15]),
        .I1(\handle_ramp.out_count_reg_n_0_[15] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[15]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[16]_i_1 
       (.I0(out_count0[16]),
        .I1(\handle_ramp.out_count_reg_n_0_[16] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[16]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[17]_i_1 
       (.I0(out_count0[17]),
        .I1(\handle_ramp.out_count_reg_n_0_[17] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[17]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[18]_i_1 
       (.I0(out_count0[18]),
        .I1(\handle_ramp.out_count_reg_n_0_[18] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[18]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[19]_i_1 
       (.I0(out_count0[19]),
        .I1(\handle_ramp.out_count_reg_n_0_[19] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[19]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[1]_i_1 
       (.I0(out_count0[1]),
        .I1(\handle_ramp.out_count_reg_n_0_[1] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[1]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[20]_i_1 
       (.I0(out_count0[20]),
        .I1(\handle_ramp.out_count_reg_n_0_[20] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[20]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[21]_i_1 
       (.I0(out_count0[21]),
        .I1(\handle_ramp.out_count_reg_n_0_[21] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[21]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[22]_i_1 
       (.I0(out_count0[22]),
        .I1(\handle_ramp.out_count_reg_n_0_[22] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[22]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[23]_i_1 
       (.I0(out_count0[23]),
        .I1(\handle_ramp.out_count_reg_n_0_[23] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[23]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[24]_i_1 
       (.I0(out_count0[24]),
        .I1(\handle_ramp.out_count_reg_n_0_[24] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[24]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[25]_i_1 
       (.I0(out_count0[25]),
        .I1(\handle_ramp.out_count_reg_n_0_[25] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[25]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[26]_i_1 
       (.I0(out_count0[26]),
        .I1(\handle_ramp.out_count_reg_n_0_[26] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[26]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[27]_i_1 
       (.I0(out_count0[27]),
        .I1(\handle_ramp.out_count_reg_n_0_[27] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[27]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[28]_i_1 
       (.I0(out_count0[28]),
        .I1(\handle_ramp.out_count_reg_n_0_[28] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[28]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[29]_i_1 
       (.I0(out_count0[29]),
        .I1(\handle_ramp.out_count_reg_n_0_[29] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[29]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[2]_i_1 
       (.I0(out_count0[2]),
        .I1(\handle_ramp.out_count_reg_n_0_[2] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[2]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[30]_i_1 
       (.I0(out_count0[30]),
        .I1(\handle_ramp.out_count_reg_n_0_[30] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[30]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[31]_i_1 
       (.I0(out_count0[31]),
        .I1(\handle_ramp.out_count_reg_n_0_[31] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[31]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[3]_i_1 
       (.I0(out_count0[3]),
        .I1(\handle_ramp.out_count_reg_n_0_[3] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[3]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[4]_i_1 
       (.I0(out_count0[4]),
        .I1(\handle_ramp.out_count_reg_n_0_[4] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[4]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[5]_i_1 
       (.I0(out_count0[5]),
        .I1(\handle_ramp.out_count_reg_n_0_[5] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[5]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[6]_i_1 
       (.I0(out_count0[6]),
        .I1(\handle_ramp.out_count_reg_n_0_[6] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[6]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[7]_i_1 
       (.I0(out_count0[7]),
        .I1(\handle_ramp.out_count_reg_n_0_[7] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[7]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[8]_i_1 
       (.I0(out_count0[8]),
        .I1(\handle_ramp.out_count_reg_n_0_[8] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[8]));
  LUT5 #(
    .INIT(32'hAAFCFCFC)) 
    \handle_ramp.out_count[9]_i_1 
       (.I0(out_count0[9]),
        .I1(\handle_ramp.out_count_reg_n_0_[9] ),
        .I2(out_count1__62),
        .I3(out_count21_in),
        .I4(m_axis_tready),
        .O(p_0_in[9]));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[0] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[0]),
        .Q(\handle_ramp.out_count_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[10] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[10]),
        .Q(\handle_ramp.out_count_reg_n_0_[10] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[11] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[11]),
        .Q(\handle_ramp.out_count_reg_n_0_[11] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[12] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[12]),
        .Q(\handle_ramp.out_count_reg_n_0_[12] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[13] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[13]),
        .Q(\handle_ramp.out_count_reg_n_0_[13] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[14] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[14]),
        .Q(\handle_ramp.out_count_reg_n_0_[14] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[15] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[15]),
        .Q(\handle_ramp.out_count_reg_n_0_[15] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[16] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[16]),
        .Q(\handle_ramp.out_count_reg_n_0_[16] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[17] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[17]),
        .Q(\handle_ramp.out_count_reg_n_0_[17] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[18] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[18]),
        .Q(\handle_ramp.out_count_reg_n_0_[18] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[19] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[19]),
        .Q(\handle_ramp.out_count_reg_n_0_[19] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[1] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[1]),
        .Q(\handle_ramp.out_count_reg_n_0_[1] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[20] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[20]),
        .Q(\handle_ramp.out_count_reg_n_0_[20] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[21] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[21]),
        .Q(\handle_ramp.out_count_reg_n_0_[21] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[22] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[22]),
        .Q(\handle_ramp.out_count_reg_n_0_[22] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[23] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[23]),
        .Q(\handle_ramp.out_count_reg_n_0_[23] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[24] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[24]),
        .Q(\handle_ramp.out_count_reg_n_0_[24] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[25] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[25]),
        .Q(\handle_ramp.out_count_reg_n_0_[25] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[26] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[26]),
        .Q(\handle_ramp.out_count_reg_n_0_[26] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[27] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[27]),
        .Q(\handle_ramp.out_count_reg_n_0_[27] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[28] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[28]),
        .Q(\handle_ramp.out_count_reg_n_0_[28] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[29] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[29]),
        .Q(\handle_ramp.out_count_reg_n_0_[29] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[2] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[2]),
        .Q(\handle_ramp.out_count_reg_n_0_[2] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[30] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[30]),
        .Q(\handle_ramp.out_count_reg_n_0_[30] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b1)) 
    \handle_ramp.out_count_reg[31] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[31]),
        .Q(\handle_ramp.out_count_reg_n_0_[31] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[3] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[3]),
        .Q(\handle_ramp.out_count_reg_n_0_[3] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[4] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[4]),
        .Q(\handle_ramp.out_count_reg_n_0_[4] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[5] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[5]),
        .Q(\handle_ramp.out_count_reg_n_0_[5] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[6] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[6]),
        .Q(\handle_ramp.out_count_reg_n_0_[6] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[7] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[7]),
        .Q(\handle_ramp.out_count_reg_n_0_[7] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[8] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[8]),
        .Q(\handle_ramp.out_count_reg_n_0_[8] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \handle_ramp.out_count_reg[9] 
       (.C(aclk),
        .CE(1'b1),
        .D(p_0_in[9]),
        .Q(\handle_ramp.out_count_reg_n_0_[9] ),
        .R(1'b0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT2 #(
    .INIT(4'hE)) 
    led_out_i_1
       (.I0(led),
        .I1(out_count1__62),
        .O(led_out_i_1_n_0));
  FDRE #(
    .INIT(1'b0)) 
    led_out_reg
       (.C(aclk),
        .CE(1'b1),
        .D(led_out_i_1_n_0),
        .Q(led),
        .R(1'b0));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[0]_i_1 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[0] ),
        .O(out_count0[0]));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \m_axis_tdata[0]_i_10 
       (.I0(prev_reg[2]),
        .I1(prev_reg[3]),
        .I2(prev_reg[0]),
        .I3(prev_reg[1]),
        .O(\m_axis_tdata[0]_i_10_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \m_axis_tdata[0]_i_11 
       (.I0(prev_reg[26]),
        .I1(prev_reg[27]),
        .I2(prev_reg[24]),
        .I3(prev_reg[25]),
        .O(\m_axis_tdata[0]_i_11_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \m_axis_tdata[0]_i_12 
       (.I0(prev_reg[18]),
        .I1(prev_reg[19]),
        .I2(prev_reg[16]),
        .I3(prev_reg[17]),
        .O(\m_axis_tdata[0]_i_12_n_0 ));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \m_axis_tdata[0]_i_13 
       (.I0(cfg_reg[10]),
        .I1(cfg_reg[11]),
        .I2(cfg_reg[8]),
        .I3(cfg_reg[9]),
        .O(\m_axis_tdata[0]_i_13_n_0 ));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \m_axis_tdata[0]_i_14 
       (.I0(cfg_reg[14]),
        .I1(cfg_reg[15]),
        .I2(cfg_reg[12]),
        .I3(cfg_reg[13]),
        .O(\m_axis_tdata[0]_i_14_n_0 ));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \m_axis_tdata[0]_i_15 
       (.I0(cfg_reg[2]),
        .I1(cfg_reg[3]),
        .I2(cfg_reg[0]),
        .I3(cfg_reg[1]),
        .O(\m_axis_tdata[0]_i_15_n_0 ));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \m_axis_tdata[0]_i_16 
       (.I0(cfg_reg[6]),
        .I1(cfg_reg[7]),
        .I2(cfg_reg[4]),
        .I3(cfg_reg[5]),
        .O(\m_axis_tdata[0]_i_16_n_0 ));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \m_axis_tdata[0]_i_17 
       (.I0(cfg_reg[26]),
        .I1(cfg_reg[27]),
        .I2(cfg_reg[24]),
        .I3(cfg_reg[25]),
        .O(\m_axis_tdata[0]_i_17_n_0 ));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \m_axis_tdata[0]_i_18 
       (.I0(cfg_reg[31]),
        .I1(cfg_reg[30]),
        .I2(cfg_reg[28]),
        .I3(cfg_reg[29]),
        .O(\m_axis_tdata[0]_i_18_n_0 ));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \m_axis_tdata[0]_i_19 
       (.I0(cfg_reg[18]),
        .I1(cfg_reg[19]),
        .I2(cfg_reg[16]),
        .I3(cfg_reg[17]),
        .O(\m_axis_tdata[0]_i_19_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000000001)) 
    \m_axis_tdata[0]_i_2 
       (.I0(\m_axis_tdata[0]_i_3_n_0 ),
        .I1(\m_axis_tdata[0]_i_4_n_0 ),
        .I2(\m_axis_tdata[0]_i_5_n_0 ),
        .I3(\m_axis_tdata[0]_i_6_n_0 ),
        .I4(\m_axis_tdata[0]_i_7_n_0 ),
        .I5(\m_axis_tdata[0]_i_8_n_0 ),
        .O(out_count1__62));
  LUT4 #(
    .INIT(16'h7FFF)) 
    \m_axis_tdata[0]_i_20 
       (.I0(cfg_reg[22]),
        .I1(cfg_reg[23]),
        .I2(cfg_reg[20]),
        .I3(cfg_reg[21]),
        .O(\m_axis_tdata[0]_i_20_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \m_axis_tdata[0]_i_3 
       (.I0(prev_reg[13]),
        .I1(prev_reg[12]),
        .I2(prev_reg[15]),
        .I3(prev_reg[14]),
        .I4(\m_axis_tdata[0]_i_9_n_0 ),
        .O(\m_axis_tdata[0]_i_3_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \m_axis_tdata[0]_i_4 
       (.I0(prev_reg[5]),
        .I1(prev_reg[4]),
        .I2(prev_reg[7]),
        .I3(prev_reg[6]),
        .I4(\m_axis_tdata[0]_i_10_n_0 ),
        .O(\m_axis_tdata[0]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \m_axis_tdata[0]_i_5 
       (.I0(prev_reg[29]),
        .I1(prev_reg[28]),
        .I2(prev_reg[30]),
        .I3(prev_reg[31]),
        .I4(\m_axis_tdata[0]_i_11_n_0 ),
        .O(\m_axis_tdata[0]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    \m_axis_tdata[0]_i_6 
       (.I0(prev_reg[21]),
        .I1(prev_reg[20]),
        .I2(prev_reg[23]),
        .I3(prev_reg[22]),
        .I4(\m_axis_tdata[0]_i_12_n_0 ),
        .O(\m_axis_tdata[0]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \m_axis_tdata[0]_i_7 
       (.I0(\m_axis_tdata[0]_i_13_n_0 ),
        .I1(\m_axis_tdata[0]_i_14_n_0 ),
        .I2(\m_axis_tdata[0]_i_15_n_0 ),
        .I3(\m_axis_tdata[0]_i_16_n_0 ),
        .O(\m_axis_tdata[0]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \m_axis_tdata[0]_i_8 
       (.I0(\m_axis_tdata[0]_i_17_n_0 ),
        .I1(\m_axis_tdata[0]_i_18_n_0 ),
        .I2(\m_axis_tdata[0]_i_19_n_0 ),
        .I3(\m_axis_tdata[0]_i_20_n_0 ),
        .O(\m_axis_tdata[0]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'hFFFE)) 
    \m_axis_tdata[0]_i_9 
       (.I0(prev_reg[10]),
        .I1(prev_reg[11]),
        .I2(prev_reg[8]),
        .I3(prev_reg[9]),
        .O(\m_axis_tdata[0]_i_9_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[16]_i_2 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[16] ),
        .O(\m_axis_tdata[16]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[16]_i_3 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[15] ),
        .O(\m_axis_tdata[16]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[16]_i_4 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[14] ),
        .O(\m_axis_tdata[16]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[16]_i_5 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[13] ),
        .O(\m_axis_tdata[16]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[16]_i_6 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[12] ),
        .O(\m_axis_tdata[16]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[16]_i_7 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[11] ),
        .O(\m_axis_tdata[16]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[16]_i_8 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[10] ),
        .O(\m_axis_tdata[16]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[16]_i_9 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[9] ),
        .O(\m_axis_tdata[16]_i_9_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[24]_i_2 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[24] ),
        .O(\m_axis_tdata[24]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[24]_i_3 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[23] ),
        .O(\m_axis_tdata[24]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[24]_i_4 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[22] ),
        .O(\m_axis_tdata[24]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[24]_i_5 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[21] ),
        .O(\m_axis_tdata[24]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[24]_i_6 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[20] ),
        .O(\m_axis_tdata[24]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[24]_i_7 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[19] ),
        .O(\m_axis_tdata[24]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[24]_i_8 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[18] ),
        .O(\m_axis_tdata[24]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[24]_i_9 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[17] ),
        .O(\m_axis_tdata[24]_i_9_n_0 ));
  LUT2 #(
    .INIT(4'h8)) 
    \m_axis_tdata[31]_i_1 
       (.I0(out_count21_in),
        .I1(m_axis_tready),
        .O(out_count12_out));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[31]_i_3 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[31] ),
        .O(\m_axis_tdata[31]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[31]_i_4 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[30] ),
        .O(\m_axis_tdata[31]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[31]_i_5 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[29] ),
        .O(\m_axis_tdata[31]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[31]_i_6 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[28] ),
        .O(\m_axis_tdata[31]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[31]_i_7 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[27] ),
        .O(\m_axis_tdata[31]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[31]_i_8 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[26] ),
        .O(\m_axis_tdata[31]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[31]_i_9 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[25] ),
        .O(\m_axis_tdata[31]_i_9_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[8]_i_10 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[1] ),
        .O(\m_axis_tdata[8]_i_10_n_0 ));
  LUT2 #(
    .INIT(4'hE)) 
    \m_axis_tdata[8]_i_2 
       (.I0(\handle_ramp.out_count_reg_n_0_[0] ),
        .I1(out_count1__62),
        .O(out_count));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[8]_i_3 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[8] ),
        .O(\m_axis_tdata[8]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[8]_i_4 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[7] ),
        .O(\m_axis_tdata[8]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[8]_i_5 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[6] ),
        .O(\m_axis_tdata[8]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[8]_i_6 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[5] ),
        .O(\m_axis_tdata[8]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[8]_i_7 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[4] ),
        .O(\m_axis_tdata[8]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[8]_i_8 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[3] ),
        .O(\m_axis_tdata[8]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h1)) 
    \m_axis_tdata[8]_i_9 
       (.I0(out_count1__62),
        .I1(\handle_ramp.out_count_reg_n_0_[2] ),
        .O(\m_axis_tdata[8]_i_9_n_0 ));
  FDRE \m_axis_tdata_reg[0] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[0]),
        .Q(m_axis_tdata[0]),
        .R(1'b0));
  FDRE \m_axis_tdata_reg[10] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[10]),
        .Q(m_axis_tdata[10]),
        .R(1'b0));
  FDRE \m_axis_tdata_reg[11] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[11]),
        .Q(m_axis_tdata[11]),
        .R(1'b0));
  FDRE \m_axis_tdata_reg[12] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[12]),
        .Q(m_axis_tdata[12]),
        .R(1'b0));
  FDRE \m_axis_tdata_reg[13] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[13]),
        .Q(m_axis_tdata[13]),
        .R(1'b0));
  FDRE \m_axis_tdata_reg[14] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[14]),
        .Q(m_axis_tdata[14]),
        .R(1'b0));
  FDRE \m_axis_tdata_reg[15] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[15]),
        .Q(m_axis_tdata[15]),
        .R(1'b0));
  FDRE \m_axis_tdata_reg[16] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[16]),
        .Q(m_axis_tdata[16]),
        .R(1'b0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY8 \m_axis_tdata_reg[16]_i_1 
       (.CI(\m_axis_tdata_reg[8]_i_1_n_0 ),
        .CI_TOP(1'b0),
        .CO({\m_axis_tdata_reg[16]_i_1_n_0 ,\m_axis_tdata_reg[16]_i_1_n_1 ,\m_axis_tdata_reg[16]_i_1_n_2 ,\m_axis_tdata_reg[16]_i_1_n_3 ,\m_axis_tdata_reg[16]_i_1_n_4 ,\m_axis_tdata_reg[16]_i_1_n_5 ,\m_axis_tdata_reg[16]_i_1_n_6 ,\m_axis_tdata_reg[16]_i_1_n_7 }),
        .DI({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .O(out_count0[16:9]),
        .S({\m_axis_tdata[16]_i_2_n_0 ,\m_axis_tdata[16]_i_3_n_0 ,\m_axis_tdata[16]_i_4_n_0 ,\m_axis_tdata[16]_i_5_n_0 ,\m_axis_tdata[16]_i_6_n_0 ,\m_axis_tdata[16]_i_7_n_0 ,\m_axis_tdata[16]_i_8_n_0 ,\m_axis_tdata[16]_i_9_n_0 }));
  FDRE \m_axis_tdata_reg[17] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[17]),
        .Q(m_axis_tdata[17]),
        .R(1'b0));
  FDRE \m_axis_tdata_reg[18] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[18]),
        .Q(m_axis_tdata[18]),
        .R(1'b0));
  FDRE \m_axis_tdata_reg[19] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[19]),
        .Q(m_axis_tdata[19]),
        .R(1'b0));
  FDRE \m_axis_tdata_reg[1] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[1]),
        .Q(m_axis_tdata[1]),
        .R(1'b0));
  FDRE \m_axis_tdata_reg[20] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[20]),
        .Q(m_axis_tdata[20]),
        .R(1'b0));
  FDRE \m_axis_tdata_reg[21] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[21]),
        .Q(m_axis_tdata[21]),
        .R(1'b0));
  FDRE \m_axis_tdata_reg[22] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[22]),
        .Q(m_axis_tdata[22]),
        .R(1'b0));
  FDRE \m_axis_tdata_reg[23] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[23]),
        .Q(m_axis_tdata[23]),
        .R(1'b0));
  FDRE \m_axis_tdata_reg[24] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[24]),
        .Q(m_axis_tdata[24]),
        .R(1'b0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY8 \m_axis_tdata_reg[24]_i_1 
       (.CI(\m_axis_tdata_reg[16]_i_1_n_0 ),
        .CI_TOP(1'b0),
        .CO({\m_axis_tdata_reg[24]_i_1_n_0 ,\m_axis_tdata_reg[24]_i_1_n_1 ,\m_axis_tdata_reg[24]_i_1_n_2 ,\m_axis_tdata_reg[24]_i_1_n_3 ,\m_axis_tdata_reg[24]_i_1_n_4 ,\m_axis_tdata_reg[24]_i_1_n_5 ,\m_axis_tdata_reg[24]_i_1_n_6 ,\m_axis_tdata_reg[24]_i_1_n_7 }),
        .DI({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .O(out_count0[24:17]),
        .S({\m_axis_tdata[24]_i_2_n_0 ,\m_axis_tdata[24]_i_3_n_0 ,\m_axis_tdata[24]_i_4_n_0 ,\m_axis_tdata[24]_i_5_n_0 ,\m_axis_tdata[24]_i_6_n_0 ,\m_axis_tdata[24]_i_7_n_0 ,\m_axis_tdata[24]_i_8_n_0 ,\m_axis_tdata[24]_i_9_n_0 }));
  FDRE \m_axis_tdata_reg[25] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[25]),
        .Q(m_axis_tdata[25]),
        .R(1'b0));
  FDRE \m_axis_tdata_reg[26] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[26]),
        .Q(m_axis_tdata[26]),
        .R(1'b0));
  FDRE \m_axis_tdata_reg[27] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[27]),
        .Q(m_axis_tdata[27]),
        .R(1'b0));
  FDRE \m_axis_tdata_reg[28] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[28]),
        .Q(m_axis_tdata[28]),
        .R(1'b0));
  FDRE \m_axis_tdata_reg[29] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[29]),
        .Q(m_axis_tdata[29]),
        .R(1'b0));
  FDRE \m_axis_tdata_reg[2] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[2]),
        .Q(m_axis_tdata[2]),
        .R(1'b0));
  FDRE \m_axis_tdata_reg[30] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[30]),
        .Q(m_axis_tdata[30]),
        .R(1'b0));
  FDRE \m_axis_tdata_reg[31] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[31]),
        .Q(m_axis_tdata[31]),
        .R(1'b0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY8 \m_axis_tdata_reg[31]_i_2 
       (.CI(\m_axis_tdata_reg[24]_i_1_n_0 ),
        .CI_TOP(1'b0),
        .CO({\NLW_m_axis_tdata_reg[31]_i_2_CO_UNCONNECTED [7:6],\m_axis_tdata_reg[31]_i_2_n_2 ,\m_axis_tdata_reg[31]_i_2_n_3 ,\m_axis_tdata_reg[31]_i_2_n_4 ,\m_axis_tdata_reg[31]_i_2_n_5 ,\m_axis_tdata_reg[31]_i_2_n_6 ,\m_axis_tdata_reg[31]_i_2_n_7 }),
        .DI({1'b0,1'b0,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .O({\NLW_m_axis_tdata_reg[31]_i_2_O_UNCONNECTED [7],out_count0[31:25]}),
        .S({1'b0,\m_axis_tdata[31]_i_3_n_0 ,\m_axis_tdata[31]_i_4_n_0 ,\m_axis_tdata[31]_i_5_n_0 ,\m_axis_tdata[31]_i_6_n_0 ,\m_axis_tdata[31]_i_7_n_0 ,\m_axis_tdata[31]_i_8_n_0 ,\m_axis_tdata[31]_i_9_n_0 }));
  FDRE \m_axis_tdata_reg[3] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[3]),
        .Q(m_axis_tdata[3]),
        .R(1'b0));
  FDRE \m_axis_tdata_reg[4] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[4]),
        .Q(m_axis_tdata[4]),
        .R(1'b0));
  FDRE \m_axis_tdata_reg[5] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[5]),
        .Q(m_axis_tdata[5]),
        .R(1'b0));
  FDRE \m_axis_tdata_reg[6] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[6]),
        .Q(m_axis_tdata[6]),
        .R(1'b0));
  FDRE \m_axis_tdata_reg[7] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[7]),
        .Q(m_axis_tdata[7]),
        .R(1'b0));
  FDRE \m_axis_tdata_reg[8] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[8]),
        .Q(m_axis_tdata[8]),
        .R(1'b0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY8 \m_axis_tdata_reg[8]_i_1 
       (.CI(out_count),
        .CI_TOP(1'b0),
        .CO({\m_axis_tdata_reg[8]_i_1_n_0 ,\m_axis_tdata_reg[8]_i_1_n_1 ,\m_axis_tdata_reg[8]_i_1_n_2 ,\m_axis_tdata_reg[8]_i_1_n_3 ,\m_axis_tdata_reg[8]_i_1_n_4 ,\m_axis_tdata_reg[8]_i_1_n_5 ,\m_axis_tdata_reg[8]_i_1_n_6 ,\m_axis_tdata_reg[8]_i_1_n_7 }),
        .DI({1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1}),
        .O(out_count0[8:1]),
        .S({\m_axis_tdata[8]_i_3_n_0 ,\m_axis_tdata[8]_i_4_n_0 ,\m_axis_tdata[8]_i_5_n_0 ,\m_axis_tdata[8]_i_6_n_0 ,\m_axis_tdata[8]_i_7_n_0 ,\m_axis_tdata[8]_i_8_n_0 ,\m_axis_tdata[8]_i_9_n_0 ,\m_axis_tdata[8]_i_10_n_0 }));
  FDRE \m_axis_tdata_reg[9] 
       (.C(aclk),
        .CE(out_count12_out),
        .D(out_count0[9]),
        .Q(m_axis_tdata[9]),
        .R(1'b0));
  FDRE m_axis_tvalid_reg
       (.C(aclk),
        .CE(1'b1),
        .D(out_count12_out),
        .Q(m_axis_tlast),
        .R(1'b0));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY8 out_count2_carry
       (.CI(1'b0),
        .CI_TOP(1'b0),
        .CO({out_count2_carry_n_0,out_count2_carry_n_1,out_count2_carry_n_2,out_count2_carry_n_3,out_count2_carry_n_4,out_count2_carry_n_5,out_count2_carry_n_6,out_count2_carry_n_7}),
        .DI({out_count2_carry_i_1_n_0,out_count2_carry_i_2_n_0,out_count2_carry_i_3_n_0,out_count2_carry_i_4_n_0,out_count2_carry_i_5_n_0,out_count2_carry_i_6_n_0,out_count2_carry_i_7_n_0,out_count2_carry_i_8_n_0}),
        .O(NLW_out_count2_carry_O_UNCONNECTED[7:0]),
        .S({out_count2_carry_i_9_n_0,out_count2_carry_i_10_n_0,out_count2_carry_i_11_n_0,out_count2_carry_i_12_n_0,out_count2_carry_i_13_n_0,out_count2_carry_i_14_n_0,out_count2_carry_i_15_n_0,out_count2_carry_i_16_n_0}));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY8 out_count2_carry__0
       (.CI(out_count2_carry_n_0),
        .CI_TOP(1'b0),
        .CO({out_count21_in,out_count2_carry__0_n_1,out_count2_carry__0_n_2,out_count2_carry__0_n_3,out_count2_carry__0_n_4,out_count2_carry__0_n_5,out_count2_carry__0_n_6,out_count2_carry__0_n_7}),
        .DI({out_count2_carry__0_i_1_n_0,out_count2_carry__0_i_2_n_0,out_count2_carry__0_i_3_n_0,out_count2_carry__0_i_4_n_0,out_count2_carry__0_i_5_n_0,out_count2_carry__0_i_6_n_0,out_count2_carry__0_i_7_n_0,out_count2_carry__0_i_8_n_0}),
        .O(NLW_out_count2_carry__0_O_UNCONNECTED[7:0]),
        .S({out_count2_carry__0_i_9_n_0,out_count2_carry__0_i_10_n_0,out_count2_carry__0_i_11_n_0,out_count2_carry__0_i_12_n_0,out_count2_carry__0_i_13_n_0,out_count2_carry__0_i_14_n_0,out_count2_carry__0_i_15_n_0,out_count2_carry__0_i_16_n_0}));
  LUT3 #(
    .INIT(8'h02)) 
    out_count2_carry__0_i_1
       (.I0(\handle_ramp.out_count_reg_n_0_[30] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[31] ),
        .O(out_count2_carry__0_i_1_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    out_count2_carry__0_i_10
       (.I0(\handle_ramp.out_count_reg_n_0_[28] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[29] ),
        .O(out_count2_carry__0_i_10_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    out_count2_carry__0_i_11
       (.I0(\handle_ramp.out_count_reg_n_0_[26] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[27] ),
        .O(out_count2_carry__0_i_11_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    out_count2_carry__0_i_12
       (.I0(\handle_ramp.out_count_reg_n_0_[24] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[25] ),
        .O(out_count2_carry__0_i_12_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    out_count2_carry__0_i_13
       (.I0(\handle_ramp.out_count_reg_n_0_[22] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[23] ),
        .O(out_count2_carry__0_i_13_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    out_count2_carry__0_i_14
       (.I0(\handle_ramp.out_count_reg_n_0_[20] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[21] ),
        .O(out_count2_carry__0_i_14_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    out_count2_carry__0_i_15
       (.I0(\handle_ramp.out_count_reg_n_0_[18] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[19] ),
        .O(out_count2_carry__0_i_15_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    out_count2_carry__0_i_16
       (.I0(\handle_ramp.out_count_reg_n_0_[16] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[17] ),
        .O(out_count2_carry__0_i_16_n_0));
  LUT3 #(
    .INIT(8'hFE)) 
    out_count2_carry__0_i_2
       (.I0(\handle_ramp.out_count_reg_n_0_[28] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[29] ),
        .O(out_count2_carry__0_i_2_n_0));
  LUT3 #(
    .INIT(8'hFE)) 
    out_count2_carry__0_i_3
       (.I0(\handle_ramp.out_count_reg_n_0_[26] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[27] ),
        .O(out_count2_carry__0_i_3_n_0));
  LUT3 #(
    .INIT(8'hFE)) 
    out_count2_carry__0_i_4
       (.I0(\handle_ramp.out_count_reg_n_0_[24] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[25] ),
        .O(out_count2_carry__0_i_4_n_0));
  LUT3 #(
    .INIT(8'hFE)) 
    out_count2_carry__0_i_5
       (.I0(\handle_ramp.out_count_reg_n_0_[22] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[23] ),
        .O(out_count2_carry__0_i_5_n_0));
  LUT3 #(
    .INIT(8'hFE)) 
    out_count2_carry__0_i_6
       (.I0(\handle_ramp.out_count_reg_n_0_[20] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[21] ),
        .O(out_count2_carry__0_i_6_n_0));
  LUT3 #(
    .INIT(8'hFE)) 
    out_count2_carry__0_i_7
       (.I0(\handle_ramp.out_count_reg_n_0_[18] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[19] ),
        .O(out_count2_carry__0_i_7_n_0));
  LUT3 #(
    .INIT(8'hFE)) 
    out_count2_carry__0_i_8
       (.I0(\handle_ramp.out_count_reg_n_0_[16] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[17] ),
        .O(out_count2_carry__0_i_8_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    out_count2_carry__0_i_9
       (.I0(\handle_ramp.out_count_reg_n_0_[30] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[31] ),
        .O(out_count2_carry__0_i_9_n_0));
  LUT3 #(
    .INIT(8'hFE)) 
    out_count2_carry_i_1
       (.I0(\handle_ramp.out_count_reg_n_0_[14] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[15] ),
        .O(out_count2_carry_i_1_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    out_count2_carry_i_10
       (.I0(\handle_ramp.out_count_reg_n_0_[12] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[13] ),
        .O(out_count2_carry_i_10_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    out_count2_carry_i_11
       (.I0(\handle_ramp.out_count_reg_n_0_[10] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[11] ),
        .O(out_count2_carry_i_11_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    out_count2_carry_i_12
       (.I0(\handle_ramp.out_count_reg_n_0_[8] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[9] ),
        .O(out_count2_carry_i_12_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    out_count2_carry_i_13
       (.I0(\handle_ramp.out_count_reg_n_0_[6] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[7] ),
        .O(out_count2_carry_i_13_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    out_count2_carry_i_14
       (.I0(\handle_ramp.out_count_reg_n_0_[4] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[5] ),
        .O(out_count2_carry_i_14_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    out_count2_carry_i_15
       (.I0(\handle_ramp.out_count_reg_n_0_[2] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[3] ),
        .O(out_count2_carry_i_15_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    out_count2_carry_i_16
       (.I0(\handle_ramp.out_count_reg_n_0_[0] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[1] ),
        .O(out_count2_carry_i_16_n_0));
  LUT3 #(
    .INIT(8'hFE)) 
    out_count2_carry_i_2
       (.I0(\handle_ramp.out_count_reg_n_0_[12] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[13] ),
        .O(out_count2_carry_i_2_n_0));
  LUT3 #(
    .INIT(8'hFE)) 
    out_count2_carry_i_3
       (.I0(\handle_ramp.out_count_reg_n_0_[10] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[11] ),
        .O(out_count2_carry_i_3_n_0));
  LUT3 #(
    .INIT(8'hFE)) 
    out_count2_carry_i_4
       (.I0(\handle_ramp.out_count_reg_n_0_[8] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[9] ),
        .O(out_count2_carry_i_4_n_0));
  LUT3 #(
    .INIT(8'hFE)) 
    out_count2_carry_i_5
       (.I0(\handle_ramp.out_count_reg_n_0_[6] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[7] ),
        .O(out_count2_carry_i_5_n_0));
  LUT3 #(
    .INIT(8'hFE)) 
    out_count2_carry_i_6
       (.I0(\handle_ramp.out_count_reg_n_0_[4] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[5] ),
        .O(out_count2_carry_i_6_n_0));
  LUT3 #(
    .INIT(8'hFE)) 
    out_count2_carry_i_7
       (.I0(\handle_ramp.out_count_reg_n_0_[2] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[3] ),
        .O(out_count2_carry_i_7_n_0));
  LUT3 #(
    .INIT(8'hFE)) 
    out_count2_carry_i_8
       (.I0(\handle_ramp.out_count_reg_n_0_[0] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[1] ),
        .O(out_count2_carry_i_8_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    out_count2_carry_i_9
       (.I0(\handle_ramp.out_count_reg_n_0_[14] ),
        .I1(out_count1__62),
        .I2(\handle_ramp.out_count_reg_n_0_[15] ),
        .O(out_count2_carry_i_9_n_0));
  FDRE \prev_reg_reg[0] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[0]),
        .Q(prev_reg[0]),
        .R(1'b0));
  FDRE \prev_reg_reg[10] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[10]),
        .Q(prev_reg[10]),
        .R(1'b0));
  FDRE \prev_reg_reg[11] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[11]),
        .Q(prev_reg[11]),
        .R(1'b0));
  FDRE \prev_reg_reg[12] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[12]),
        .Q(prev_reg[12]),
        .R(1'b0));
  FDRE \prev_reg_reg[13] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[13]),
        .Q(prev_reg[13]),
        .R(1'b0));
  FDRE \prev_reg_reg[14] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[14]),
        .Q(prev_reg[14]),
        .R(1'b0));
  FDRE \prev_reg_reg[15] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[15]),
        .Q(prev_reg[15]),
        .R(1'b0));
  FDRE \prev_reg_reg[16] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[16]),
        .Q(prev_reg[16]),
        .R(1'b0));
  FDRE \prev_reg_reg[17] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[17]),
        .Q(prev_reg[17]),
        .R(1'b0));
  FDRE \prev_reg_reg[18] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[18]),
        .Q(prev_reg[18]),
        .R(1'b0));
  FDRE \prev_reg_reg[19] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[19]),
        .Q(prev_reg[19]),
        .R(1'b0));
  FDRE \prev_reg_reg[1] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[1]),
        .Q(prev_reg[1]),
        .R(1'b0));
  FDRE \prev_reg_reg[20] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[20]),
        .Q(prev_reg[20]),
        .R(1'b0));
  FDRE \prev_reg_reg[21] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[21]),
        .Q(prev_reg[21]),
        .R(1'b0));
  FDRE \prev_reg_reg[22] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[22]),
        .Q(prev_reg[22]),
        .R(1'b0));
  FDRE \prev_reg_reg[23] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[23]),
        .Q(prev_reg[23]),
        .R(1'b0));
  FDRE \prev_reg_reg[24] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[24]),
        .Q(prev_reg[24]),
        .R(1'b0));
  FDRE \prev_reg_reg[25] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[25]),
        .Q(prev_reg[25]),
        .R(1'b0));
  FDRE \prev_reg_reg[26] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[26]),
        .Q(prev_reg[26]),
        .R(1'b0));
  FDRE \prev_reg_reg[27] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[27]),
        .Q(prev_reg[27]),
        .R(1'b0));
  FDRE \prev_reg_reg[28] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[28]),
        .Q(prev_reg[28]),
        .R(1'b0));
  FDRE \prev_reg_reg[29] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[29]),
        .Q(prev_reg[29]),
        .R(1'b0));
  FDRE \prev_reg_reg[2] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[2]),
        .Q(prev_reg[2]),
        .R(1'b0));
  FDRE \prev_reg_reg[30] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[30]),
        .Q(prev_reg[30]),
        .R(1'b0));
  FDRE \prev_reg_reg[31] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[31]),
        .Q(prev_reg[31]),
        .R(1'b0));
  FDRE \prev_reg_reg[3] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[3]),
        .Q(prev_reg[3]),
        .R(1'b0));
  FDRE \prev_reg_reg[4] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[4]),
        .Q(prev_reg[4]),
        .R(1'b0));
  FDRE \prev_reg_reg[5] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[5]),
        .Q(prev_reg[5]),
        .R(1'b0));
  FDRE \prev_reg_reg[6] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[6]),
        .Q(prev_reg[6]),
        .R(1'b0));
  FDRE \prev_reg_reg[7] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[7]),
        .Q(prev_reg[7]),
        .R(1'b0));
  FDRE \prev_reg_reg[8] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[8]),
        .Q(prev_reg[8]),
        .R(1'b0));
  FDRE \prev_reg_reg[9] 
       (.C(aclk),
        .CE(1'b1),
        .D(cfg_reg[9]),
        .Q(prev_reg[9]),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
