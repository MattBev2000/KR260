# KRIA KR260 Robotics starter kit physical constraints
# Author : Bevilacqua Mattia, Consorzio RFX
# Date : 22/11/2024
# Rev : 1


# USER DEFINED LEDS -----------------------------------------------------------------------------------------------------------------------------------------------------
set_property -dict {PACKAGE_PIN F8 IOSTANDARD LVCMOS18} [get_ports {uf1}]
set_property -dict {PACKAGE_PIN E8 IOSTANDARD LVCMOS18} [get_ports {uf2}]

# RASPBERRY EXPANSION HEADER PINS ---------------------------------------------------------------------------------------------------------------------------------------
# rpi_01, rpi_17 => 3V3
# rpi_02, rpi_05 => 5V0
# rpi_06, rpi_14, rpi_20, rpi_30, rpi_34, rpi_09, rpi_25, rpi_39 => 0V0
#set_property -dict {PACKAGE_PIN  AE15  IOSTANDARD LVCMOS33}  [get_ports {rpi_03}]  
#set_property -dict {PACKAGE_PIN  AE14  IOSTANDARD LVCMOS33}  [get_ports {rpi_05}]  
#set_property -dict {PACKAGE_PIN  AG14  IOSTANDARD LVCMOS33}  [get_ports {rpi_07}]  
#set_property -dict {PACKAGE_PIN  W14   IOSTANDARD LVCMOS33}  [get_ports {rpi_08}]  
#set_property -dict {PACKAGE_PIN  W13   IOSTANDARD LVCMOS33}  [get_ports {rpi_10}]
#set_property -dict {PACKAGE_PIN  AB14  IOSTANDARD LVCMOS33}  [get_ports {rpi_11}]
#set_property -dict {PACKAGE_PIN  Y14   IOSTANDARD LVCMOS33}  [get_ports {rpi_12}]
#set_property -dict {PACKAGE_PIN  AB9   IOSTANDARD LVCMOS33}  [get_ports {rpi_13}]
#set_property -dict {PACKAGE_PIN  Y12   IOSTANDARD LVCMOS33}  [get_ports {rpi_15}]
#set_property -dict {PACKAGE_PIN  AA12  IOSTANDARD LVCMOS33}  [get_ports {rpi_16}]
#set_property -dict {PACKAGE_PIN  Y9    IOSTANDARD LVCMOS33}  [get_ports {rpi_18}]
#set_property -dict {PACKAGE_PIN  AE13  IOSTANDARD LVCMOS33}  [get_ports {rpi_19}]
#set_property -dict {PACKAGE_PIN  AC13  IOSTANDARD LVCMOS33}  [get_ports {rpi_21}]
#set_property -dict {PACKAGE_PIN  AA8   IOSTANDARD LVCMOS33}  [get_ports {rpi_22}]
#set_property -dict {PACKAGE_PIN  AF13  IOSTANDARD LVCMOS33}  [get_ports {rpi_23}]
#set_property -dict {PACKAGE_PIN  AC14  IOSTANDARD LVCMOS33}  [get_ports {rpi_24}]
#set_property -dict {PACKAGE_PIN  AH13  IOSTANDARD LVCMOS33}  [get_ports {rpi_26}]
#set_property -dict {PACKAGE_PIN  AD15  IOSTANDARD LVCMOS33}  [get_ports {rpi_27}]
#set_property -dict {PACKAGE_PIN  AD14  IOSTANDARD LVCMOS33}  [get_ports {rpi_28}]
#set_property -dict {PACKAGE_PIN  AH14  IOSTANDARD LVCMOS33}  [get_ports {rpi_29}]
#set_property -dict {PACKAGE_PIN  AG13  IOSTANDARD LVCMOS33}  [get_ports {rpi_31}]
#set_property -dict {PACKAGE_PIN  AA13  IOSTANDARD LVCMOS33}  [get_ports {rpi_32}]
#set_property -dict {PACKAGE_PIN  AB13  IOSTANDARD LVCMOS33}  [get_ports {rpi_33}]
#set_property -dict {PACKAGE_PIN  Y13   IOSTANDARD LVCMOS33}  [get_ports {rpi_35}]
#set_property -dict {PACKAGE_PIN  AB15  IOSTANDARD LVCMOS33}  [get_ports {rpi_36}]
#set_property -dict {PACKAGE_PIN  AB10  IOSTANDARD LVCMOS33}  [get_ports {rpi_37}]
#set_property -dict {PACKAGE_PIN  W12   IOSTANDARD LVCMOS33}  [get_ports {rpi_38}]
#set_property -dict {PACKAGE_PIN  W11   IOSTANDARD LVCMOS33}  [get_ports {rpi_40}]


