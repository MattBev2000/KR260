-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
-- Date        : Tue Jan  7 11:51:37 2025
-- Host        : Goose running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Users/ASUS/iCloudDrive/PhD-kriask/prj/blink_mk_VI/blink_mk_VI.gen/sources_1/bd/design_1/ip/design_1_prescaler_0_0/design_1_prescaler_0_0_sim_netlist.vhdl
-- Design      : design_1_prescaler_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xck26-sfvc784-2LV-c
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_prescaler_0_0_prescaler is
  port (
    clk_out : out STD_LOGIC;
    clk_in : in STD_LOGIC;
    reset : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_1_prescaler_0_0_prescaler : entity is "prescaler";
end design_1_prescaler_0_0_prescaler;

architecture STRUCTURE of design_1_prescaler_0_0_prescaler is
  signal \^clk_out\ : STD_LOGIC;
  signal counter : STD_LOGIC_VECTOR ( 18 downto 0 );
  signal \counter0_carry__0_n_0\ : STD_LOGIC;
  signal \counter0_carry__0_n_1\ : STD_LOGIC;
  signal \counter0_carry__0_n_2\ : STD_LOGIC;
  signal \counter0_carry__0_n_3\ : STD_LOGIC;
  signal \counter0_carry__0_n_4\ : STD_LOGIC;
  signal \counter0_carry__0_n_5\ : STD_LOGIC;
  signal \counter0_carry__0_n_6\ : STD_LOGIC;
  signal \counter0_carry__0_n_7\ : STD_LOGIC;
  signal \counter0_carry__1_n_7\ : STD_LOGIC;
  signal counter0_carry_n_0 : STD_LOGIC;
  signal counter0_carry_n_1 : STD_LOGIC;
  signal counter0_carry_n_2 : STD_LOGIC;
  signal counter0_carry_n_3 : STD_LOGIC;
  signal counter0_carry_n_4 : STD_LOGIC;
  signal counter0_carry_n_5 : STD_LOGIC;
  signal counter0_carry_n_6 : STD_LOGIC;
  signal counter0_carry_n_7 : STD_LOGIC;
  signal counter_0 : STD_LOGIC_VECTOR ( 18 downto 0 );
  signal data0 : STD_LOGIC_VECTOR ( 18 downto 1 );
  signal tmp_i_1_n_0 : STD_LOGIC;
  signal tmp_i_2_n_0 : STD_LOGIC;
  signal tmp_i_3_n_0 : STD_LOGIC;
  signal tmp_i_4_n_0 : STD_LOGIC;
  signal tmp_i_5_n_0 : STD_LOGIC;
  signal tmp_i_6_n_0 : STD_LOGIC;
  signal tmp_i_7_n_0 : STD_LOGIC;
  signal \NLW_counter0_carry__1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 1 );
  signal \NLW_counter0_carry__1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 2 );
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of counter0_carry : label is 35;
  attribute ADDER_THRESHOLD of \counter0_carry__0\ : label is 35;
  attribute ADDER_THRESHOLD of \counter0_carry__1\ : label is 35;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \counter[0]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of tmp_i_5 : label is "soft_lutpair0";
begin
  clk_out <= \^clk_out\;
counter0_carry: unisim.vcomponents.CARRY8
     port map (
      CI => counter(0),
      CI_TOP => '0',
      CO(7) => counter0_carry_n_0,
      CO(6) => counter0_carry_n_1,
      CO(5) => counter0_carry_n_2,
      CO(4) => counter0_carry_n_3,
      CO(3) => counter0_carry_n_4,
      CO(2) => counter0_carry_n_5,
      CO(1) => counter0_carry_n_6,
      CO(0) => counter0_carry_n_7,
      DI(7 downto 0) => B"00000000",
      O(7 downto 0) => data0(8 downto 1),
      S(7 downto 0) => counter(8 downto 1)
    );
