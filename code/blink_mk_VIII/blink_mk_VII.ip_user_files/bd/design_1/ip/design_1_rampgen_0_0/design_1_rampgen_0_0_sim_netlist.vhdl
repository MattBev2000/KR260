-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.1 (lin64) Build 5076996 Wed May 22 18:36:09 MDT 2024
-- Date        : Fri Feb 21 11:18:15 2025
-- Host        : aidevel running 64-bit unknown
-- Command     : write_vhdl -force -mode funcsim
--               /data/devel/kria_mb/vivado/blink_mk_VIII/blink_mk_VII.gen/sources_1/bd/design_1/ip/design_1_rampgen_0_0/design_1_rampgen_0_0_sim_netlist.vhdl
-- Design      : design_1_rampgen_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xck26-sfvc784-2LV-c
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_rampgen_0_0_rampgen is
  port (
    m_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tlast : out STD_LOGIC;
    led : out STD_LOGIC;
    cfg_reg : in STD_LOGIC_VECTOR ( 31 downto 0 );
    aclk : in STD_LOGIC;
    m_axis_tready : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_rampgen_0_0_rampgen : entity is "rampgen";
end design_1_rampgen_0_0_rampgen;

architecture STRUCTURE of design_1_rampgen_0_0_rampgen is
  signal \handle_ramp.out_count_reg_n_0_[0]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[10]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[11]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[12]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[13]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[14]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[15]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[16]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[17]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[18]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[19]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[1]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[20]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[21]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[22]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[23]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[24]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[25]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[26]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[27]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[28]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[29]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[2]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[30]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[31]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[3]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[4]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[5]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[6]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[7]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[8]\ : STD_LOGIC;
  signal \handle_ramp.out_count_reg_n_0_[9]\ : STD_LOGIC;
  signal \^led\ : STD_LOGIC;
  signal led_out_i_1_n_0 : STD_LOGIC;
  signal \m_axis_tdata[0]_i_10_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[0]_i_11_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[0]_i_12_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[0]_i_13_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[0]_i_14_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[0]_i_15_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[0]_i_16_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[0]_i_17_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[0]_i_18_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[0]_i_19_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[0]_i_20_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[0]_i_3_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[0]_i_4_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[0]_i_5_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[0]_i_6_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[0]_i_7_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[0]_i_8_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[0]_i_9_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[16]_i_2_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[16]_i_3_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[16]_i_4_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[16]_i_5_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[16]_i_6_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[16]_i_7_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[16]_i_8_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[16]_i_9_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[24]_i_2_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[24]_i_3_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[24]_i_4_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[24]_i_5_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[24]_i_6_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[24]_i_7_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[24]_i_8_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[24]_i_9_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[31]_i_3_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[31]_i_4_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[31]_i_5_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[31]_i_6_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[31]_i_7_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[31]_i_8_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[31]_i_9_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[8]_i_10_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[8]_i_3_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[8]_i_4_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[8]_i_5_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[8]_i_6_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[8]_i_7_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[8]_i_8_n_0\ : STD_LOGIC;
  signal \m_axis_tdata[8]_i_9_n_0\ : STD_LOGIC;
  signal \m_axis_tdata_reg[16]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_tdata_reg[16]_i_1_n_1\ : STD_LOGIC;
  signal \m_axis_tdata_reg[16]_i_1_n_2\ : STD_LOGIC;
  signal \m_axis_tdata_reg[16]_i_1_n_3\ : STD_LOGIC;
  signal \m_axis_tdata_reg[16]_i_1_n_4\ : STD_LOGIC;
  signal \m_axis_tdata_reg[16]_i_1_n_5\ : STD_LOGIC;
  signal \m_axis_tdata_reg[16]_i_1_n_6\ : STD_LOGIC;
  signal \m_axis_tdata_reg[16]_i_1_n_7\ : STD_LOGIC;
  signal \m_axis_tdata_reg[24]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_tdata_reg[24]_i_1_n_1\ : STD_LOGIC;
  signal \m_axis_tdata_reg[24]_i_1_n_2\ : STD_LOGIC;
  signal \m_axis_tdata_reg[24]_i_1_n_3\ : STD_LOGIC;
  signal \m_axis_tdata_reg[24]_i_1_n_4\ : STD_LOGIC;
  signal \m_axis_tdata_reg[24]_i_1_n_5\ : STD_LOGIC;
  signal \m_axis_tdata_reg[24]_i_1_n_6\ : STD_LOGIC;
  signal \m_axis_tdata_reg[24]_i_1_n_7\ : STD_LOGIC;
  signal \m_axis_tdata_reg[31]_i_2_n_2\ : STD_LOGIC;
  signal \m_axis_tdata_reg[31]_i_2_n_3\ : STD_LOGIC;
  signal \m_axis_tdata_reg[31]_i_2_n_4\ : STD_LOGIC;
  signal \m_axis_tdata_reg[31]_i_2_n_5\ : STD_LOGIC;
  signal \m_axis_tdata_reg[31]_i_2_n_6\ : STD_LOGIC;
  signal \m_axis_tdata_reg[31]_i_2_n_7\ : STD_LOGIC;
  signal \m_axis_tdata_reg[8]_i_1_n_0\ : STD_LOGIC;
  signal \m_axis_tdata_reg[8]_i_1_n_1\ : STD_LOGIC;
  signal \m_axis_tdata_reg[8]_i_1_n_2\ : STD_LOGIC;
  signal \m_axis_tdata_reg[8]_i_1_n_3\ : STD_LOGIC;
  signal \m_axis_tdata_reg[8]_i_1_n_4\ : STD_LOGIC;
  signal \m_axis_tdata_reg[8]_i_1_n_5\ : STD_LOGIC;
  signal \m_axis_tdata_reg[8]_i_1_n_6\ : STD_LOGIC;
  signal \m_axis_tdata_reg[8]_i_1_n_7\ : STD_LOGIC;
  signal out_count : STD_LOGIC_VECTOR ( 0 to 0 );
  signal out_count0 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal out_count12_out : STD_LOGIC;
  signal \out_count1__62\ : STD_LOGIC;
  signal out_count21_in : STD_LOGIC;
  signal \out_count2_carry__0_i_10_n_0\ : STD_LOGIC;
  signal \out_count2_carry__0_i_11_n_0\ : STD_LOGIC;
  signal \out_count2_carry__0_i_12_n_0\ : STD_LOGIC;
  signal \out_count2_carry__0_i_13_n_0\ : STD_LOGIC;
  signal \out_count2_carry__0_i_14_n_0\ : STD_LOGIC;
  signal \out_count2_carry__0_i_15_n_0\ : STD_LOGIC;
  signal \out_count2_carry__0_i_16_n_0\ : STD_LOGIC;
  signal \out_count2_carry__0_i_1_n_0\ : STD_LOGIC;
  signal \out_count2_carry__0_i_2_n_0\ : STD_LOGIC;
  signal \out_count2_carry__0_i_3_n_0\ : STD_LOGIC;
  signal \out_count2_carry__0_i_4_n_0\ : STD_LOGIC;
  signal \out_count2_carry__0_i_5_n_0\ : STD_LOGIC;
  signal \out_count2_carry__0_i_6_n_0\ : STD_LOGIC;
  signal \out_count2_carry__0_i_7_n_0\ : STD_LOGIC;
  signal \out_count2_carry__0_i_8_n_0\ : STD_LOGIC;
  signal \out_count2_carry__0_i_9_n_0\ : STD_LOGIC;
  signal \out_count2_carry__0_n_1\ : STD_LOGIC;
  signal \out_count2_carry__0_n_2\ : STD_LOGIC;
  signal \out_count2_carry__0_n_3\ : STD_LOGIC;
  signal \out_count2_carry__0_n_4\ : STD_LOGIC;
  signal \out_count2_carry__0_n_5\ : STD_LOGIC;
  signal \out_count2_carry__0_n_6\ : STD_LOGIC;
  signal \out_count2_carry__0_n_7\ : STD_LOGIC;
  signal out_count2_carry_i_10_n_0 : STD_LOGIC;
  signal out_count2_carry_i_11_n_0 : STD_LOGIC;
  signal out_count2_carry_i_12_n_0 : STD_LOGIC;
  signal out_count2_carry_i_13_n_0 : STD_LOGIC;
  signal out_count2_carry_i_14_n_0 : STD_LOGIC;
  signal out_count2_carry_i_15_n_0 : STD_LOGIC;
  signal out_count2_carry_i_16_n_0 : STD_LOGIC;
  signal out_count2_carry_i_1_n_0 : STD_LOGIC;
  signal out_count2_carry_i_2_n_0 : STD_LOGIC;
  signal out_count2_carry_i_3_n_0 : STD_LOGIC;
  signal out_count2_carry_i_4_n_0 : STD_LOGIC;
  signal out_count2_carry_i_5_n_0 : STD_LOGIC;
  signal out_count2_carry_i_6_n_0 : STD_LOGIC;
  signal out_count2_carry_i_7_n_0 : STD_LOGIC;
  signal out_count2_carry_i_8_n_0 : STD_LOGIC;
  signal out_count2_carry_i_9_n_0 : STD_LOGIC;
  signal out_count2_carry_n_0 : STD_LOGIC;
  signal out_count2_carry_n_1 : STD_LOGIC;
  signal out_count2_carry_n_2 : STD_LOGIC;
  signal out_count2_carry_n_3 : STD_LOGIC;
  signal out_count2_carry_n_4 : STD_LOGIC;
  signal out_count2_carry_n_5 : STD_LOGIC;
  signal out_count2_carry_n_6 : STD_LOGIC;
  signal out_count2_carry_n_7 : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal prev_reg : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \NLW_m_axis_tdata_reg[31]_i_2_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 6 );
  signal \NLW_m_axis_tdata_reg[31]_i_2_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 to 7 );
  signal NLW_out_count2_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \NLW_out_count2_carry__0_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 0 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \handle_ramp.out_count[0]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of led_out_i_1 : label is "soft_lutpair0";
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of \m_axis_tdata_reg[16]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \m_axis_tdata_reg[24]_i_1\ : label is 35;
  attribute ADDER_THRESHOLD of \m_axis_tdata_reg[31]_i_2\ : label is 35;
  attribute ADDER_THRESHOLD of \m_axis_tdata_reg[8]_i_1\ : label is 35;
  attribute COMPARATOR_THRESHOLD : integer;
  attribute COMPARATOR_THRESHOLD of out_count2_carry : label is 11;
  attribute COMPARATOR_THRESHOLD of \out_count2_carry__0\ : label is 11;
