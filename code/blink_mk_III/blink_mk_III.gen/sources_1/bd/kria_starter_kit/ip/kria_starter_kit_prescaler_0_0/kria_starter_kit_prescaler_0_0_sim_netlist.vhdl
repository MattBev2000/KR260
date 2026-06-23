-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
-- Date        : Sat Dec 28 07:43:16 2024
-- Host        : Goose running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               c:/Users/ASUS/iCloudDrive/PhD-kriask/prj/blink_mk_III/blink_mk_III.gen/sources_1/bd/kria_starter_kit/ip/kria_starter_kit_prescaler_0_0/kria_starter_kit_prescaler_0_0_sim_netlist.vhdl
-- Design      : kria_starter_kit_prescaler_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xck26-sfvc784-2LV-c
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity kria_starter_kit_prescaler_0_0_prescaler is
  port (
    data_out : out STD_LOGIC;
    data_in : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of kria_starter_kit_prescaler_0_0_prescaler : entity is "prescaler";
end kria_starter_kit_prescaler_0_0_prescaler;

architecture STRUCTURE of kria_starter_kit_prescaler_0_0_prescaler is
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
  signal \^data_out\ : STD_LOGIC;
  signal p_1_in : STD_LOGIC_VECTOR ( 18 downto 0 );
  signal tmp : STD_LOGIC;
  signal tmp_i_1_n_0 : STD_LOGIC;
  signal tmp_i_2_n_0 : STD_LOGIC;
  signal tmp_i_3_n_0 : STD_LOGIC;
  signal tmp_i_4_n_0 : STD_LOGIC;
  signal tmp_i_5_n_0 : STD_LOGIC;
  signal tmp_i_6_n_0 : STD_LOGIC;
  signal \NLW_counter0_carry__1_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 1 );
  signal \NLW_counter0_carry__1_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 7 downto 2 );
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of counter0_carry : label is 35;
  attribute ADDER_THRESHOLD of \counter0_carry__0\ : label is 35;
  attribute ADDER_THRESHOLD of \counter0_carry__1\ : label is 35;
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of \counter[0]_i_1\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of tmp_i_2 : label is "soft_lutpair0";
begin
  data_out <= \^data_out\;
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
      O(7 downto 0) => p_1_in(8 downto 1),
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
      O(7 downto 0) => p_1_in(16 downto 9),
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
      O(1 downto 0) => p_1_in(18 downto 17),
      S(7 downto 2) => B"000000",
      S(1 downto 0) => counter(18 downto 17)
    );
\counter[0]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => counter(0),
      O => p_1_in(0)
    );
\counter[18]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000004"
    )
        port map (
      I0 => tmp_i_6_n_0,
      I1 => tmp_i_5_n_0,
      I2 => tmp_i_4_n_0,
      I3 => tmp_i_3_n_0,
      I4 => tmp_i_2_n_0,
      O => tmp
    );
\counter_reg[0]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => data_in,
      CE => '1',
      D => p_1_in(0),
      Q => counter(0),
      R => tmp
    );
\counter_reg[10]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => data_in,
      CE => '1',
      D => p_1_in(10),
      Q => counter(10),
      R => tmp
    );
\counter_reg[11]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => data_in,
      CE => '1',
      D => p_1_in(11),
      Q => counter(11),
      R => tmp
    );
\counter_reg[12]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => data_in,
      CE => '1',
      D => p_1_in(12),
      Q => counter(12),
      R => tmp
    );
\counter_reg[13]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => data_in,
      CE => '1',
      D => p_1_in(13),
      Q => counter(13),
      R => tmp
    );
\counter_reg[14]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => data_in,
      CE => '1',
      D => p_1_in(14),
      Q => counter(14),
      R => tmp
    );
\counter_reg[15]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => data_in,
      CE => '1',
      D => p_1_in(15),
      Q => counter(15),
      R => tmp
    );
\counter_reg[16]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => data_in,
      CE => '1',
      D => p_1_in(16),
      Q => counter(16),
      R => tmp
    );
\counter_reg[17]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => data_in,
      CE => '1',
      D => p_1_in(17),
      Q => counter(17),
      R => tmp
    );