\counter0_carry__0\: unisim.vcomponents.CARRY8
     port map (
      CI => counter0_carry_n_0,
      CI_TOP => '0',
      CO(7) => \counter0_carry__0_n_0\,
      CO(6) => \counter0_carry__0_n_1\,
      CO(5) => \counter0_carry__0_n_2\,
      CO(4) => \counter0_carry__0_n_3\,
      CO(3) => \counter0_carry__0_n_4\,
      CO(2) => \counter0_carry__0_n_5\,
      CO(1) => \counter0_carry__0_n_6\,
      CO(0) => \counter0_carry__0_n_7\,
      DI(7 downto 0) => B"00000000",
      O(7 downto 0) => data0(16 downto 9),
      S(7 downto 0) => counter(16 downto 9)
    );
\counter0_carry__1\: unisim.vcomponents.CARRY8
     port map (
      CI => \counter0_carry__0_n_0\,
      CI_TOP => '0',
      CO(7 downto 1) => \NLW_counter0_carry__1_CO_UNCONNECTED\(7 downto 1),
      CO(0) => \counter0_carry__1_n_7\,
      DI(7 downto 0) => B"00000000",
      O(7 downto 2) => \NLW_counter0_carry__1_O_UNCONNECTED\(7 downto 2),
      O(1 downto 0) => data0(18 downto 17),
      S(7 downto 2) => B"000000",
      S(1 downto 0) => counter(18 downto 17)
    );
\counter[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => counter(0),
      O => counter_0(0)
    );
\counter[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000000"
    )
        port map (
      I0 => tmp_i_3_n_0,
      I1 => tmp_i_4_n_0,
      I2 => tmp_i_5_n_0,
      I3 => tmp_i_6_n_0,
      I4 => tmp_i_7_n_0,
      I5 => data0(10),
      O => counter_0(10)
    );
\counter[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000000"
    )
        port map (
      I0 => tmp_i_3_n_0,
      I1 => tmp_i_4_n_0,
      I2 => tmp_i_5_n_0,
      I3 => tmp_i_6_n_0,
      I4 => tmp_i_7_n_0,
      I5 => data0(11),
      O => counter_0(11)
    );
\counter[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000000"
    )
        port map (
      I0 => tmp_i_3_n_0,
      I1 => tmp_i_4_n_0,
      I2 => tmp_i_5_n_0,
      I3 => tmp_i_6_n_0,
      I4 => tmp_i_7_n_0,
      I5 => data0(12),
      O => counter_0(12)
    );
\counter[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000000"
    )
        port map (
      I0 => tmp_i_3_n_0,
      I1 => tmp_i_4_n_0,
      I2 => tmp_i_5_n_0,
      I3 => tmp_i_6_n_0,
      I4 => tmp_i_7_n_0,
      I5 => data0(13),
      O => counter_0(13)
    );
\counter[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000000"
    )
        port map (
      I0 => tmp_i_3_n_0,
      I1 => tmp_i_4_n_0,
      I2 => tmp_i_5_n_0,
      I3 => tmp_i_6_n_0,
      I4 => tmp_i_7_n_0,
      I5 => data0(14),
      O => counter_0(14)
    );
\counter[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000000"
    )
        port map (
      I0 => tmp_i_3_n_0,
      I1 => tmp_i_4_n_0,
      I2 => tmp_i_5_n_0,
      I3 => tmp_i_6_n_0,
      I4 => tmp_i_7_n_0,
      I5 => data0(15),
      O => counter_0(15)
    );
\counter[16]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000000"
    )
        port map (
      I0 => tmp_i_3_n_0,
      I1 => tmp_i_4_n_0,
      I2 => tmp_i_5_n_0,
      I3 => tmp_i_6_n_0,
      I4 => tmp_i_7_n_0,
      I5 => data0(16),
      O => counter_0(16)
    );
\counter[17]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000000"
    )
        port map (
      I0 => tmp_i_3_n_0,
      I1 => tmp_i_4_n_0,
      I2 => tmp_i_5_n_0,
      I3 => tmp_i_6_n_0,
      I4 => tmp_i_7_n_0,
      I5 => data0(17),
      O => counter_0(17)
    );
\counter[18]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000000"
    )
        port map (
      I0 => tmp_i_3_n_0,
      I1 => tmp_i_4_n_0,
      I2 => tmp_i_5_n_0,
      I3 => tmp_i_6_n_0,
      I4 => tmp_i_7_n_0,
      I5 => data0(18),
      O => counter_0(18)
    );