begin
  led <= \^led\;
\handle_ramp.out_count[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1EEE"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[0]\,
      I1 => \out_count1__62\,
      I2 => out_count21_in,
      I3 => m_axis_tready,
      O => p_0_in(0)
    );
\handle_ramp.out_count[10]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(10),
      I1 => \handle_ramp.out_count_reg_n_0_[10]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(10)
    );
\handle_ramp.out_count[11]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(11),
      I1 => \handle_ramp.out_count_reg_n_0_[11]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(11)
    );
\handle_ramp.out_count[12]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(12),
      I1 => \handle_ramp.out_count_reg_n_0_[12]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(12)
    );
\handle_ramp.out_count[13]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(13),
      I1 => \handle_ramp.out_count_reg_n_0_[13]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(13)
    );
\handle_ramp.out_count[14]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(14),
      I1 => \handle_ramp.out_count_reg_n_0_[14]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(14)
    );
\handle_ramp.out_count[15]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(15),
      I1 => \handle_ramp.out_count_reg_n_0_[15]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(15)
    );
\handle_ramp.out_count[16]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(16),
      I1 => \handle_ramp.out_count_reg_n_0_[16]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(16)
    );
\handle_ramp.out_count[17]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(17),
      I1 => \handle_ramp.out_count_reg_n_0_[17]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(17)
    );
\handle_ramp.out_count[18]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(18),
      I1 => \handle_ramp.out_count_reg_n_0_[18]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(18)
    );
\handle_ramp.out_count[19]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(19),
      I1 => \handle_ramp.out_count_reg_n_0_[19]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(19)
    );
\handle_ramp.out_count[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(1),
      I1 => \handle_ramp.out_count_reg_n_0_[1]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(1)
    );
\handle_ramp.out_count[20]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(20),
      I1 => \handle_ramp.out_count_reg_n_0_[20]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(20)
    );
\handle_ramp.out_count[21]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(21),
      I1 => \handle_ramp.out_count_reg_n_0_[21]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(21)
    );
\handle_ramp.out_count[22]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(22),
      I1 => \handle_ramp.out_count_reg_n_0_[22]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(22)
    );
\handle_ramp.out_count[23]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(23),
      I1 => \handle_ramp.out_count_reg_n_0_[23]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(23)
    );
\handle_ramp.out_count[24]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(24),
      I1 => \handle_ramp.out_count_reg_n_0_[24]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(24)
    );
\handle_ramp.out_count[25]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(25),
      I1 => \handle_ramp.out_count_reg_n_0_[25]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(25)
    );
