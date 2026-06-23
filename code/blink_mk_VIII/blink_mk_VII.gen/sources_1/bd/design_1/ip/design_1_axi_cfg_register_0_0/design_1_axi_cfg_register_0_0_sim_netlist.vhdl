-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.1 (lin64) Build 5076996 Wed May 22 18:36:09 MDT 2024
-- Date        : Thu Jun  5 10:28:20 2025
-- Host        : aidevel running 64-bit unknown
-- Command     : write_vhdl -force -mode funcsim
--               /data/devel/kria_mb/vivado/blink_mk_VIII/blink_mk_VII.gen/sources_1/bd/design_1/ip/design_1_axi_cfg_register_0_0/design_1_axi_cfg_register_0_0_sim_netlist.vhdl
-- Design      : design_1_axi_cfg_register_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xck26-sfvc784-2LV-c
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_axi_cfg_register_0_0_axi_cfg_register is
  port (
    cfg_data : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    aclk : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_rready : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_axi_cfg_register_0_0_axi_cfg_register : entity is "axi_cfg_register";
end design_1_axi_cfg_register_0_0_axi_cfg_register;

architecture STRUCTURE of design_1_axi_cfg_register_0_0_axi_cfg_register is
  signal CE0 : STD_LOGIC;
  signal CE03_out : STD_LOGIC;
  signal CE06_out : STD_LOGIC;
  signal R0 : STD_LOGIC;
  signal \WORDS[0].BITS[7].FDRE_inst_i_1_n_0\ : STD_LOGIC;
  signal \^cfg_data\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal int_bvalid_reg_i_1_n_0 : STD_LOGIC;
  signal int_rvalid_reg_i_1_n_0 : STD_LOGIC;
  signal \^s_axi_bvalid\ : STD_LOGIC;
  signal \^s_axi_rvalid\ : STD_LOGIC;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of \WORDS[0].BITS[0].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[10].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[11].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[12].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[13].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[14].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[15].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[16].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[17].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[18].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[19].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[1].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[20].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[21].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[22].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[23].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[24].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[25].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[26].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[27].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[28].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[29].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[2].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[30].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[31].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[3].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[4].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[5].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[6].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[7].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[8].FDRE_inst\ : label is "PRIMITIVE";
  attribute BOX_TYPE of \WORDS[0].BITS[9].FDRE_inst\ : label is "PRIMITIVE";
begin
  cfg_data(31 downto 0) <= \^cfg_data\(31 downto 0);
  s_axi_bvalid <= \^s_axi_bvalid\;
  s_axi_rvalid <= \^s_axi_rvalid\;
\WORDS[0].BITS[0].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => \WORDS[0].BITS[7].FDRE_inst_i_1_n_0\,
      D => s_axi_wdata(0),
      Q => \^cfg_data\(0),
      R => R0
    );
\WORDS[0].BITS[10].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => CE03_out,
      D => s_axi_wdata(10),
      Q => \^cfg_data\(10),
      R => R0
    );
\WORDS[0].BITS[11].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => CE03_out,
      D => s_axi_wdata(11),
      Q => \^cfg_data\(11),
      R => R0
    );
\WORDS[0].BITS[12].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => CE03_out,
      D => s_axi_wdata(12),
      Q => \^cfg_data\(12),
      R => R0
    );
\WORDS[0].BITS[13].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => CE03_out,
      D => s_axi_wdata(13),
      Q => \^cfg_data\(13),
      R => R0
    );
\WORDS[0].BITS[14].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => CE03_out,
      D => s_axi_wdata(14),
      Q => \^cfg_data\(14),
      R => R0
    );
\WORDS[0].BITS[15].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => CE03_out,
      D => s_axi_wdata(15),
      Q => \^cfg_data\(15),
      R => R0
    );
\WORDS[0].BITS[15].FDRE_inst_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
        port map (
      I0 => s_axi_awaddr(0),
      I1 => s_axi_awvalid,
      I2 => s_axi_wvalid,
      I3 => s_axi_wstrb(1),
      O => CE03_out
    );
\WORDS[0].BITS[16].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => CE06_out,
      D => s_axi_wdata(16),
      Q => \^cfg_data\(16),
      R => R0
    );
\WORDS[0].BITS[17].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => CE06_out,
      D => s_axi_wdata(17),
      Q => \^cfg_data\(17),
      R => R0
    );
\WORDS[0].BITS[18].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => CE06_out,
      D => s_axi_wdata(18),
      Q => \^cfg_data\(18),
      R => R0
    );
\WORDS[0].BITS[19].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => CE06_out,
      D => s_axi_wdata(19),
      Q => \^cfg_data\(19),
      R => R0
    );