# PMOD1 PINS ------------------------------------------------------------------------------------------------------------------------------------------------------------
# pmod1_09, pmod1_10 => 0V0
# pmod1_11, pmod1_12 => 3V3
#set_property -dict {PACKAGE_PIN  H12   IOSTANDARD LVCMOS33}  [get_ports {pmod1_01}]
#set_property -dict {PACKAGE_PIN  B10   IOSTANDARD LVCMOS33}  [get_ports {pmod1_02}]
#set_property -dict {PACKAGE_PIN  E10   IOSTANDARD LVCMOS33}  [get_ports {pmod1_03}]
#set_property -dict {PACKAGE_PIN  E12   IOSTANDARD LVCMOS33}  [get_ports {pmod1_04}]
#set_property -dict {PACKAGE_PIN  D10   IOSTANDARD LVCMOS33}  [get_ports {pmod1_05}]
#set_property -dict {PACKAGE_PIN  D11   IOSTANDARD LVCMOS33}  [get_ports {pmod1_06}]
#set_property -dict {PACKAGE_PIN  C11   IOSTANDARD LVCMOS33}  [get_ports {pmod1_07}]
#set_property -dict {PACKAGE_PIN  B11   IOSTANDARD LVCMOS33}  [get_ports {pmod1_08}]


# PMOD2 PINS ------------------------------------------------------------------------------------------------------------------------------------------------------------
# pmod2_09, pmod2_10 => 0V0
# pmod2_11, pmod2_12 => 3V3
#set_property -dict {PACKAGE_PIN  J11   IOSTANDARD LVCMOS33}  [get_ports {pmod2_01}]
#set_property -dict {PACKAGE_PIN  H11   IOSTANDARD LVCMOS33}  [get_ports {pmod2_02}]
#set_property -dict {PACKAGE_PIN  J10   IOSTANDARD LVCMOS33}  [get_ports {pmod2_03}]
#set_property -dict {PACKAGE_PIN  C19   IOSTANDARD LVCMOS33}  [get_ports {pmod2_04}]
#set_property -dict {PACKAGE_PIN  K13   IOSTANDARD LVCMOS33}  [get_ports {pmod2_05}]
#set_property -dict {PACKAGE_PIN  F12   IOSTANDARD LVCMOS33}  [get_ports {pmod2_06}]
#set_property -dict {PACKAGE_PIN  K12   IOSTANDARD LVCMOS33}  [get_ports {pmod2_07}]
#set_property -dict {PACKAGE_PIN  F11   IOSTANDARD LVCMOS33}  [get_ports {pmod2_08}]


# PMOD3 PINS ------------------------------------------------------------------------------------------------------------------------------------------------------------
# pmod3_09, pmod3_10 => 0V0
# pmod3_11, pmod3_12 => 3V3
#set_property -dict {PACKAGE_PIN  AE12  IOSTANDARD LVCMOS33}  [get_ports {pmod3_01}]
#set_property -dict {PACKAGE_PIN  AF11  IOSTANDARD LVCMOS33}  [get_ports {pmod3_02}]
#set_property -dict {PACKAGE_PIN  AF12  IOSTANDARD LVCMOS33}  [get_ports {pmod3_03}]
#set_property -dict {PACKAGE_PIN  AG11  IOSTANDARD LVCMOS33}  [get_ports {pmod3_04}]
#set_property -dict {PACKAGE_PIN  AG10  IOSTANDARD LVCMOS33}  [get_ports {pmod3_05}]
#set_property -dict {PACKAGE_PIN  AH12  IOSTANDARD LVCMOS33}  [get_ports {pmod3_06}]
#set_property -dict {PACKAGE_PIN  AH10  IOSTANDARD LVCMOS33}  [get_ports {pmod3_07}]
#set_property -dict {PACKAGE_PIN  AH11  IOSTANDARD LVCMOS33}  [get_ports {pmod3_08}]


# PMOD4 PINS ------------------------------------------------------------------------------------------------------------------------------------------------------------
# pmod4_09, pmod4_10 => 0V0
# pmod4_11, pmod4_12 => 3V3
#set_property -dict {PACKAGE_PIN  AC12  IOSTANDARD LVCMOS33}  [get_ports {pmod4_01}]
#set_property -dict {PACKAGE_PIN  AD11  IOSTANDARD LVCMOS33}  [get_ports {pmod4_02}]
#set_property -dict {PACKAGE_PIN  AD12  IOSTANDARD LVCMOS33}  [get_ports {pmod4_03}]
#set_property -dict {PACKAGE_PIN  AD10  IOSTANDARD LVCMOS33}  [get_ports {pmod4_04}]
#set_property -dict {PACKAGE_PIN  AE10  IOSTANDARD LVCMOS33}  [get_ports {pmod4_05}]
#set_property -dict {PACKAGE_PIN  AA11  IOSTANDARD LVCMOS33}  [get_ports {pmod4_06}]
#set_property -dict {PACKAGE_PIN  AF10  IOSTANDARD LVCMOS33}  [get_ports {pmod4_07}]
#set_property -dict {PACKAGE_PIN  AA10  IOSTANDARD LVCMOS33}  [get_ports {pmod4_08}]