\handle_ramp.out_count[26]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(26),
      I1 => \handle_ramp.out_count_reg_n_0_[26]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(26)
    );
\handle_ramp.out_count[27]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(27),
      I1 => \handle_ramp.out_count_reg_n_0_[27]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(27)
    );
\handle_ramp.out_count[28]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(28),
      I1 => \handle_ramp.out_count_reg_n_0_[28]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(28)
    );
\handle_ramp.out_count[29]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(29),
      I1 => \handle_ramp.out_count_reg_n_0_[29]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(29)
    );
\handle_ramp.out_count[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(2),
      I1 => \handle_ramp.out_count_reg_n_0_[2]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(2)
    );
\handle_ramp.out_count[30]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(30),
      I1 => \handle_ramp.out_count_reg_n_0_[30]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(30)
    );
\handle_ramp.out_count[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(31),
      I1 => \handle_ramp.out_count_reg_n_0_[31]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(31)
    );
\handle_ramp.out_count[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(3),
      I1 => \handle_ramp.out_count_reg_n_0_[3]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(3)
    );
\handle_ramp.out_count[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(4),
      I1 => \handle_ramp.out_count_reg_n_0_[4]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(4)
    );
\handle_ramp.out_count[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(5),
      I1 => \handle_ramp.out_count_reg_n_0_[5]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(5)
    );
\handle_ramp.out_count[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(6),
      I1 => \handle_ramp.out_count_reg_n_0_[6]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(6)
    );
\handle_ramp.out_count[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(7),
      I1 => \handle_ramp.out_count_reg_n_0_[7]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(7)
    );
\handle_ramp.out_count[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(8),
      I1 => \handle_ramp.out_count_reg_n_0_[8]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(8)
    );
\handle_ramp.out_count[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAFCFCFC"
    )
        port map (
      I0 => out_count0(9),
      I1 => \handle_ramp.out_count_reg_n_0_[9]\,
      I2 => \out_count1__62\,
      I3 => out_count21_in,
      I4 => m_axis_tready,
      O => p_0_in(9)
    );
\handle_ramp.out_count_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(0),
      Q => \handle_ramp.out_count_reg_n_0_[0]\,
      R => '0'
    );
\handle_ramp.out_count_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(10),
      Q => \handle_ramp.out_count_reg_n_0_[10]\,
      R => '0'
    );
\handle_ramp.out_count_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(11),
      Q => \handle_ramp.out_count_reg_n_0_[11]\,
      R => '0'
    );
\handle_ramp.out_count_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(12),
      Q => \handle_ramp.out_count_reg_n_0_[12]\,
      R => '0'
    );
\handle_ramp.out_count_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(13),
      Q => \handle_ramp.out_count_reg_n_0_[13]\,
      R => '0'
    );
\handle_ramp.out_count_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(14),
      Q => \handle_ramp.out_count_reg_n_0_[14]\,
      R => '0'
    );
\handle_ramp.out_count_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(15),
      Q => \handle_ramp.out_count_reg_n_0_[15]\,
      R => '0'
    );
\handle_ramp.out_count_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(16),
      Q => \handle_ramp.out_count_reg_n_0_[16]\,
      R => '0'
    );
\handle_ramp.out_count_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(17),
      Q => \handle_ramp.out_count_reg_n_0_[17]\,
      R => '0'
    );
\handle_ramp.out_count_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(18),
      Q => \handle_ramp.out_count_reg_n_0_[18]\,
      R => '0'
    );
\handle_ramp.out_count_reg[19]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(19),
      Q => \handle_ramp.out_count_reg_n_0_[19]\,
      R => '0'
    );
\handle_ramp.out_count_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(1),
      Q => \handle_ramp.out_count_reg_n_0_[1]\,
      R => '0'
    );
\handle_ramp.out_count_reg[20]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(20),
      Q => \handle_ramp.out_count_reg_n_0_[20]\,
      R => '0'
    );
\handle_ramp.out_count_reg[21]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(21),
      Q => \handle_ramp.out_count_reg_n_0_[21]\,
      R => '0'
    );
\handle_ramp.out_count_reg[22]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(22),
      Q => \handle_ramp.out_count_reg_n_0_[22]\,
      R => '0'
    );
\handle_ramp.out_count_reg[23]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(23),
      Q => \handle_ramp.out_count_reg_n_0_[23]\,
      R => '0'
    );
\handle_ramp.out_count_reg[24]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(24),
      Q => \handle_ramp.out_count_reg_n_0_[24]\,
      R => '0'
    );
\handle_ramp.out_count_reg[25]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(25),
      Q => \handle_ramp.out_count_reg_n_0_[25]\,
      R => '0'
    );
\handle_ramp.out_count_reg[26]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(26),
      Q => \handle_ramp.out_count_reg_n_0_[26]\,
      R => '0'
    );
\handle_ramp.out_count_reg[27]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(27),
      Q => \handle_ramp.out_count_reg_n_0_[27]\,
      R => '0'
    );
\handle_ramp.out_count_reg[28]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(28),
      Q => \handle_ramp.out_count_reg_n_0_[28]\,
      R => '0'
    );
\handle_ramp.out_count_reg[29]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(29),
      Q => \handle_ramp.out_count_reg_n_0_[29]\,
      R => '0'
    );
\handle_ramp.out_count_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(2),
      Q => \handle_ramp.out_count_reg_n_0_[2]\,
      R => '0'
    );
\handle_ramp.out_count_reg[30]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(30),
      Q => \handle_ramp.out_count_reg_n_0_[30]\,
      R => '0'
    );
\handle_ramp.out_count_reg[31]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(31),
      Q => \handle_ramp.out_count_reg_n_0_[31]\,
      R => '0'
    );
\handle_ramp.out_count_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(3),
      Q => \handle_ramp.out_count_reg_n_0_[3]\,
      R => '0'
    );
\handle_ramp.out_count_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(4),
      Q => \handle_ramp.out_count_reg_n_0_[4]\,
      R => '0'
    );
\handle_ramp.out_count_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(5),
      Q => \handle_ramp.out_count_reg_n_0_[5]\,
      R => '0'
    );
\handle_ramp.out_count_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(6),
      Q => \handle_ramp.out_count_reg_n_0_[6]\,
      R => '0'
    );
\handle_ramp.out_count_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(7),
      Q => \handle_ramp.out_count_reg_n_0_[7]\,
      R => '0'
    );
\handle_ramp.out_count_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(8),
      Q => \handle_ramp.out_count_reg_n_0_[8]\,
      R => '0'
    );