\counter[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000000"
    )
        port map (
      I0 => tmp_i_3_n_0,
      I1 => tmp_i_4_n_0,
      I2 => tmp_i_5_n_0,
      I3 => tmp_i_6_n_0,
      I4 => tmp_i_7_n_0,
      I5 => data0(1),
      O => counter_0(1)
    );
\counter[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000000"
    )
        port map (
      I0 => tmp_i_3_n_0,
      I1 => tmp_i_4_n_0,
      I2 => tmp_i_5_n_0,
      I3 => tmp_i_6_n_0,
      I4 => tmp_i_7_n_0,
      I5 => data0(2),
      O => counter_0(2)
    );
\counter[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000000"
    )
        port map (
      I0 => tmp_i_3_n_0,
      I1 => tmp_i_4_n_0,
      I2 => tmp_i_5_n_0,
      I3 => tmp_i_6_n_0,
      I4 => tmp_i_7_n_0,
      I5 => data0(3),
      O => counter_0(3)
    );
\counter[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000000"
    )
        port map (
      I0 => tmp_i_3_n_0,
      I1 => tmp_i_4_n_0,
      I2 => tmp_i_5_n_0,
      I3 => tmp_i_6_n_0,
      I4 => tmp_i_7_n_0,
      I5 => data0(4),
      O => counter_0(4)
    );
\counter[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000000"
    )
        port map (
      I0 => tmp_i_3_n_0,
      I1 => tmp_i_4_n_0,
      I2 => tmp_i_5_n_0,
      I3 => tmp_i_6_n_0,
      I4 => tmp_i_7_n_0,
      I5 => data0(5),
      O => counter_0(5)
    );
\counter[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000000"
    )
        port map (
      I0 => tmp_i_3_n_0,
      I1 => tmp_i_4_n_0,
      I2 => tmp_i_5_n_0,
      I3 => tmp_i_6_n_0,
      I4 => tmp_i_7_n_0,
      I5 => data0(6),
      O => counter_0(6)
    );
\counter[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000000"
    )
        port map (
      I0 => tmp_i_3_n_0,
      I1 => tmp_i_4_n_0,
      I2 => tmp_i_5_n_0,
      I3 => tmp_i_6_n_0,
      I4 => tmp_i_7_n_0,
      I5 => data0(7),
      O => counter_0(7)
    );
\counter[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000000"
    )
        port map (
      I0 => tmp_i_3_n_0,
      I1 => tmp_i_4_n_0,
      I2 => tmp_i_5_n_0,
      I3 => tmp_i_6_n_0,
      I4 => tmp_i_7_n_0,
      I5 => data0(8),
      O => counter_0(8)
    );
\counter[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000000"
    )
        port map (
      I0 => tmp_i_3_n_0,
      I1 => tmp_i_4_n_0,
      I2 => tmp_i_5_n_0,
      I3 => tmp_i_6_n_0,
      I4 => tmp_i_7_n_0,
      I5 => data0(9),
      O => counter_0(9)
    );
\counter_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_in,
      CE => '1',
      CLR => tmp_i_2_n_0,
      D => counter_0(0),
      Q => counter(0)
    );
\counter_reg[10]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_in,
      CE => '1',
      CLR => tmp_i_2_n_0,
      D => counter_0(10),
      Q => counter(10)
    );
\counter_reg[11]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_in,
      CE => '1',
      CLR => tmp_i_2_n_0,
      D => counter_0(11),
      Q => counter(11)
    );
\counter_reg[12]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_in,
      CE => '1',
      CLR => tmp_i_2_n_0,
      D => counter_0(12),
      Q => counter(12)
    );
\counter_reg[13]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_in,
      CE => '1',
      CLR => tmp_i_2_n_0,
      D => counter_0(13),
      Q => counter(13)
    );
\counter_reg[14]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_in,
      CE => '1',
      CLR => tmp_i_2_n_0,
      D => counter_0(14),
      Q => counter(14)
    );
\counter_reg[15]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_in,
      CE => '1',
      CLR => tmp_i_2_n_0,
      D => counter_0(15),
      Q => counter(15)
    );
\counter_reg[16]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_in,
      CE => '1',
      CLR => tmp_i_2_n_0,
      D => counter_0(16),
      Q => counter(16)
    );