\WORDS[0].BITS[1].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => \WORDS[0].BITS[7].FDRE_inst_i_1_n_0\,
      D => s_axi_wdata(1),
      Q => \^cfg_data\(1),
      R => R0
    );
\WORDS[0].BITS[20].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => CE06_out,
      D => s_axi_wdata(20),
      Q => \^cfg_data\(20),
      R => R0
    );
\WORDS[0].BITS[21].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => CE06_out,
      D => s_axi_wdata(21),
      Q => \^cfg_data\(21),
      R => R0
    );
\WORDS[0].BITS[22].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => CE06_out,
      D => s_axi_wdata(22),
      Q => \^cfg_data\(22),
      R => R0
    );
\WORDS[0].BITS[23].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => CE06_out,
      D => s_axi_wdata(23),
      Q => \^cfg_data\(23),
      R => R0
    );
\WORDS[0].BITS[23].FDRE_inst_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
        port map (
      I0 => s_axi_awaddr(0),
      I1 => s_axi_awvalid,
      I2 => s_axi_wvalid,
      I3 => s_axi_wstrb(2),
      O => CE06_out
    );
\WORDS[0].BITS[24].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => CE0,
      D => s_axi_wdata(24),
      Q => \^cfg_data\(24),
      R => R0
    );
\WORDS[0].BITS[25].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => CE0,
      D => s_axi_wdata(25),
      Q => \^cfg_data\(25),
      R => R0
    );
\WORDS[0].BITS[26].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => CE0,
      D => s_axi_wdata(26),
      Q => \^cfg_data\(26),
      R => R0
    );
\WORDS[0].BITS[27].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => CE0,
      D => s_axi_wdata(27),
      Q => \^cfg_data\(27),
      R => R0
    );
\WORDS[0].BITS[28].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => CE0,
      D => s_axi_wdata(28),
      Q => \^cfg_data\(28),
      R => R0
    );
\WORDS[0].BITS[29].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => CE0,
      D => s_axi_wdata(29),
      Q => \^cfg_data\(29),
      R => R0
    );
\WORDS[0].BITS[2].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => \WORDS[0].BITS[7].FDRE_inst_i_1_n_0\,
      D => s_axi_wdata(2),
      Q => \^cfg_data\(2),
      R => R0
    );
\WORDS[0].BITS[30].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => CE0,
      D => s_axi_wdata(30),
      Q => \^cfg_data\(30),
      R => R0
    );
\WORDS[0].BITS[31].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => CE0,
      D => s_axi_wdata(31),
      Q => \^cfg_data\(31),
      R => R0
    );
\WORDS[0].BITS[31].FDRE_inst_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => aresetn,
      O => R0
    );
\WORDS[0].BITS[31].FDRE_inst_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
        port map (
      I0 => s_axi_awaddr(0),
      I1 => s_axi_awvalid,
      I2 => s_axi_wvalid,
      I3 => s_axi_wstrb(3),
      O => CE0
    );
\WORDS[0].BITS[3].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => \WORDS[0].BITS[7].FDRE_inst_i_1_n_0\,
      D => s_axi_wdata(3),
      Q => \^cfg_data\(3),
      R => R0
    );
\WORDS[0].BITS[4].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => \WORDS[0].BITS[7].FDRE_inst_i_1_n_0\,
      D => s_axi_wdata(4),
      Q => \^cfg_data\(4),
      R => R0
    );
\WORDS[0].BITS[5].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => \WORDS[0].BITS[7].FDRE_inst_i_1_n_0\,
      D => s_axi_wdata(5),
      Q => \^cfg_data\(5),
      R => R0
    );
\WORDS[0].BITS[6].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => \WORDS[0].BITS[7].FDRE_inst_i_1_n_0\,
      D => s_axi_wdata(6),
      Q => \^cfg_data\(6),
      R => R0
    );
\WORDS[0].BITS[7].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => \WORDS[0].BITS[7].FDRE_inst_i_1_n_0\,
      D => s_axi_wdata(7),
      Q => \^cfg_data\(7),
      R => R0
    );
\WORDS[0].BITS[7].FDRE_inst_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4000"
    )
        port map (
      I0 => s_axi_awaddr(0),
      I1 => s_axi_awvalid,
      I2 => s_axi_wvalid,
      I3 => s_axi_wstrb(0),
      O => \WORDS[0].BITS[7].FDRE_inst_i_1_n_0\
    );
\WORDS[0].BITS[8].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => CE03_out,
      D => s_axi_wdata(8),
      Q => \^cfg_data\(8),
      R => R0
    );
\WORDS[0].BITS[9].FDRE_inst\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0',
      IS_C_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_R_INVERTED => '0'
    )
        port map (
      C => aclk,
      CE => CE03_out,
      D => s_axi_wdata(9),
      Q => \^cfg_data\(9),
      R => R0
    );