\handle_ramp.out_count_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => p_0_in(9),
      Q => \handle_ramp.out_count_reg_n_0_[9]\,
      R => '0'
    );
led_out_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \^led\,
      I1 => \out_count1__62\,
      O => led_out_i_1_n_0
    );
led_out_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => aclk,
      CE => '1',
      D => led_out_i_1_n_0,
      Q => \^led\,
      R => '0'
    );
\m_axis_tdata[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[0]\,
      O => out_count0(0)
    );
\m_axis_tdata[0]_i_10\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => prev_reg(2),
      I1 => prev_reg(3),
      I2 => prev_reg(0),
      I3 => prev_reg(1),
      O => \m_axis_tdata[0]_i_10_n_0\
    );
\m_axis_tdata[0]_i_11\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => prev_reg(26),
      I1 => prev_reg(27),
      I2 => prev_reg(24),
      I3 => prev_reg(25),
      O => \m_axis_tdata[0]_i_11_n_0\
    );
\m_axis_tdata[0]_i_12\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => prev_reg(18),
      I1 => prev_reg(19),
      I2 => prev_reg(16),
      I3 => prev_reg(17),
      O => \m_axis_tdata[0]_i_12_n_0\
    );
\m_axis_tdata[0]_i_13\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => cfg_reg(10),
      I1 => cfg_reg(11),
      I2 => cfg_reg(8),
      I3 => cfg_reg(9),
      O => \m_axis_tdata[0]_i_13_n_0\
    );
\m_axis_tdata[0]_i_14\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => cfg_reg(14),
      I1 => cfg_reg(15),
      I2 => cfg_reg(12),
      I3 => cfg_reg(13),
      O => \m_axis_tdata[0]_i_14_n_0\
    );
\m_axis_tdata[0]_i_15\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => cfg_reg(2),
      I1 => cfg_reg(3),
      I2 => cfg_reg(0),
      I3 => cfg_reg(1),
      O => \m_axis_tdata[0]_i_15_n_0\
    );
\m_axis_tdata[0]_i_16\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => cfg_reg(6),
      I1 => cfg_reg(7),
      I2 => cfg_reg(4),
      I3 => cfg_reg(5),
      O => \m_axis_tdata[0]_i_16_n_0\
    );
\m_axis_tdata[0]_i_17\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => cfg_reg(26),
      I1 => cfg_reg(27),
      I2 => cfg_reg(24),
      I3 => cfg_reg(25),
      O => \m_axis_tdata[0]_i_17_n_0\
    );
\m_axis_tdata[0]_i_18\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => cfg_reg(31),
      I1 => cfg_reg(30),
      I2 => cfg_reg(28),
      I3 => cfg_reg(29),
      O => \m_axis_tdata[0]_i_18_n_0\
    );
\m_axis_tdata[0]_i_19\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => cfg_reg(18),
      I1 => cfg_reg(19),
      I2 => cfg_reg(16),
      I3 => cfg_reg(17),
      O => \m_axis_tdata[0]_i_19_n_0\
    );
\m_axis_tdata[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000000001"
    )
        port map (
      I0 => \m_axis_tdata[0]_i_3_n_0\,
      I1 => \m_axis_tdata[0]_i_4_n_0\,
      I2 => \m_axis_tdata[0]_i_5_n_0\,
      I3 => \m_axis_tdata[0]_i_6_n_0\,
      I4 => \m_axis_tdata[0]_i_7_n_0\,
      I5 => \m_axis_tdata[0]_i_8_n_0\,
      O => \out_count1__62\
    );
\m_axis_tdata[0]_i_20\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => cfg_reg(22),
      I1 => cfg_reg(23),
      I2 => cfg_reg(20),
      I3 => cfg_reg(21),
      O => \m_axis_tdata[0]_i_20_n_0\
    );
\m_axis_tdata[0]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => prev_reg(13),
      I1 => prev_reg(12),
      I2 => prev_reg(15),
      I3 => prev_reg(14),
      I4 => \m_axis_tdata[0]_i_9_n_0\,
      O => \m_axis_tdata[0]_i_3_n_0\
    );
\m_axis_tdata[0]_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => prev_reg(5),
      I1 => prev_reg(4),
      I2 => prev_reg(7),
      I3 => prev_reg(6),
      I4 => \m_axis_tdata[0]_i_10_n_0\,
      O => \m_axis_tdata[0]_i_4_n_0\
    );
\m_axis_tdata[0]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => prev_reg(29),
      I1 => prev_reg(28),
      I2 => prev_reg(30),
      I3 => prev_reg(31),
      I4 => \m_axis_tdata[0]_i_11_n_0\,
      O => \m_axis_tdata[0]_i_5_n_0\
    );
\m_axis_tdata[0]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => prev_reg(21),
      I1 => prev_reg(20),
      I2 => prev_reg(23),
      I3 => prev_reg(22),
      I4 => \m_axis_tdata[0]_i_12_n_0\,
      O => \m_axis_tdata[0]_i_6_n_0\
    );
\m_axis_tdata[0]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \m_axis_tdata[0]_i_13_n_0\,
      I1 => \m_axis_tdata[0]_i_14_n_0\,
      I2 => \m_axis_tdata[0]_i_15_n_0\,
      I3 => \m_axis_tdata[0]_i_16_n_0\,
      O => \m_axis_tdata[0]_i_7_n_0\
    );
\m_axis_tdata[0]_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \m_axis_tdata[0]_i_17_n_0\,
      I1 => \m_axis_tdata[0]_i_18_n_0\,
      I2 => \m_axis_tdata[0]_i_19_n_0\,
      I3 => \m_axis_tdata[0]_i_20_n_0\,
      O => \m_axis_tdata[0]_i_8_n_0\
    );
\m_axis_tdata[0]_i_9\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => prev_reg(10),
      I1 => prev_reg(11),
      I2 => prev_reg(8),
      I3 => prev_reg(9),
      O => \m_axis_tdata[0]_i_9_n_0\
    );
\m_axis_tdata[16]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[16]\,
      O => \m_axis_tdata[16]_i_2_n_0\
    );
\m_axis_tdata[16]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[15]\,
      O => \m_axis_tdata[16]_i_3_n_0\
    );
\m_axis_tdata[16]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[14]\,
      O => \m_axis_tdata[16]_i_4_n_0\
    );
\m_axis_tdata[16]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[13]\,
      O => \m_axis_tdata[16]_i_5_n_0\
    );
\m_axis_tdata[16]_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[12]\,
      O => \m_axis_tdata[16]_i_6_n_0\
    );
