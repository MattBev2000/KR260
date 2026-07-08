// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2026 Advanced Micro Devices, Inc. All Rights Reserved.
// -------------------------------------------------------------------------------

`timescale 1 ps / 1 ps

(* BLOCK_STUB = "true" *)
module design_1 (
  fan_en_b,
  som240_1_connector_hpa_clk0p_clk,
  uf1
);

  (* X_INTERFACE_IGNORE = "true" *)
  output [0:0]fan_en_b;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.SOM240_1_CONNECTOR_HPA_CLK0P_CLK CLK" *)
  (* X_INTERFACE_MODE = "slave CLK.SOM240_1_CONNECTOR_HPA_CLK0P_CLK" *)
  (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.SOM240_1_CONNECTOR_HPA_CLK0P_CLK, FREQ_HZ 25000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_som240_1_connector_hpa_clk0p_clk, INSERT_VIP 0" *)
  input som240_1_connector_hpa_clk0p_clk;
  (* X_INTERFACE_IGNORE = "true" *)
  output uf1;

  // stub module has no contents

endmodule