int_bvalid_reg_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00F08080"
    )
        port map (
      I0 => s_axi_awvalid,
      I1 => s_axi_wvalid,
      I2 => aresetn,
      I3 => s_axi_bready,
      I4 => \^s_axi_bvalid\,
      O => int_bvalid_reg_i_1_n_0
    );
int_bvalid_reg_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => int_bvalid_reg_i_1_n_0,
      Q => \^s_axi_bvalid\,
      R => '0'
    );
\int_rdata_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(0),
      Q => s_axi_rdata(0),
      R => R0
    );
\int_rdata_reg_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(10),
      Q => s_axi_rdata(10),
      R => R0
    );
\int_rdata_reg_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(11),
      Q => s_axi_rdata(11),
      R => R0
    );
\int_rdata_reg_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(12),
      Q => s_axi_rdata(12),
      R => R0
    );
\int_rdata_reg_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(13),
      Q => s_axi_rdata(13),
      R => R0
    );
\int_rdata_reg_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(14),
      Q => s_axi_rdata(14),
      R => R0
    );
\int_rdata_reg_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(15),
      Q => s_axi_rdata(15),
      R => R0
    );
\int_rdata_reg_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(16),
      Q => s_axi_rdata(16),
      R => R0
    );
\int_rdata_reg_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(17),
      Q => s_axi_rdata(17),
      R => R0
    );
\int_rdata_reg_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(18),
      Q => s_axi_rdata(18),
      R => R0
    );
\int_rdata_reg_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(19),
      Q => s_axi_rdata(19),
      R => R0
    );
\int_rdata_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(1),
      Q => s_axi_rdata(1),
      R => R0
    );
\int_rdata_reg_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(20),
      Q => s_axi_rdata(20),
      R => R0
    );
\int_rdata_reg_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(21),
      Q => s_axi_rdata(21),
      R => R0
    );
\int_rdata_reg_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(22),
      Q => s_axi_rdata(22),
      R => R0
    );
\int_rdata_reg_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(23),
      Q => s_axi_rdata(23),
      R => R0
    );
\int_rdata_reg_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(24),
      Q => s_axi_rdata(24),
      R => R0
    );
\int_rdata_reg_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(25),
      Q => s_axi_rdata(25),
      R => R0
    );
\int_rdata_reg_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(26),
      Q => s_axi_rdata(26),
      R => R0
    );
\int_rdata_reg_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(27),
      Q => s_axi_rdata(27),
      R => R0
    );
\int_rdata_reg_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(28),
      Q => s_axi_rdata(28),
      R => R0
    );
\int_rdata_reg_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(29),
      Q => s_axi_rdata(29),
      R => R0
    );
\int_rdata_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(2),
      Q => s_axi_rdata(2),
      R => R0
    );
\int_rdata_reg_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(30),
      Q => s_axi_rdata(30),
      R => R0
    );
\int_rdata_reg_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(31),
      Q => s_axi_rdata(31),
      R => R0
    );
\int_rdata_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(3),
      Q => s_axi_rdata(3),
      R => R0
    );
\int_rdata_reg_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(4),
      Q => s_axi_rdata(4),
      R => R0
    );
\int_rdata_reg_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(5),
      Q => s_axi_rdata(5),
      R => R0
    );
\int_rdata_reg_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(6),
      Q => s_axi_rdata(6),
      R => R0
    );
\int_rdata_reg_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(7),
      Q => s_axi_rdata(7),
      R => R0
    );
\int_rdata_reg_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(8),
      Q => s_axi_rdata(8),
      R => R0
    );
\int_rdata_reg_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => s_axi_arvalid,
      D => \^cfg_data\(9),
      Q => s_axi_rdata(9),
      R => R0
    );
int_rvalid_reg_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0C88"
    )
        port map (
      I0 => s_axi_arvalid,
      I1 => aresetn,
      I2 => s_axi_rready,
      I3 => \^s_axi_rvalid\,
      O => int_rvalid_reg_i_1_n_0
    );