\m_axis_tdata[16]_i_7\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[11]\,
      O => \m_axis_tdata[16]_i_7_n_0\
    );
\m_axis_tdata[16]_i_8\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[10]\,
      O => \m_axis_tdata[16]_i_8_n_0\
    );
\m_axis_tdata[16]_i_9\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[9]\,
      O => \m_axis_tdata[16]_i_9_n_0\
    );
\m_axis_tdata[24]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[24]\,
      O => \m_axis_tdata[24]_i_2_n_0\
    );
\m_axis_tdata[24]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[23]\,
      O => \m_axis_tdata[24]_i_3_n_0\
    );
\m_axis_tdata[24]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[22]\,
      O => \m_axis_tdata[24]_i_4_n_0\
    );
\m_axis_tdata[24]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[21]\,
      O => \m_axis_tdata[24]_i_5_n_0\
    );
\m_axis_tdata[24]_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[20]\,
      O => \m_axis_tdata[24]_i_6_n_0\
    );
\m_axis_tdata[24]_i_7\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[19]\,
      O => \m_axis_tdata[24]_i_7_n_0\
    );
\m_axis_tdata[24]_i_8\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[18]\,
      O => \m_axis_tdata[24]_i_8_n_0\
    );
\m_axis_tdata[24]_i_9\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[17]\,
      O => \m_axis_tdata[24]_i_9_n_0\
    );
\m_axis_tdata[31]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => out_count21_in,
      I1 => m_axis_tready,
      O => out_count12_out
    );
\m_axis_tdata[31]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[31]\,
      O => \m_axis_tdata[31]_i_3_n_0\
    );
\m_axis_tdata[31]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[30]\,
      O => \m_axis_tdata[31]_i_4_n_0\
    );
\m_axis_tdata[31]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[29]\,
      O => \m_axis_tdata[31]_i_5_n_0\
    );
\m_axis_tdata[31]_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[28]\,
      O => \m_axis_tdata[31]_i_6_n_0\
    );
\m_axis_tdata[31]_i_7\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[27]\,
      O => \m_axis_tdata[31]_i_7_n_0\
    );
\m_axis_tdata[31]_i_8\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[26]\,
      O => \m_axis_tdata[31]_i_8_n_0\
    );
\m_axis_tdata[31]_i_9\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[25]\,
      O => \m_axis_tdata[31]_i_9_n_0\
    );
\m_axis_tdata[8]_i_10\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[1]\,
      O => \m_axis_tdata[8]_i_10_n_0\
    );
\m_axis_tdata[8]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[0]\,
      I1 => \out_count1__62\,
      O => out_count(0)
    );
\m_axis_tdata[8]_i_3\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[8]\,
      O => \m_axis_tdata[8]_i_3_n_0\
    );
\m_axis_tdata[8]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[7]\,
      O => \m_axis_tdata[8]_i_4_n_0\
    );
\m_axis_tdata[8]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[6]\,
      O => \m_axis_tdata[8]_i_5_n_0\
    );
\m_axis_tdata[8]_i_6\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[5]\,
      O => \m_axis_tdata[8]_i_6_n_0\
    );
\m_axis_tdata[8]_i_7\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[4]\,
      O => \m_axis_tdata[8]_i_7_n_0\
    );
\m_axis_tdata[8]_i_8\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[3]\,
      O => \m_axis_tdata[8]_i_8_n_0\
    );
\m_axis_tdata[8]_i_9\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \out_count1__62\,
      I1 => \handle_ramp.out_count_reg_n_0_[2]\,
      O => \m_axis_tdata[8]_i_9_n_0\
    );
\m_axis_tdata_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(0),
      Q => m_axis_tdata(0),
      R => '0'
    );
\m_axis_tdata_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(10),
      Q => m_axis_tdata(10),
      R => '0'
    );
\m_axis_tdata_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(11),
      Q => m_axis_tdata(11),
      R => '0'
    );
\m_axis_tdata_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(12),
      Q => m_axis_tdata(12),
      R => '0'
    );
\m_axis_tdata_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(13),
      Q => m_axis_tdata(13),
      R => '0'
    );
\m_axis_tdata_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(14),
      Q => m_axis_tdata(14),
      R => '0'
    );
\m_axis_tdata_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(15),
      Q => m_axis_tdata(15),
      R => '0'
    );
\m_axis_tdata_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(16),
      Q => m_axis_tdata(16),
      R => '0'
    );
\m_axis_tdata_reg[16]_i_1\: unisim.vcomponents.CARRY8
     port map (
      CI => \m_axis_tdata_reg[8]_i_1_n_0\,
      CI_TOP => '0',
      CO(7) => \m_axis_tdata_reg[16]_i_1_n_0\,
      CO(6) => \m_axis_tdata_reg[16]_i_1_n_1\,
      CO(5) => \m_axis_tdata_reg[16]_i_1_n_2\,
      CO(4) => \m_axis_tdata_reg[16]_i_1_n_3\,
      CO(3) => \m_axis_tdata_reg[16]_i_1_n_4\,
      CO(2) => \m_axis_tdata_reg[16]_i_1_n_5\,
      CO(1) => \m_axis_tdata_reg[16]_i_1_n_6\,
      CO(0) => \m_axis_tdata_reg[16]_i_1_n_7\,
      DI(7 downto 0) => B"11111111",
      O(7 downto 0) => out_count0(16 downto 9),
      S(7) => \m_axis_tdata[16]_i_2_n_0\,
      S(6) => \m_axis_tdata[16]_i_3_n_0\,
      S(5) => \m_axis_tdata[16]_i_4_n_0\,
      S(4) => \m_axis_tdata[16]_i_5_n_0\,
      S(3) => \m_axis_tdata[16]_i_6_n_0\,
      S(2) => \m_axis_tdata[16]_i_7_n_0\,
      S(1) => \m_axis_tdata[16]_i_8_n_0\,
      S(0) => \m_axis_tdata[16]_i_9_n_0\
    );
\m_axis_tdata_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(17),
      Q => m_axis_tdata(17),
      R => '0'
    );
\m_axis_tdata_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(18),
      Q => m_axis_tdata(18),
      R => '0'
    );
\m_axis_tdata_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(19),
      Q => m_axis_tdata(19),
      R => '0'
    );
\m_axis_tdata_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(1),
      Q => m_axis_tdata(1),
      R => '0'
    );
\m_axis_tdata_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(20),
      Q => m_axis_tdata(20),
      R => '0'
    );
\m_axis_tdata_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(21),
      Q => m_axis_tdata(21),
      R => '0'
    );
