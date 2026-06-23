// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
// Date        : Sat Dec 28 07:43:16 2024
// Host        : Goose running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/ASUS/iCloudDrive/PhD-kriask/prj/blink_mk_III/blink_mk_III.gen/sources_1/bd/kria_starter_kit/ip/kria_starter_kit_prescaler_0_0/kria_starter_kit_prescaler_0_0_sim_netlist.v
// Design      : kria_starter_kit_prescaler_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xck26-sfvc784-2LV-c
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "kria_starter_kit_prescaler_0_0,prescaler,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* ip_definition_source = "module_ref" *) 
(* x_core_info = "prescaler,Vivado 2024.1" *) 
(* NotValidForBitStream *)
module kria_starter_kit_prescaler_0_0
   (data_in,
    data_out);
  input data_in;
  output data_out;

  wire data_in;
  wire data_out;

  kria_starter_kit_prescaler_0_0_prescaler U0
       (.data_in(data_in),
        .data_out(data_out));
endmodule

(* ORIG_REF_NAME = "prescaler" *) 
module kria_starter_kit_prescaler_0_0_prescaler
   (data_out,
    data_in);
  output data_out;
  input data_in;

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
  wire data_in;
  wire data_out;
  wire [18:0]p_1_in;
  wire tmp;
  wire tmp_i_1_n_0;
  wire tmp_i_2_n_0;
  wire tmp_i_3_n_0;
  wire tmp_i_4_n_0;
  wire tmp_i_5_n_0;
  wire tmp_i_6_n_0;
  wire [7:1]NLW_counter0_carry__1_CO_UNCONNECTED;
  wire [7:2]NLW_counter0_carry__1_O_UNCONNECTED;

  (* ADDER_THRESHOLD = "35" *) 
  CARRY8 counter0_carry
       (.CI(counter[0]),
        .CI_TOP(1'b0),
        .CO({counter0_carry_n_0,counter0_carry_n_1,counter0_carry_n_2,counter0_carry_n_3,counter0_carry_n_4,counter0_carry_n_5,counter0_carry_n_6,counter0_carry_n_7}),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .O(p_1_in[8:1]),
        .S(counter[8:1]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY8 counter0_carry__0
       (.CI(counter0_carry_n_0),
        .CI_TOP(1'b0),
        .CO({counter0_carry__0_n_0,counter0_carry__0_n_1,counter0_carry__0_n_2,counter0_carry__0_n_3,counter0_carry__0_n_4,counter0_carry__0_n_5,counter0_carry__0_n_6,counter0_carry__0_n_7}),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .O(p_1_in[16:9]),
        .S(counter[16:9]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY8 counter0_carry__1
       (.CI(counter0_carry__0_n_0),
        .CI_TOP(1'b0),
        .CO({NLW_counter0_carry__1_CO_UNCONNECTED[7:1],counter0_carry__1_n_7}),
        .DI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_counter0_carry__1_O_UNCONNECTED[7:2],p_1_in[18:17]}),
        .S({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,counter[18:17]}));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT1 #(
    .INIT(2'h1)) 
    \counter[0]_i_1 
       (.I0(counter[0]),
        .O(p_1_in[0]));
  LUT5 #(
    .INIT(32'h00000004)) 
    \counter[18]_i_1 
       (.I0(tmp_i_6_n_0),
        .I1(tmp_i_5_n_0),
        .I2(tmp_i_4_n_0),
        .I3(tmp_i_3_n_0),
        .I4(tmp_i_2_n_0),
        .O(tmp));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[0] 
       (.C(data_in),
        .CE(1'b1),
        .D(p_1_in[0]),
        .Q(counter[0]),
        .R(tmp));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[10] 
       (.C(data_in),
        .CE(1'b1),
        .D(p_1_in[10]),
        .Q(counter[10]),
        .R(tmp));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[11] 
       (.C(data_in),
        .CE(1'b1),
        .D(p_1_in[11]),
        .Q(counter[11]),
        .R(tmp));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[12] 
       (.C(data_in),
        .CE(1'b1),
        .D(p_1_in[12]),
        .Q(counter[12]),
        .R(tmp));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[13] 
       (.C(data_in),
        .CE(1'b1),
        .D(p_1_in[13]),
        .Q(counter[13]),
        .R(tmp));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[14] 
       (.C(data_in),
        .CE(1'b1),
        .D(p_1_in[14]),
        .Q(counter[14]),
        .R(tmp));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[15] 
       (.C(data_in),
        .CE(1'b1),
        .D(p_1_in[15]),
        .Q(counter[15]),
        .R(tmp));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[16] 
       (.C(data_in),
        .CE(1'b1),
        .D(p_1_in[16]),
        .Q(counter[16]),
        .R(tmp));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[17] 
       (.C(data_in),
        .CE(1'b1),
        .D(p_1_in[17]),
        .Q(counter[17]),
        .R(tmp));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[18] 
       (.C(data_in),
        .CE(1'b1),
        .D(p_1_in[18]),
        .Q(counter[18]),
        .R(tmp));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[1] 
       (.C(data_in),
        .CE(1'b1),
        .D(p_1_in[1]),
        .Q(counter[1]),
        .R(tmp));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[2] 
       (.C(data_in),
        .CE(1'b1),
        .D(p_1_in[2]),
        .Q(counter[2]),
        .R(tmp));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[3] 
       (.C(data_in),
        .CE(1'b1),
        .D(p_1_in[3]),
        .Q(counter[3]),
        .R(tmp));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[4] 
       (.C(data_in),
        .CE(1'b1),
        .D(p_1_in[4]),
        .Q(counter[4]),
        .R(tmp));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[5] 
       (.C(data_in),
        .CE(1'b1),
        .D(p_1_in[5]),
        .Q(counter[5]),
        .R(tmp));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[6] 
       (.C(data_in),
        .CE(1'b1),
        .D(p_1_in[6]),
        .Q(counter[6]),
        .R(tmp));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[7] 
       (.C(data_in),
        .CE(1'b1),
        .D(p_1_in[7]),
        .Q(counter[7]),
        .R(tmp));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[8] 
       (.C(data_in),
        .CE(1'b1),
        .D(p_1_in[8]),
        .Q(counter[8]),
        .R(tmp));
  FDRE #(
    .INIT(1'b0)) 
    \counter_reg[9] 
       (.C(data_in),
        .CE(1'b1),
        .D(p_1_in[9]),
        .Q(counter[9]),
        .R(tmp));
  LUT6 #(
    .INIT(64'hFFFFFEFF00000100)) 
    tmp_i_1
       (.I0(tmp_i_2_n_0),
        .I1(tmp_i_3_n_0),
        .I2(tmp_i_4_n_0),
        .I3(tmp_i_5_n_0),
        .I4(tmp_i_6_n_0),
        .I5(data_out),
        .O(tmp_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hBF)) 
    tmp_i_2
       (.I0(counter[5]),
        .I1(counter[17]),
        .I2(counter[0]),
        .O(tmp_i_2_n_0));
  LUT4 #(
    .INIT(16'hFFEF)) 
    tmp_i_3
       (.I0(counter[12]),
        .I1(counter[6]),
        .I2(counter[2]),
        .I3(counter[10]),
        .O(tmp_i_3_n_0));
  LUT4 #(
    .INIT(16'hFFEF)) 
    tmp_i_4
       (.I0(counter[7]),
        .I1(counter[11]),
        .I2(counter[18]),
        .I3(counter[14]),
        .O(tmp_i_4_n_0));
  LUT4 #(
    .INIT(16'h8000)) 
    tmp_i_5
       (.I0(counter[4]),
        .I1(counter[13]),
        .I2(counter[3]),
        .I3(counter[1]),
        .O(tmp_i_5_n_0));
  LUT4 #(
    .INIT(16'hDFFF)) 
    tmp_i_6
       (.I0(counter[16]),
        .I1(counter[9]),
        .I2(counter[15]),
        .I3(counter[8]),
        .O(tmp_i_6_n_0));
  FDRE #(
    .INIT(1'b1)) 
    tmp_reg
       (.C(data_in),
        .CE(1'b1),
        .D(tmp_i_1_n_0),
        .Q(data_out),
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