int_rvalid_reg_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => int_rvalid_reg_i_1_n_0,
      Q => \^s_axi_rvalid\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_axi_cfg_register_0_0 is
  port (
    aclk : in STD_LOGIC;
    aresetn : in STD_LOGIC;
    cfg_data : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_axi_cfg_register_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_axi_cfg_register_0_0 : entity is "design_1_axi_cfg_register_0_0,axi_cfg_register,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of design_1_axi_cfg_register_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of design_1_axi_cfg_register_0_0 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of design_1_axi_cfg_register_0_0 : entity is "axi_cfg_register,Vivado 2024.1";
end design_1_axi_cfg_register_0_0;

architecture STRUCTURE of design_1_axi_cfg_register_0_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \<const1>\ : STD_LOGIC;
  signal \^s_axi_awready\ : STD_LOGIC;
  attribute x_interface_info : string;
  attribute x_interface_info of aclk : signal is "xilinx.com:signal:clock:1.0 aclk CLK";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of aclk : signal is "XIL_INTERFACENAME aclk, ASSOCIATED_BUSIF s_axi, ASSOCIATED_RESET aresetn, FREQ_HZ 99999001, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, INSERT_VIP 0";
  attribute x_interface_info of aresetn : signal is "xilinx.com:signal:reset:1.0 aresetn RST";
  attribute x_interface_parameter of aresetn : signal is "XIL_INTERFACENAME aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute x_interface_info of s_axi_arready : signal is "xilinx.com:interface:aximm:1.0 s_axi ARREADY";
  attribute x_interface_info of s_axi_arvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi ARVALID";
  attribute x_interface_info of s_axi_awready : signal is "xilinx.com:interface:aximm:1.0 s_axi AWREADY";
  attribute x_interface_info of s_axi_awvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi AWVALID";
  attribute x_interface_info of s_axi_bready : signal is "xilinx.com:interface:aximm:1.0 s_axi BREADY";
  attribute x_interface_info of s_axi_bvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi BVALID";
  attribute x_interface_info of s_axi_rready : signal is "xilinx.com:interface:aximm:1.0 s_axi RREADY";
  attribute x_interface_info of s_axi_rvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi RVALID";
  attribute x_interface_info of s_axi_wready : signal is "xilinx.com:interface:aximm:1.0 s_axi WREADY";
  attribute x_interface_info of s_axi_wvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi WVALID";
  attribute x_interface_info of s_axi_araddr : signal is "xilinx.com:interface:aximm:1.0 s_axi ARADDR";
  attribute x_interface_info of s_axi_awaddr : signal is "xilinx.com:interface:aximm:1.0 s_axi AWADDR";
  attribute x_interface_parameter of s_axi_awaddr : signal is "XIL_INTERFACENAME s_axi, DATA_WIDTH 32, PROTOCOL AXI4LITE, FREQ_HZ 99999001, ID_WIDTH 0, ADDR_WIDTH 32, AWUSER_WIDTH 0, ARUSER_WIDTH 0, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 0, HAS_LOCK 0, HAS_PROT 0, HAS_CACHE 0, HAS_QOS 0, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 0, NUM_READ_OUTSTANDING 1, NUM_WRITE_OUTSTANDING 1, MAX_BURST_LENGTH 1, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute x_interface_info of s_axi_bresp : signal is "xilinx.com:interface:aximm:1.0 s_axi BRESP";
  attribute x_interface_info of s_axi_rdata : signal is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute x_interface_info of s_axi_rresp : signal is "xilinx.com:interface:aximm:1.0 s_axi RRESP";
  attribute x_interface_info of s_axi_wdata : signal is "xilinx.com:interface:aximm:1.0 s_axi WDATA";
  attribute x_interface_info of s_axi_wstrb : signal is "xilinx.com:interface:aximm:1.0 s_axi WSTRB";
begin
  s_axi_arready <= \<const1>\;
  s_axi_awready <= \^s_axi_awready\;
  s_axi_bresp(1) <= \<const0>\;
  s_axi_bresp(0) <= \<const0>\;
  s_axi_rresp(1) <= \<const0>\;
  s_axi_rresp(0) <= \<const0>\;
  s_axi_wready <= \^s_axi_awready\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
U0: entity work.design_1_axi_cfg_register_0_0_axi_cfg_register
     port map (
      aclk => aclk,
      aresetn => aresetn,
      cfg_data(31 downto 0) => cfg_data(31 downto 0),
      s_axi_arvalid => s_axi_arvalid,
      s_axi_awaddr(0) => s_axi_awaddr(2),
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bready => s_axi_bready,
      s_axi_bvalid => s_axi_bvalid,
      s_axi_rdata(31 downto 0) => s_axi_rdata(31 downto 0),
      s_axi_rready => s_axi_rready,
      s_axi_rvalid => s_axi_rvalid,
      s_axi_wdata(31 downto 0) => s_axi_wdata(31 downto 0),
      s_axi_wstrb(3 downto 0) => s_axi_wstrb(3 downto 0),
      s_axi_wvalid => s_axi_wvalid
    );
VCC: unisim.vcomponents.VCC
     port map (
      P => \<const1>\
    );
s_axi_wready_INST_0: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => s_axi_awvalid,
      I1 => s_axi_wvalid,
      O => \^s_axi_awready\
    );
end STRUCTURE;