\m_axis_tdata_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(22),
      Q => m_axis_tdata(22),
      R => '0'
    );
\m_axis_tdata_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(23),
      Q => m_axis_tdata(23),
      R => '0'
    );
\m_axis_tdata_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(24),
      Q => m_axis_tdata(24),
      R => '0'
    );
\m_axis_tdata_reg[24]_i_1\: unisim.vcomponents.CARRY8
     port map (
      CI => \m_axis_tdata_reg[16]_i_1_n_0\,
      CI_TOP => '0',
      CO(7) => \m_axis_tdata_reg[24]_i_1_n_0\,
      CO(6) => \m_axis_tdata_reg[24]_i_1_n_1\,
      CO(5) => \m_axis_tdata_reg[24]_i_1_n_2\,
      CO(4) => \m_axis_tdata_reg[24]_i_1_n_3\,
      CO(3) => \m_axis_tdata_reg[24]_i_1_n_4\,
      CO(2) => \m_axis_tdata_reg[24]_i_1_n_5\,
      CO(1) => \m_axis_tdata_reg[24]_i_1_n_6\,
      CO(0) => \m_axis_tdata_reg[24]_i_1_n_7\,
      DI(7 downto 0) => B"11111111",
      O(7 downto 0) => out_count0(24 downto 17),
      S(7) => \m_axis_tdata[24]_i_2_n_0\,
      S(6) => \m_axis_tdata[24]_i_3_n_0\,
      S(5) => \m_axis_tdata[24]_i_4_n_0\,
      S(4) => \m_axis_tdata[24]_i_5_n_0\,
      S(3) => \m_axis_tdata[24]_i_6_n_0\,
      S(2) => \m_axis_tdata[24]_i_7_n_0\,
      S(1) => \m_axis_tdata[24]_i_8_n_0\,
      S(0) => \m_axis_tdata[24]_i_9_n_0\
    );
\m_axis_tdata_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(25),
      Q => m_axis_tdata(25),
      R => '0'
    );
\m_axis_tdata_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(26),
      Q => m_axis_tdata(26),
      R => '0'
    );
\m_axis_tdata_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(27),
      Q => m_axis_tdata(27),
      R => '0'
    );
\m_axis_tdata_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(28),
      Q => m_axis_tdata(28),
      R => '0'
    );
\m_axis_tdata_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(29),
      Q => m_axis_tdata(29),
      R => '0'
    );
\m_axis_tdata_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(2),
      Q => m_axis_tdata(2),
      R => '0'
    );
\m_axis_tdata_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(30),
      Q => m_axis_tdata(30),
      R => '0'
    );
\m_axis_tdata_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(31),
      Q => m_axis_tdata(31),
      R => '0'
    );
\m_axis_tdata_reg[31]_i_2\: unisim.vcomponents.CARRY8
     port map (
      CI => \m_axis_tdata_reg[24]_i_1_n_0\,
      CI_TOP => '0',
      CO(7 downto 6) => \NLW_m_axis_tdata_reg[31]_i_2_CO_UNCONNECTED\(7 downto 6),
      CO(5) => \m_axis_tdata_reg[31]_i_2_n_2\,
      CO(4) => \m_axis_tdata_reg[31]_i_2_n_3\,
      CO(3) => \m_axis_tdata_reg[31]_i_2_n_4\,
      CO(2) => \m_axis_tdata_reg[31]_i_2_n_5\,
      CO(1) => \m_axis_tdata_reg[31]_i_2_n_6\,
      CO(0) => \m_axis_tdata_reg[31]_i_2_n_7\,
      DI(7 downto 0) => B"00111111",
      O(7) => \NLW_m_axis_tdata_reg[31]_i_2_O_UNCONNECTED\(7),
      O(6 downto 0) => out_count0(31 downto 25),
      S(7) => '0',
      S(6) => \m_axis_tdata[31]_i_3_n_0\,
      S(5) => \m_axis_tdata[31]_i_4_n_0\,
      S(4) => \m_axis_tdata[31]_i_5_n_0\,
      S(3) => \m_axis_tdata[31]_i_6_n_0\,
      S(2) => \m_axis_tdata[31]_i_7_n_0\,
      S(1) => \m_axis_tdata[31]_i_8_n_0\,
      S(0) => \m_axis_tdata[31]_i_9_n_0\
    );
\m_axis_tdata_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(3),
      Q => m_axis_tdata(3),
      R => '0'
    );
\m_axis_tdata_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(4),
      Q => m_axis_tdata(4),
      R => '0'
    );
\m_axis_tdata_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(5),
      Q => m_axis_tdata(5),
      R => '0'
    );
\m_axis_tdata_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(6),
      Q => m_axis_tdata(6),
      R => '0'
    );
\m_axis_tdata_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(7),
      Q => m_axis_tdata(7),
      R => '0'
    );
\m_axis_tdata_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(8),
      Q => m_axis_tdata(8),
      R => '0'
    );
\m_axis_tdata_reg[8]_i_1\: unisim.vcomponents.CARRY8
     port map (
      CI => out_count(0),
      CI_TOP => '0',
      CO(7) => \m_axis_tdata_reg[8]_i_1_n_0\,
      CO(6) => \m_axis_tdata_reg[8]_i_1_n_1\,
      CO(5) => \m_axis_tdata_reg[8]_i_1_n_2\,
      CO(4) => \m_axis_tdata_reg[8]_i_1_n_3\,
      CO(3) => \m_axis_tdata_reg[8]_i_1_n_4\,
      CO(2) => \m_axis_tdata_reg[8]_i_1_n_5\,
      CO(1) => \m_axis_tdata_reg[8]_i_1_n_6\,
      CO(0) => \m_axis_tdata_reg[8]_i_1_n_7\,
      DI(7 downto 0) => B"11111111",
      O(7 downto 0) => out_count0(8 downto 1),
      S(7) => \m_axis_tdata[8]_i_3_n_0\,
      S(6) => \m_axis_tdata[8]_i_4_n_0\,
      S(5) => \m_axis_tdata[8]_i_5_n_0\,
      S(4) => \m_axis_tdata[8]_i_6_n_0\,
      S(3) => \m_axis_tdata[8]_i_7_n_0\,
      S(2) => \m_axis_tdata[8]_i_8_n_0\,
      S(1) => \m_axis_tdata[8]_i_9_n_0\,
      S(0) => \m_axis_tdata[8]_i_10_n_0\
    );
\m_axis_tdata_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => out_count12_out,
      D => out_count0(9),
      Q => m_axis_tdata(9),
      R => '0'
    );
