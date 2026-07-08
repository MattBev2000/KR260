// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
// Date        : Mon Jul  6 14:12:17 2026
// Host        : win1217 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/bevilacqua/Documents/projects/KR260/code/blink_mk_VI/blink_mk_VI.gen/sources_1/bd/design_1/ip/design_1_prescaler_0_0/design_1_prescaler_0_0_sim_netlist.v
// Design      : design_1_prescaler_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xck26-sfvc784-2LV-c
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_prescaler_0_0,prescaler,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* ip_definition_source = "module_ref" *) 
(* x_core_info = "prescaler,Vivado 2024.2" *) 
(* NotValidForBitStream *)
module design_1_prescaler_0_0
   (clk_in,
    reset,
    clk_out);
  input clk_in;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 reset RST" *) (* x_interface_mode = "slave reset" *) (* x_interface_parameter = "XIL_INTERFACENAME reset, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input reset;
  output clk_out;

  wire clk_in;
  wire clk_out;
  wire reset;

  design_1_prescaler_0_0_prescaler U0
       (.clk_in(clk_in),
        .clk_out(clk_out),
        .reset(reset));
endmodule

(* ORIG_REF_NAME = "prescaler" *) 
module design_1_prescaler_0_0_prescaler
   (clk_out,
    clk_in,
    reset);
  output clk_out;
  input clk_in;
  input reset;

  wire clk_in;
  wire clk_out;
  wire [18:0]counter;
  wire counter0_carry__0_n_0;
  wire counter0_carry__0_n_1;
  wire counter0_carry__0_n_2;
  wire counter0_carry__0_n_3;
  wire counter0_carry__0_n_4;
  wire counter0_carry__0_n_5;
  wire counter0_carry__0_n_6;
  wire counter0_carry__0_n_7;
  wire counter0_carry__1_n_7;
  wire counter0_carry_n_0;
  wire counter0_carry_n_1;
  wire counter0_carry_n_2;
  wire counter0_carry_n_3;
  wire counter0_carry_n_4;
  wire counter0_carry_n_5;
  wire counter0_carry_n_6;
  wire counter0_carry_n_7;
  wire [18:0]counter_0;
  wire [18:1]data0;
  wire reset;
  wire tmp_i_1_n_0;
  wire tmp_i_2_n_0;
  wire tmp_i_3_n_0;
  wire tmp_i_4_n_0;
  wire tmp_i_5_n_0;
  wire tmp_i_6_n_0;
  wire tmp_i_7_n_0;
  wire [7:1]NLW_counter0_carry__1_CO_UNCONNECTED;
  wire [7:2]NLW_counter0_carry__1_O_UNCONNECTED;

  (* ADDER_THRESHOLD = "35" *) 
  CARRY8 counter0_carry
       (.CI(counter[0]),
        .CI_TOP(1'b0),
        .CO({counter0_carry_n_0,counter0_carry_n_1,counter0_carry_n_2,counter0_carry_n_3,counter0_carry_n_4,counter0_carry_n_5,counter0_carry_n_6,counter0_carry_n_7}),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .O(data0[8:1]),
        .S(counter[8:1]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY8 counter0_carry__0
       (.CI(counter0_carry_n_0),
        .CI_TOP(1'b0),
        .CO({counter0_carry__0_n_0,counter0_carry__0_n_1,counter0_carry__0_n_2,counter0_carry__0_n_3,counter0_carry__0_n_4,counter0_carry__0_n_5,counter0_carry__0_n_6,counter0_carry__0_n_7}),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .O(data0[16:9]),
        .S(counter[16:9]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY8 counter0_carry__1
       (.CI(counter0_carry__0_n_0),
        .CI_TOP(1'b0),
        .CO({NLW_counter0_carry__1_CO_UNCONNECTED[7:1],counter0_carry__1_n_7}),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_counter0_carry__1_O_UNCONNECTED[7:2],data0[18:17]}),
        .S({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,counter[18:17]}));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \counter[0]_i_1 
       (.I0(counter[0]),
        .O(counter_0[0]));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000000)) 
    \counter[10]_i_1 
       (.I0(tmp_i_3_n_0),
        .I1(tmp_i_4_n_0),
        .I2(tmp_i_5_n_0),
        .I3(tmp_i_6_n_0),
        .I4(tmp_i_7_n_0),
        .I5(data0[10]),
        .O(counter_0[10]));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000000)) 
    \counter[11]_i_1 
       (.I0(tmp_i_3_n_0),
        .I1(tmp_i_4_n_0),
        .I2(tmp_i_5_n_0),
        .I3(tmp_i_6_n_0),
        .I4(tmp_i_7_n_0),
        .I5(data0[11]),
        .O(counter_0[11]));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000000)) 
    \counter[12]_i_1 
       (.I0(tmp_i_3_n_0),
        .I1(tmp_i_4_n_0),
        .I2(tmp_i_5_n_0),
        .I3(tmp_i_6_n_0),
        .I4(tmp_i_7_n_0),
        .I5(data0[12]),
        .O(counter_0[12]));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000000)) 
    \counter[13]_i_1 
       (.I0(tmp_i_3_n_0),
        .I1(tmp_i_4_n_0),
        .I2(tmp_i_5_n_0),
        .I3(tmp_i_6_n_0),
        .I4(tmp_i_7_n_0),
        .I5(data0[13]),
        .O(counter_0[13]));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000000)) 
    \counter[14]_i_1 
       (.I0(tmp_i_3_n_0),
        .I1(tmp_i_4_n_0),
        .I2(tmp_i_5_n_0),
        .I3(tmp_i_6_n_0),
        .I4(tmp_i_7_n_0),
        .I5(data0[14]),
        .O(counter_0[14]));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000000)) 
    \counter[15]_i_1 
       (.I0(tmp_i_3_n_0),
        .I1(tmp_i_4_n_0),
        .I2(tmp_i_5_n_0),
        .I3(tmp_i_6_n_0),
        .I4(tmp_i_7_n_0),
        .I5(data0[15]),
        .O(counter_0[15]));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000000)) 
    \counter[16]_i_1 
       (.I0(tmp_i_3_n_0),
        .I1(tmp_i_4_n_0),
        .I2(tmp_i_5_n_0),
        .I3(tmp_i_6_n_0),
        .I4(tmp_i_7_n_0),
        .I5(data0[16]),
        .O(counter_0[16]));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000000)) 
    \counter[17]_i_1 
       (.I0(tmp_i_3_n_0),
        .I1(tmp_i_4_n_0),
        .I2(tmp_i_5_n_0),
        .I3(tmp_i_6_n_0),
        .I4(tmp_i_7_n_0),
        .I5(data0[17]),
        .O(counter_0[17]));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000000)) 
    \counter[18]_i_1 
       (.I0(tmp_i_3_n_0),
        .I1(tmp_i_4_n_0),
        .I2(tmp_i_5_n_0),
        .I3(tmp_i_6_n_0),
        .I4(tmp_i_7_n_0),
        .I5(data0[18]),
        .O(counter_0[18]));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000000)) 
    \counter[1]_i_1 
       (.I0(tmp_i_3_n_0),
        .I1(tmp_i_4_n_0),
        .I2(tmp_i_5_n_0),
        .I3(tmp_i_6_n_0),
        .I4(tmp_i_7_n_0),
        .I5(data0[1]),
        .O(counter_0[1]));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000000)) 
    \counter[2]_i_1 
       (.I0(tmp_i_3_n_0),
        .I1(tmp_i_4_n_0),
        .I2(tmp_i_5_n_0),
        .I3(tmp_i_6_n_0),
        .I4(tmp_i_7_n_0),
        .I5(data0[2]),
        .O(counter_0[2]));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000000)) 
    \counter[3]_i_1 
       (.I0(tmp_i_3_n_0),
        .I1(tmp_i_4_n_0),
        .I2(tmp_i_5_n_0),
        .I3(tmp_i_6_n_0),
        .I4(tmp_i_7_n_0),
        .I5(data0[3]),
        .O(counter_0[3]));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000000)) 
    \counter[4]_i_1 
       (.I0(tmp_i_3_n_0),
        .I1(tmp_i_4_n_0),
        .I2(tmp_i_5_n_0),
        .I3(tmp_i_6_n_0),
        .I4(tmp_i_7_n_0),
        .I5(data0[4]),
        .O(counter_0[4]));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000000)) 
    \counter[5]_i_1 
       (.I0(tmp_i_3_n_0),
        .I1(tmp_i_4_n_0),
        .I2(tmp_i_5_n_0),
        .I3(tmp_i_6_n_0),
        .I4(tmp_i_7_n_0),
        .I5(data0[5]),
        .O(counter_0[5]));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000000)) 
    \counter[6]_i_1 
       (.I0(tmp_i_3_n_0),
        .I1(tmp_i_4_n_0),
        .I2(tmp_i_5_n_0),
        .I3(tmp_i_6_n_0),
        .I4(tmp_i_7_n_0),
        .I5(data0[6]),
        .O(counter_0[6]));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000000)) 
    \counter[7]_i_1 
       (.I0(tmp_i_3_n_0),
        .I1(tmp_i_4_n_0),
        .I2(tmp_i_5_n_0),
        .I3(tmp_i_6_n_0),
        .I4(tmp_i_7_n_0),
        .I5(data0[7]),
        .O(counter_0[7]));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000000)) 
    \counter[8]_i_1 
       (.I0(tmp_i_3_n_0),
        .I1(tmp_i_4_n_0),
        .I2(tmp_i_5_n_0),
        .I3(tmp_i_6_n_0),
        .I4(tmp_i_7_n_0),
        .I5(data0[8]),
        .O(counter_0[8]));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000000)) 
    \counter[9]_i_1 
       (.I0(tmp_i_3_n_0),
        .I1(tmp_i_4_n_0),
        .I2(tmp_i_5_n_0),
        .I3(tmp_i_6_n_0),
        .I4(tmp_i_7_n_0),
        .I5(data0[9]),
        .O(counter_0[9]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_reg[0] 
       (.C(clk_in),
        .CE(1'b1),
        .CLR(tmp_i_2_n_0),
        .D(counter_0[0]),
        .Q(counter[0]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_reg[10] 
       (.C(clk_in),
        .CE(1'b1),
        .CLR(tmp_i_2_n_0),
        .D(counter_0[10]),
        .Q(counter[10]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_reg[11] 
       (.C(clk_in),
        .CE(1'b1),
        .CLR(tmp_i_2_n_0),
        .D(counter_0[11]),
        .Q(counter[11]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_reg[12] 
       (.C(clk_in),
        .CE(1'b1),
        .CLR(tmp_i_2_n_0),
        .D(counter_0[12]),
        .Q(counter[12]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_reg[13] 
       (.C(clk_in),
        .CE(1'b1),
        .CLR(tmp_i_2_n_0),
        .D(counter_0[13]),
        .Q(counter[13]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_reg[14] 
       (.C(clk_in),
        .CE(1'b1),
        .CLR(tmp_i_2_n_0),
        .D(counter_0[14]),
        .Q(counter[14]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_reg[15] 
       (.C(clk_in),
        .CE(1'b1),
        .CLR(tmp_i_2_n_0),
        .D(counter_0[15]),
        .Q(counter[15]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_reg[16] 
       (.C(clk_in),
        .CE(1'b1),
        .CLR(tmp_i_2_n_0),
        .D(counter_0[16]),
        .Q(counter[16]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_reg[17] 
       (.C(clk_in),
        .CE(1'b1),
        .CLR(tmp_i_2_n_0),
        .D(counter_0[17]),
        .Q(counter[17]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_reg[18] 
       (.C(clk_in),
        .CE(1'b1),
        .CLR(tmp_i_2_n_0),
        .D(counter_0[18]),
        .Q(counter[18]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_reg[1] 
       (.C(clk_in),
        .CE(1'b1),
        .CLR(tmp_i_2_n_0),
        .D(counter_0[1]),
        .Q(counter[1]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_reg[2] 
       (.C(clk_in),
        .CE(1'b1),
        .CLR(tmp_i_2_n_0),
        .D(counter_0[2]),
        .Q(counter[2]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_reg[3] 
       (.C(clk_in),
        .CE(1'b1),
        .CLR(tmp_i_2_n_0),
        .D(counter_0[3]),
        .Q(counter[3]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_reg[4] 
       (.C(clk_in),
        .CE(1'b1),
        .CLR(tmp_i_2_n_0),
        .D(counter_0[4]),
        .Q(counter[4]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_reg[5] 
       (.C(clk_in),
        .CE(1'b1),
        .CLR(tmp_i_2_n_0),
        .D(counter_0[5]),
        .Q(counter[5]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_reg[6] 
       (.C(clk_in),
        .CE(1'b1),
        .CLR(tmp_i_2_n_0),
        .D(counter_0[6]),
        .Q(counter[6]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_reg[7] 
       (.C(clk_in),
        .CE(1'b1),
        .CLR(tmp_i_2_n_0),
        .D(counter_0[7]),
        .Q(counter[7]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_reg[8] 
       (.C(clk_in),
        .CE(1'b1),
        .CLR(tmp_i_2_n_0),
        .D(counter_0[8]),
        .Q(counter[8]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_reg[9] 
       (.C(clk_in),
        .CE(1'b1),
        .CLR(tmp_i_2_n_0),
        .D(counter_0[9]),
        .Q(counter[9]));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000001)) 
    tmp_i_1
       (.I0(tmp_i_3_n_0),
        .I1(tmp_i_4_n_0),
        .I2(tmp_i_5_n_0),
        .I3(tmp_i_6_n_0),
        .I4(tmp_i_7_n_0),
        .I5(clk_out),
        .O(tmp_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    tmp_i_2
       (.I0(reset),
        .O(tmp_i_2_n_0));
  LUT4 #(
    .INIT(16'h7FFF)) 
    tmp_i_3
       (.I0(counter[2]),
        .I1(counter[1]),
        .I2(counter[4]),
        .I3(counter[3]),
        .O(tmp_i_3_n_0));
  LUT4 #(
    .INIT(16'hDFFF)) 
    tmp_i_4
       (.I0(counter[13]),
        .I1(counter[14]),
        .I2(counter[16]),
        .I3(counter[15]),
        .O(tmp_i_4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h7F)) 
    tmp_i_5
       (.I0(counter[18]),
        .I1(counter[17]),
        .I2(counter[0]),
        .O(tmp_i_5_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    tmp_i_6
       (.I0(counter[10]),
        .I1(counter[9]),
        .I2(counter[12]),
        .I3(counter[11]),
        .O(tmp_i_6_n_0));
  LUT4 #(
    .INIT(16'hFFEF)) 
    tmp_i_7
       (.I0(counter[6]),
        .I1(counter[5]),
        .I2(counter[8]),
        .I3(counter[7]),
        .O(tmp_i_7_n_0));
  FDCE #(
    .INIT(1'b1)) 
    tmp_reg
       (.C(clk_in),
        .CE(1'b1),
        .CLR(tmp_i_2_n_0),
        .D(tmp_i_1_n_0),
        .Q(clk_out));
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
