// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
// Date        : Tue Feb 18 11:21:19 2025
// Host        : Goose running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/ASUS/Documents/PhD/kriask/prj/blink_mk_VII/blink_mk_VII.gen/sources_1/bd/design_1/ip/design_1_axi_cfg_register_0_0/design_1_axi_cfg_register_0_0_sim_netlist.v
// Design      : design_1_axi_cfg_register_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xck26-sfvc784-2LV-c
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_axi_cfg_register_0_0,axi_cfg_register,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* ip_definition_source = "module_ref" *) 
(* x_core_info = "axi_cfg_register,Vivado 2024.1" *) 
(* NotValidForBitStream *)
module design_1_axi_cfg_register_0_0
   (aclk,
    aresetn,
    cfg_data,
    s_axi_awaddr,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_araddr,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rvalid,
    s_axi_rready);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 aclk CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME aclk, ASSOCIATED_BUSIF s_axi, ASSOCIATED_RESET aresetn, FREQ_HZ 99999001, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, INSERT_VIP 0" *) input aclk;
  (* x_interface_info = "xilinx.com:signal:reset:1.0 aresetn RST" *) (* x_interface_parameter = "XIL_INTERFACENAME aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input aresetn;
  output [31:0]cfg_data;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi AWADDR" *) (* x_interface_parameter = "XIL_INTERFACENAME s_axi, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 99999001, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input [31:0]s_axi_awaddr;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi AWVALID" *) input s_axi_awvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi AWREADY" *) output s_axi_awready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi WDATA" *) input [31:0]s_axi_wdata;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi WSTRB" *) input [3:0]s_axi_wstrb;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi WVALID" *) input s_axi_wvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi WREADY" *) output s_axi_wready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi BRESP" *) output [1:0]s_axi_bresp;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi BVALID" *) output s_axi_bvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi BREADY" *) input s_axi_bready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi ARADDR" *) input [31:0]s_axi_araddr;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi ARVALID" *) input s_axi_arvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi ARREADY" *) output s_axi_arready;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) output [31:0]s_axi_rdata;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi RRESP" *) output [1:0]s_axi_rresp;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi RVALID" *) output s_axi_rvalid;
  (* x_interface_info = "xilinx.com:interface:aximm:1.0 s_axi RREADY" *) input s_axi_rready;

  wire \<const0> ;
  wire \<const1> ;
  wire aclk;
  wire aresetn;
  wire [31:0]cfg_data;
  wire s_axi_arvalid;
  wire [31:0]s_axi_awaddr;
  wire s_axi_awready;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire s_axi_bvalid;
  wire [31:0]s_axi_rdata;
  wire s_axi_rready;
  wire s_axi_rvalid;
  wire [31:0]s_axi_wdata;
  wire [3:0]s_axi_wstrb;
  wire s_axi_wvalid;

  assign s_axi_arready = \<const1> ;
  assign s_axi_bresp[1] = \<const0> ;
  assign s_axi_bresp[0] = \<const0> ;
  assign s_axi_rresp[1] = \<const0> ;
  assign s_axi_rresp[0] = \<const0> ;
  assign s_axi_wready = s_axi_awready;
  GND GND
       (.G(\<const0> ));
  design_1_axi_cfg_register_0_0_axi_cfg_register U0
       (.aclk(aclk),
        .aresetn(aresetn),
        .cfg_data(cfg_data),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr(s_axi_awaddr[2]),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bready(s_axi_bready),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rready(s_axi_rready),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wstrb(s_axi_wstrb),
        .s_axi_wvalid(s_axi_wvalid));
  VCC VCC
       (.P(\<const1> ));
  LUT2 #(
    .INIT(4'h8)) 
    s_axi_wready_INST_0
       (.I0(s_axi_awvalid),
        .I1(s_axi_wvalid),
        .O(s_axi_awready));
endmodule

(* ORIG_REF_NAME = "axi_cfg_register" *) 
module design_1_axi_cfg_register_0_0_axi_cfg_register
   (cfg_data,
    s_axi_bvalid,
    s_axi_rvalid,
    s_axi_rdata,
    s_axi_wdata,
    aclk,
    s_axi_awaddr,
    s_axi_awvalid,
    s_axi_wvalid,
    s_axi_wstrb,
    s_axi_arvalid,
    aresetn,
    s_axi_bready,
    s_axi_rready);
  output [31:0]cfg_data;
  output s_axi_bvalid;
  output s_axi_rvalid;
  output [31:0]s_axi_rdata;
  input [31:0]s_axi_wdata;
  input aclk;
  input [0:0]s_axi_awaddr;
  input s_axi_awvalid;
  input s_axi_wvalid;
  input [3:0]s_axi_wstrb;
  input s_axi_arvalid;
  input aresetn;
  input s_axi_bready;
  input s_axi_rready;

  wire CE0;
  wire CE03_out;
  wire CE06_out;
  wire R0;
  wire \WORDS[0].BITS[7].FDRE_inst_i_1_n_0 ;
  wire aclk;
  wire aresetn;
  wire [31:0]cfg_data;
  wire int_bvalid_reg_i_1_n_0;
  wire int_rvalid_reg_i_1_n_0;
  wire s_axi_arvalid;
  wire [0:0]s_axi_awaddr;
  wire s_axi_awvalid;
  wire s_axi_bready;
  wire s_axi_bvalid;
  wire [31:0]s_axi_rdata;
  wire s_axi_rready;
  wire s_axi_rvalid;
  wire [31:0]s_axi_wdata;
  wire [3:0]s_axi_wstrb;
  wire s_axi_wvalid;

  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[0].FDRE_inst 
       (.C(aclk),
        .CE(\WORDS[0].BITS[7].FDRE_inst_i_1_n_0 ),
        .D(s_axi_wdata[0]),
        .Q(cfg_data[0]),
        .R(R0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[10].FDRE_inst 
       (.C(aclk),
        .CE(CE03_out),
        .D(s_axi_wdata[10]),
        .Q(cfg_data[10]),
        .R(R0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[11].FDRE_inst 
       (.C(aclk),
        .CE(CE03_out),
        .D(s_axi_wdata[11]),
        .Q(cfg_data[11]),
        .R(R0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[12].FDRE_inst 
       (.C(aclk),
        .CE(CE03_out),
        .D(s_axi_wdata[12]),
        .Q(cfg_data[12]),
        .R(R0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[13].FDRE_inst 
       (.C(aclk),
        .CE(CE03_out),
        .D(s_axi_wdata[13]),
        .Q(cfg_data[13]),
        .R(R0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[14].FDRE_inst 
       (.C(aclk),
        .CE(CE03_out),
        .D(s_axi_wdata[14]),
        .Q(cfg_data[14]),
        .R(R0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[15].FDRE_inst 
       (.C(aclk),
        .CE(CE03_out),
        .D(s_axi_wdata[15]),
        .Q(cfg_data[15]),
        .R(R0));
  LUT4 #(
    .INIT(16'h4000)) 
    \WORDS[0].BITS[15].FDRE_inst_i_1 
       (.I0(s_axi_awaddr),
        .I1(s_axi_awvalid),
        .I2(s_axi_wvalid),
        .I3(s_axi_wstrb[1]),
        .O(CE03_out));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[16].FDRE_inst 
       (.C(aclk),
        .CE(CE06_out),
        .D(s_axi_wdata[16]),
        .Q(cfg_data[16]),
        .R(R0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[17].FDRE_inst 
       (.C(aclk),
        .CE(CE06_out),
        .D(s_axi_wdata[17]),
        .Q(cfg_data[17]),
        .R(R0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[18].FDRE_inst 
       (.C(aclk),
        .CE(CE06_out),
        .D(s_axi_wdata[18]),
        .Q(cfg_data[18]),
        .R(R0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[19].FDRE_inst 
       (.C(aclk),
        .CE(CE06_out),
        .D(s_axi_wdata[19]),
        .Q(cfg_data[19]),
        .R(R0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[1].FDRE_inst 
       (.C(aclk),
        .CE(\WORDS[0].BITS[7].FDRE_inst_i_1_n_0 ),
        .D(s_axi_wdata[1]),
        .Q(cfg_data[1]),
        .R(R0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[20].FDRE_inst 
       (.C(aclk),
        .CE(CE06_out),
        .D(s_axi_wdata[20]),
        .Q(cfg_data[20]),
        .R(R0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[21].FDRE_inst 
       (.C(aclk),
        .CE(CE06_out),
        .D(s_axi_wdata[21]),
        .Q(cfg_data[21]),
        .R(R0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[22].FDRE_inst 
       (.C(aclk),
        .CE(CE06_out),
        .D(s_axi_wdata[22]),
        .Q(cfg_data[22]),
        .R(R0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[23].FDRE_inst 
       (.C(aclk),
        .CE(CE06_out),
        .D(s_axi_wdata[23]),
        .Q(cfg_data[23]),
        .R(R0));
  LUT4 #(
    .INIT(16'h4000)) 
    \WORDS[0].BITS[23].FDRE_inst_i_1 
       (.I0(s_axi_awaddr),
        .I1(s_axi_awvalid),
        .I2(s_axi_wvalid),
        .I3(s_axi_wstrb[2]),
        .O(CE06_out));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[24].FDRE_inst 
       (.C(aclk),
        .CE(CE0),
        .D(s_axi_wdata[24]),
        .Q(cfg_data[24]),
        .R(R0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[25].FDRE_inst 
       (.C(aclk),
        .CE(CE0),
        .D(s_axi_wdata[25]),
        .Q(cfg_data[25]),
        .R(R0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[26].FDRE_inst 
       (.C(aclk),
        .CE(CE0),
        .D(s_axi_wdata[26]),
        .Q(cfg_data[26]),
        .R(R0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[27].FDRE_inst 
       (.C(aclk),
        .CE(CE0),
        .D(s_axi_wdata[27]),
        .Q(cfg_data[27]),
        .R(R0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[28].FDRE_inst 
       (.C(aclk),
        .CE(CE0),
        .D(s_axi_wdata[28]),
        .Q(cfg_data[28]),
        .R(R0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[29].FDRE_inst 
       (.C(aclk),
        .CE(CE0),
        .D(s_axi_wdata[29]),
        .Q(cfg_data[29]),
        .R(R0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[2].FDRE_inst 
       (.C(aclk),
        .CE(\WORDS[0].BITS[7].FDRE_inst_i_1_n_0 ),
        .D(s_axi_wdata[2]),
        .Q(cfg_data[2]),
        .R(R0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[30].FDRE_inst 
       (.C(aclk),
        .CE(CE0),
        .D(s_axi_wdata[30]),
        .Q(cfg_data[30]),
        .R(R0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[31].FDRE_inst 
       (.C(aclk),
        .CE(CE0),
        .D(s_axi_wdata[31]),
        .Q(cfg_data[31]),
        .R(R0));
  LUT1 #(
    .INIT(2'h1)) 
    \WORDS[0].BITS[31].FDRE_inst_i_1 
       (.I0(aresetn),
        .O(R0));
  LUT4 #(
    .INIT(16'h4000)) 
    \WORDS[0].BITS[31].FDRE_inst_i_2 
       (.I0(s_axi_awaddr),
        .I1(s_axi_awvalid),
        .I2(s_axi_wvalid),
        .I3(s_axi_wstrb[3]),
        .O(CE0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[3].FDRE_inst 
       (.C(aclk),
        .CE(\WORDS[0].BITS[7].FDRE_inst_i_1_n_0 ),
        .D(s_axi_wdata[3]),
        .Q(cfg_data[3]),
        .R(R0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[4].FDRE_inst 
       (.C(aclk),
        .CE(\WORDS[0].BITS[7].FDRE_inst_i_1_n_0 ),
        .D(s_axi_wdata[4]),
        .Q(cfg_data[4]),
        .R(R0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[5].FDRE_inst 
       (.C(aclk),
        .CE(\WORDS[0].BITS[7].FDRE_inst_i_1_n_0 ),
        .D(s_axi_wdata[5]),
        .Q(cfg_data[5]),
        .R(R0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[6].FDRE_inst 
       (.C(aclk),
        .CE(\WORDS[0].BITS[7].FDRE_inst_i_1_n_0 ),
        .D(s_axi_wdata[6]),
        .Q(cfg_data[6]),
        .R(R0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[7].FDRE_inst 
       (.C(aclk),
        .CE(\WORDS[0].BITS[7].FDRE_inst_i_1_n_0 ),
        .D(s_axi_wdata[7]),
        .Q(cfg_data[7]),
        .R(R0));
  LUT4 #(
    .INIT(16'h4000)) 
    \WORDS[0].BITS[7].FDRE_inst_i_1 
       (.I0(s_axi_awaddr),
        .I1(s_axi_awvalid),
        .I2(s_axi_wvalid),
        .I3(s_axi_wstrb[0]),
        .O(\WORDS[0].BITS[7].FDRE_inst_i_1_n_0 ));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[8].FDRE_inst 
       (.C(aclk),
        .CE(CE03_out),
        .D(s_axi_wdata[8]),
        .Q(cfg_data[8]),
        .R(R0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  FDRE #(
    .INIT(1'b0),
    .IS_C_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_R_INVERTED(1'b0)) 
    \WORDS[0].BITS[9].FDRE_inst 
       (.C(aclk),
        .CE(CE03_out),
        .D(s_axi_wdata[9]),
        .Q(cfg_data[9]),
        .R(R0));
  LUT5 #(
    .INIT(32'h00F08080)) 
    int_bvalid_reg_i_1
       (.I0(s_axi_awvalid),
        .I1(s_axi_wvalid),
        .I2(aresetn),
        .I3(s_axi_bready),
        .I4(s_axi_bvalid),
        .O(int_bvalid_reg_i_1_n_0));
  FDRE int_bvalid_reg_reg
       (.C(aclk),
        .CE(1'b1),
        .D(int_bvalid_reg_i_1_n_0),
        .Q(s_axi_bvalid),
        .R(1'b0));
  FDRE \int_rdata_reg_reg[0] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[0]),
        .Q(s_axi_rdata[0]),
        .R(R0));
  FDRE \int_rdata_reg_reg[10] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[10]),
        .Q(s_axi_rdata[10]),
        .R(R0));
  FDRE \int_rdata_reg_reg[11] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[11]),
        .Q(s_axi_rdata[11]),
        .R(R0));
  FDRE \int_rdata_reg_reg[12] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[12]),
        .Q(s_axi_rdata[12]),
        .R(R0));
  FDRE \int_rdata_reg_reg[13] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[13]),
        .Q(s_axi_rdata[13]),
        .R(R0));
  FDRE \int_rdata_reg_reg[14] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[14]),
        .Q(s_axi_rdata[14]),
        .R(R0));
  FDRE \int_rdata_reg_reg[15] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[15]),
        .Q(s_axi_rdata[15]),
        .R(R0));
  FDRE \int_rdata_reg_reg[16] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[16]),
        .Q(s_axi_rdata[16]),
        .R(R0));
  FDRE \int_rdata_reg_reg[17] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[17]),
        .Q(s_axi_rdata[17]),
        .R(R0));
  FDRE \int_rdata_reg_reg[18] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[18]),
        .Q(s_axi_rdata[18]),
        .R(R0));
  FDRE \int_rdata_reg_reg[19] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[19]),
        .Q(s_axi_rdata[19]),
        .R(R0));
  FDRE \int_rdata_reg_reg[1] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[1]),
        .Q(s_axi_rdata[1]),
        .R(R0));
  FDRE \int_rdata_reg_reg[20] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[20]),
        .Q(s_axi_rdata[20]),
        .R(R0));
  FDRE \int_rdata_reg_reg[21] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[21]),
        .Q(s_axi_rdata[21]),
        .R(R0));
  FDRE \int_rdata_reg_reg[22] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[22]),
        .Q(s_axi_rdata[22]),
        .R(R0));
  FDRE \int_rdata_reg_reg[23] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[23]),
        .Q(s_axi_rdata[23]),
        .R(R0));
  FDRE \int_rdata_reg_reg[24] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[24]),
        .Q(s_axi_rdata[24]),
        .R(R0));
  FDRE \int_rdata_reg_reg[25] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[25]),
        .Q(s_axi_rdata[25]),
        .R(R0));
  FDRE \int_rdata_reg_reg[26] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[26]),
        .Q(s_axi_rdata[26]),
        .R(R0));
  FDRE \int_rdata_reg_reg[27] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[27]),
        .Q(s_axi_rdata[27]),
        .R(R0));
  FDRE \int_rdata_reg_reg[28] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[28]),
        .Q(s_axi_rdata[28]),
        .R(R0));
  FDRE \int_rdata_reg_reg[29] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[29]),
        .Q(s_axi_rdata[29]),
        .R(R0));
  FDRE \int_rdata_reg_reg[2] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[2]),
        .Q(s_axi_rdata[2]),
        .R(R0));
  FDRE \int_rdata_reg_reg[30] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[30]),
        .Q(s_axi_rdata[30]),
        .R(R0));
  FDRE \int_rdata_reg_reg[31] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[31]),
        .Q(s_axi_rdata[31]),
        .R(R0));
  FDRE \int_rdata_reg_reg[3] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[3]),
        .Q(s_axi_rdata[3]),
        .R(R0));
  FDRE \int_rdata_reg_reg[4] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[4]),
        .Q(s_axi_rdata[4]),
        .R(R0));
  FDRE \int_rdata_reg_reg[5] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[5]),
        .Q(s_axi_rdata[5]),
        .R(R0));
  FDRE \int_rdata_reg_reg[6] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[6]),
        .Q(s_axi_rdata[6]),
        .R(R0));
  FDRE \int_rdata_reg_reg[7] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[7]),
        .Q(s_axi_rdata[7]),
        .R(R0));
  FDRE \int_rdata_reg_reg[8] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[8]),
        .Q(s_axi_rdata[8]),
        .R(R0));
  FDRE \int_rdata_reg_reg[9] 
       (.C(aclk),
        .CE(s_axi_arvalid),
        .D(cfg_data[9]),
        .Q(s_axi_rdata[9]),
        .R(R0));
  LUT4 #(
    .INIT(16'h0C88)) 
    int_rvalid_reg_i_1
       (.I0(s_axi_arvalid),
        .I1(aresetn),
        .I2(s_axi_rready),
        .I3(s_axi_rvalid),
        .O(int_rvalid_reg_i_1_n_0));
  FDRE int_rvalid_reg_reg
       (.C(aclk),
        .CE(1'b1),
        .D(int_rvalid_reg_i_1_n_0),
        .Q(s_axi_rvalid),
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