m_axis_tvalid_reg: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => out_count12_out,
      Q => m_axis_tlast,
      R => '0'
    );
out_count2_carry: unisim.vcomponents.CARRY8
     port map (
      CI => '0',
      CI_TOP => '0',
      CO(7) => out_count2_carry_n_0,
      CO(6) => out_count2_carry_n_1,
      CO(5) => out_count2_carry_n_2,
      CO(4) => out_count2_carry_n_3,
      CO(3) => out_count2_carry_n_4,
      CO(2) => out_count2_carry_n_5,
      CO(1) => out_count2_carry_n_6,
      CO(0) => out_count2_carry_n_7,
      DI(7) => out_count2_carry_i_1_n_0,
      DI(6) => out_count2_carry_i_2_n_0,
      DI(5) => out_count2_carry_i_3_n_0,
      DI(4) => out_count2_carry_i_4_n_0,
      DI(3) => out_count2_carry_i_5_n_0,
      DI(2) => out_count2_carry_i_6_n_0,
      DI(1) => out_count2_carry_i_7_n_0,
      DI(0) => out_count2_carry_i_8_n_0,
      O(7 downto 0) => NLW_out_count2_carry_O_UNCONNECTED(7 downto 0),
      S(7) => out_count2_carry_i_9_n_0,
      S(6) => out_count2_carry_i_10_n_0,
      S(5) => out_count2_carry_i_11_n_0,
      S(4) => out_count2_carry_i_12_n_0,
      S(3) => out_count2_carry_i_13_n_0,
      S(2) => out_count2_carry_i_14_n_0,
      S(1) => out_count2_carry_i_15_n_0,
      S(0) => out_count2_carry_i_16_n_0
    );
\out_count2_carry__0\: unisim.vcomponents.CARRY8
     port map (
      CI => out_count2_carry_n_0,
      CI_TOP => '0',
      CO(7) => out_count21_in,
      CO(6) => \out_count2_carry__0_n_1\,
      CO(5) => \out_count2_carry__0_n_2\,
      CO(4) => \out_count2_carry__0_n_3\,
      CO(3) => \out_count2_carry__0_n_4\,
      CO(2) => \out_count2_carry__0_n_5\,
      CO(1) => \out_count2_carry__0_n_6\,
      CO(0) => \out_count2_carry__0_n_7\,
      DI(7) => \out_count2_carry__0_i_1_n_0\,
      DI(6) => \out_count2_carry__0_i_2_n_0\,
      DI(5) => \out_count2_carry__0_i_3_n_0\,
      DI(4) => \out_count2_carry__0_i_4_n_0\,
      DI(3) => \out_count2_carry__0_i_5_n_0\,
      DI(2) => \out_count2_carry__0_i_6_n_0\,
      DI(1) => \out_count2_carry__0_i_7_n_0\,
      DI(0) => \out_count2_carry__0_i_8_n_0\,
      O(7 downto 0) => \NLW_out_count2_carry__0_O_UNCONNECTED\(7 downto 0),
      S(7) => \out_count2_carry__0_i_9_n_0\,
      S(6) => \out_count2_carry__0_i_10_n_0\,
      S(5) => \out_count2_carry__0_i_11_n_0\,
      S(4) => \out_count2_carry__0_i_12_n_0\,
      S(3) => \out_count2_carry__0_i_13_n_0\,
      S(2) => \out_count2_carry__0_i_14_n_0\,
      S(1) => \out_count2_carry__0_i_15_n_0\,
      S(0) => \out_count2_carry__0_i_16_n_0\
    );
\out_count2_carry__0_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"02"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[30]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[31]\,
      O => \out_count2_carry__0_i_1_n_0\
    );
\out_count2_carry__0_i_10\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[28]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[29]\,
      O => \out_count2_carry__0_i_10_n_0\
    );
\out_count2_carry__0_i_11\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[26]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[27]\,
      O => \out_count2_carry__0_i_11_n_0\
    );
\out_count2_carry__0_i_12\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[24]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[25]\,
      O => \out_count2_carry__0_i_12_n_0\
    );
\out_count2_carry__0_i_13\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[22]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[23]\,
      O => \out_count2_carry__0_i_13_n_0\
    );
\out_count2_carry__0_i_14\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[20]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[21]\,
      O => \out_count2_carry__0_i_14_n_0\
    );
\out_count2_carry__0_i_15\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[18]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[19]\,
      O => \out_count2_carry__0_i_15_n_0\
    );
\out_count2_carry__0_i_16\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[16]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[17]\,
      O => \out_count2_carry__0_i_16_n_0\
    );
\out_count2_carry__0_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[28]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[29]\,
      O => \out_count2_carry__0_i_2_n_0\
    );
\out_count2_carry__0_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[26]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[27]\,
      O => \out_count2_carry__0_i_3_n_0\
    );
\out_count2_carry__0_i_4\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[24]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[25]\,
      O => \out_count2_carry__0_i_4_n_0\
    );
\out_count2_carry__0_i_5\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[22]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[23]\,
      O => \out_count2_carry__0_i_5_n_0\
    );
\out_count2_carry__0_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[20]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[21]\,
      O => \out_count2_carry__0_i_6_n_0\
    );
\out_count2_carry__0_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[18]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[19]\,
      O => \out_count2_carry__0_i_7_n_0\
    );
\out_count2_carry__0_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[16]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[17]\,
      O => \out_count2_carry__0_i_8_n_0\
    );
\out_count2_carry__0_i_9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[30]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[31]\,
      O => \out_count2_carry__0_i_9_n_0\
    );
out_count2_carry_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[14]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[15]\,
      O => out_count2_carry_i_1_n_0
    );
out_count2_carry_i_10: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[12]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[13]\,
      O => out_count2_carry_i_10_n_0
    );
out_count2_carry_i_11: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[10]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[11]\,
      O => out_count2_carry_i_11_n_0
    );
out_count2_carry_i_12: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[8]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[9]\,
      O => out_count2_carry_i_12_n_0
    );
out_count2_carry_i_13: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[6]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[7]\,
      O => out_count2_carry_i_13_n_0
    );
out_count2_carry_i_14: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[4]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[5]\,
      O => out_count2_carry_i_14_n_0
    );
out_count2_carry_i_15: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[2]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[3]\,
      O => out_count2_carry_i_15_n_0
    );
out_count2_carry_i_16: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[0]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[1]\,
      O => out_count2_carry_i_16_n_0
    );
out_count2_carry_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[12]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[13]\,
      O => out_count2_carry_i_2_n_0
    );