\counter_reg[18]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => data_in,
      CE => '1',
      D => p_1_in(18),
      Q => counter(18),
      R => tmp
    );
\counter_reg[1]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => data_in,
      CE => '1',
      D => p_1_in(1),
      Q => counter(1),
      R => tmp
    );
\counter_reg[2]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => data_in,
      CE => '1',
      D => p_1_in(2),
      Q => counter(2),
      R => tmp
    );
\counter_reg[3]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => data_in,
      CE => '1',
      D => p_1_in(3),
      Q => counter(3),
      R => tmp
    );
\counter_reg[4]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => data_in,
      CE => '1',
      D => p_1_in(4),
      Q => counter(4),
      R => tmp
    );
\counter_reg[5]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => data_in,
      CE => '1',
      D => p_1_in(5),
      Q => counter(5),
      R => tmp
    );
\counter_reg[6]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => data_in,
      CE => '1',
      D => p_1_in(6),
      Q => counter(6),
      R => tmp
    );
\counter_reg[7]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => data_in,
      CE => '1',
      D => p_1_in(7),
      Q => counter(7),
      R => tmp
    );
\counter_reg[8]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => data_in,
      CE => '1',
      D => p_1_in(8),
      Q => counter(8),
      R => tmp
    );
\counter_reg[9]\: unisim.vcomponents.FDRE
    generic map(
      INIT => '0'
    )
        port map (
      C => data_in,
      CE => '1',
      D => p_1_in(9),
      Q => counter(9),
      R => tmp
    );
tmp_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFEFF00000100"
    )
        port map (
      I0 => tmp_i_2_n_0,
      I1 => tmp_i_3_n_0,
      I2 => tmp_i_4_n_0,
      I3 => tmp_i_5_n_0,
      I4 => tmp_i_6_n_0,
      I5 => \^data_out\,
      O => tmp_i_1_n_0
    );
tmp_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"BF"
    )
        port map (
      I0 => counter(5),
      I1 => counter(17),
      I2 => counter(0),
      O => tmp_i_2_n_0
    );
tmp_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFEF"
    )
        port map (
      I0 => counter(12),
      I1 => counter(6),
      I2 => counter(2),
      I3 => counter(10),
      O => tmp_i_3_n_0
    );
tmp_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFEF"
    )
        port map (
      I0 => counter(7),
      I1 => counter(11),
      I2 => counter(18),
      I3 => counter(14),
      O => tmp_i_4_n_0
    );
tmp_i_5: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => counter(4),
      I1 => counter(13),
      I2 => counter(3),
      I3 => counter(1),
      O => tmp_i_5_n_0
    );
tmp_i_6: unisim.vcomponents.LUT4
    generic map(
      INIT => X"DFFF"
    )
        port map (
      I0 => counter(16),
      I1 => counter(9),
      I2 => counter(15),
      I3 => counter(8),
      O => tmp_i_6_n_0
    );
tmp_reg: unisim.vcomponents.FDRE
    generic map(
      INIT => '1'
    )
        port map (
      C => data_in,
      CE => '1',
      D => tmp_i_1_n_0,
      Q => \^data_out\,
      R => '0'
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity kria_starter_kit_prescaler_0_0 is
  port (
    data_in : in STD_LOGIC;
    data_out : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of kria_starter_kit_prescaler_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of kria_starter_kit_prescaler_0_0 : entity is "kria_starter_kit_prescaler_0_0,prescaler,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of kria_starter_kit_prescaler_0_0 : entity is "yes";
  attribute ip_definition_source : string;
  attribute ip_definition_source of kria_starter_kit_prescaler_0_0 : entity is "module_ref";
  attribute x_core_info : string;
  attribute x_core_info of kria_starter_kit_prescaler_0_0 : entity is "prescaler,Vivado 2024.1";
end kria_starter_kit_prescaler_0_0;

architecture STRUCTURE of kria_starter_kit_prescaler_0_0 is
begin
U0: entity work.kria_starter_kit_prescaler_0_0_prescaler
     port map (
      data_in => data_in,
      data_out => data_out
    );
end STRUCTURE;