\counter_reg[17]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_in,
      CE => '1',
      CLR => tmp_i_2_n_0,
      D => counter_0(17),
      Q => counter(17)
    );
\counter_reg[18]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_in,
      CE => '1',
      CLR => tmp_i_2_n_0,
      D => counter_0(18),
      Q => counter(18)
    );
\counter_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_in,
      CE => '1',
      CLR => tmp_i_2_n_0,
      D => counter_0(1),
      Q => counter(1)
    );
\counter_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_in,
      CE => '1',
      CLR => tmp_i_2_n_0,
      D => counter_0(2),
      Q => counter(2)
    );
\counter_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_in,
      CE => '1',
      CLR => tmp_i_2_n_0,
      D => counter_0(3),
      Q => counter(3)
    );
\counter_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_in,
      CE => '1',
      CLR => tmp_i_2_n_0,
      D => counter_0(4),
      Q => counter(4)
    );
\counter_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_in,
      CE => '1',
      CLR => tmp_i_2_n_0,
      D => counter_0(5),
      Q => counter(5)
    );
\counter_reg[6]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_in,
      CE => '1',
      CLR => tmp_i_2_n_0,
      D => counter_0(6),
      Q => counter(6)
    );
\counter_reg[7]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_in,
      CE => '1',
      CLR => tmp_i_2_n_0,
      D => counter_0(7),
      Q => counter(7)
    );
\counter_reg[8]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_in,
      CE => '1',
      CLR => tmp_i_2_n_0,
      D => counter_0(8),
      Q => counter(8)
    );
\counter_reg[9]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => clk_in,
      CE => '1',
      CLR => tmp_i_2_n_0,
      D => counter_0(9),
      Q => counter(9)
    );
tmp_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000001"
    )
        port map (
      I0 => tmp_i_3_n_0,
      I1 => tmp_i_4_n_0,
      I2 => tmp_i_5_n_0,
      I3 => tmp_i_6_n_0,
      I4 => tmp_i_7_n_0,
      I5 => \^clk_out\,
      O => tmp_i_1_n_0
    );
tmp_i_2: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => reset,
      O => tmp_i_2_n_0
    );
tmp_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => counter(2),
      I1 => counter(1),
      I2 => counter(4),
      I3 => counter(3),
      O => tmp_i_3_n_0
    );
tmp_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DFFF"
    )
        port map (
      I0 => counter(13),
      I1 => counter(14),
      I2 => counter(16),
      I3 => counter(15),
      O => tmp_i_4_n_0
    );
tmp_i_5: unisim.vcomponents.LUT3
    generic map(
      INIT => X"7F"
    )
        port map (
      I0 => counter(18),
      I1 => counter(17),
      I2 => counter(0),
      O => tmp_i_5_n_0
    );
tmp_i_6: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => counter(10),
      I1 => counter(9),
      I2 => counter(12),
      I3 => counter(11),
      O => tmp_i_6_n_0
    );
tmp_i_7: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFEF"
    )
        port map (
      I0 => counter(6),
      I1 => counter(5),
      I2 => counter(8),
      I3 => counter(7),
      O => tmp_i_7_n_0
    );
tmp_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '1'
    )
        port map (
      C => clk_in,
      CE => '1',
      CLR => tmp_i_2_n_0,
      D => tmp_i_1_n_0,
      Q => \^clk_out\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_prescaler_0_0 is
  port (
    clk_in : in STD_LOGIC;
    reset : in STD_LOGIC;
    clk_out : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_1_prescaler_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_1_prescaler_0_0 : entity is "design_1_prescaler_0_0,prescaler,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of design_1_prescaler_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of design_1_prescaler_0_0 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of design_1_prescaler_0_0 : entity is "prescaler,Vivado 2024.1";
end design_1_prescaler_0_0;

architecture STRUCTURE of design_1_prescaler_0_0 is
  attribute x_interface_info : string;
  attribute x_interface_info of reset : signal is "xilinx.com:signal:reset:1.0 reset RST";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of reset : signal is "XIL_INTERFACENAME reset, POLARITY ACTIVE_LOW, INSERT_VIP 0";
begin
U0: entity work.design_1_prescaler_0_0_prescaler
     port map (
      clk_in => clk_in,
      clk_out => clk_out,
      reset => reset
    );
end STRUCTURE;