out_count2_carry_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[10]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[11]\,
      O => out_count2_carry_i_3_n_0
    );
out_count2_carry_i_4: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[8]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[9]\,
      O => out_count2_carry_i_4_n_0
    );
out_count2_carry_i_5: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[6]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[7]\,
      O => out_count2_carry_i_5_n_0
    );
out_count2_carry_i_6: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[4]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[5]\,
      O => out_count2_carry_i_6_n_0
    );
out_count2_carry_i_7: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[2]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[3]\,
      O => out_count2_carry_i_7_n_0
    );
out_count2_carry_i_8: unisim.vcomponents.LUT3
    generic map(
      INIT => X"FE"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[0]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[1]\,
      O => out_count2_carry_i_8_n_0
    );
out_count2_carry_i_9: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \handle_ramp.out_count_reg_n_0_[14]\,
      I1 => \out_count1__62\,
      I2 => \handle_ramp.out_count_reg_n_0_[15]\,
      O => out_count2_carry_i_9_n_0
    );
\prev_reg_reg[0]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(0),
      Q => prev_reg(0),
      R => '0'
    );
\prev_reg_reg[10]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(10),
      Q => prev_reg(10),
      R => '0'
    );
\prev_reg_reg[11]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(11),
      Q => prev_reg(11),
      R => '0'
    );
\prev_reg_reg[12]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(12),
      Q => prev_reg(12),
      R => '0'
    );
\prev_reg_reg[13]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(13),
      Q => prev_reg(13),
      R => '0'
    );
\prev_reg_reg[14]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(14),
      Q => prev_reg(14),
      R => '0'
    );
\prev_reg_reg[15]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(15),
      Q => prev_reg(15),
      R => '0'
    );
\prev_reg_reg[16]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(16),
      Q => prev_reg(16),
      R => '0'
    );
\prev_reg_reg[17]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(17),
      Q => prev_reg(17),
      R => '0'
    );
\prev_reg_reg[18]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(18),
      Q => prev_reg(18),
      R => '0'
    );
\prev_reg_reg[19]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(19),
      Q => prev_reg(19),
      R => '0'
    );
\prev_reg_reg[1]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(1),
      Q => prev_reg(1),
      R => '0'
    );
\prev_reg_reg[20]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(20),
      Q => prev_reg(20),
      R => '0'
    );
\prev_reg_reg[21]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(21),
      Q => prev_reg(21),
      R => '0'
    );
\prev_reg_reg[22]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(22),
      Q => prev_reg(22),
      R => '0'
    );
\prev_reg_reg[23]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(23),
      Q => prev_reg(23),
      R => '0'
    );
\prev_reg_reg[24]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(24),
      Q => prev_reg(24),
      R => '0'
    );
\prev_reg_reg[25]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(25),
      Q => prev_reg(25),
      R => '0'
    );
\prev_reg_reg[26]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(26),
      Q => prev_reg(26),
      R => '0'
    );
\prev_reg_reg[27]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(27),
      Q => prev_reg(27),
      R => '0'
    );
\prev_reg_reg[28]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(28),
      Q => prev_reg(28),
      R => '0'
    );
\prev_reg_reg[29]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(29),
      Q => prev_reg(29),
      R => '0'
    );
\prev_reg_reg[2]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(2),
      Q => prev_reg(2),
      R => '0'
    );
\prev_reg_reg[30]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(30),
      Q => prev_reg(30),
      R => '0'
    );
\prev_reg_reg[31]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(31),
      Q => prev_reg(31),
      R => '0'
    );
\prev_reg_reg[3]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(3),
      Q => prev_reg(3),
      R => '0'
    );
\prev_reg_reg[4]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(4),
      Q => prev_reg(4),
      R => '0'
    );
\prev_reg_reg[5]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(5),
      Q => prev_reg(5),
      R => '0'
    );
\prev_reg_reg[6]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(6),
      Q => prev_reg(6),
      R => '0'
    );
\prev_reg_reg[7]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(7),
      Q => prev_reg(7),
      R => '0'
    );
\prev_reg_reg[8]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(8),
      Q => prev_reg(8),
      R => '0'
    );
\prev_reg_reg[9]\: unisim.vcomponents.FDRE
     port map (
      C => aclk,
      CE => '1',
      D => cfg_reg(9),
      Q => prev_reg(9),
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_rampgen_0_0 is
  port (
    aclk : in STD_LOGIC;
    cfg_reg : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axis_tvalid : out STD_LOGIC;
    m_axis_tready : in STD_LOGIC;
    m_axis_tlast : out STD_LOGIC;
    led : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_rampgen_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_rampgen_0_0 : entity is "design_1_rampgen_0_0,rampgen,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of design_1_rampgen_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of design_1_rampgen_0_0 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of design_1_rampgen_0_0 : entity is "rampgen,Vivado 2024.1";
end design_1_rampgen_0_0;

architecture STRUCTURE of design_1_rampgen_0_0 is
  signal \^m_axis_tlast\ : STD_LOGIC;
  attribute x_interface_info : string;
  attribute x_interface_info of aclk : signal is "xilinx.com:signal:clock:1.0 aclk CLK";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of aclk : signal is "XIL_INTERFACENAME aclk, ASSOCIATED_BUSIF m_axis, FREQ_HZ 99999001, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, INSERT_VIP 0";
  attribute x_interface_info of m_axis_tlast : signal is "xilinx.com:interface:axis:1.0 m_axis TLAST";
  attribute x_interface_info of m_axis_tready : signal is "xilinx.com:interface:axis:1.0 m_axis TREADY";
  attribute x_interface_info of m_axis_tvalid : signal is "xilinx.com:interface:axis:1.0 m_axis TVALID";
  attribute x_interface_info of m_axis_tdata : signal is "xilinx.com:interface:axis:1.0 m_axis TDATA";
  attribute x_interface_parameter of m_axis_tdata : signal is "XIL_INTERFACENAME m_axis, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 1, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 1, FREQ_HZ 99999001, PHASE 0.0, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, LAYERED_METADATA undef, INSERT_VIP 0";
begin
  m_axis_tlast <= \^m_axis_tlast\;
  m_axis_tvalid <= \^m_axis_tlast\;
U0: entity work.design_1_rampgen_0_0_rampgen
     port map (
      aclk => aclk,
      cfg_reg(31 downto 0) => cfg_reg(31 downto 0),
      led => led,
      m_axis_tdata(31 downto 0) => m_axis_tdata(31 downto 0),
      m_axis_tlast => \^m_axis_tlast\,
      m_axis_tready => m_axis_tready
    );
end STRUCTURE;
