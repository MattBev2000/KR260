vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xilinx_vip
vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/xlslice_v1_0_4
vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/axi_infrastructure_v1_1_0
vlib modelsim_lib/msim/axi_vip_v1_1_17
vlib modelsim_lib/msim/zynq_ultra_ps_e_vip_v1_0_17

vmap xilinx_vip modelsim_lib/msim/xilinx_vip
vmap xpm modelsim_lib/msim/xpm
vmap xlslice_v1_0_4 modelsim_lib/msim/xlslice_v1_0_4
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap axi_infrastructure_v1_1_0 modelsim_lib/msim/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_17 modelsim_lib/msim/axi_vip_v1_1_17
vmap zynq_ultra_ps_e_vip_v1_0_17 modelsim_lib/msim/zynq_ultra_ps_e_vip_v1_0_17

vlog -work xilinx_vip  -incr -mfcu  -sv -L axi_vip_v1_1_17 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"C:/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"C:/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"C:/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"C:/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"C:/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"C:/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"C:/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"C:/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"C:/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -incr -mfcu  -sv -L axi_vip_v1_1_17 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/a317/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/3242" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/814a/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/1017/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/8745/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/2340/hdl/verilog" "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"C:/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm  -93  \
"C:/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xlslice_v1_0_4  -incr -mfcu  "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/a317/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/3242" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/814a/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/1017/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/8745/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/2340/hdl/verilog" "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/a97c/hdl/xlslice_v1_0_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/a317/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/3242" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/814a/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/1017/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/8745/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/2340/hdl/verilog" "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../bd/kria_starter_kit/ip/kria_starter_kit_xlslice_0_0/sim/kria_starter_kit_xlslice_0_0.v" \

vlog -work axi_infrastructure_v1_1_0  -incr -mfcu  "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/a317/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/3242" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/814a/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/1017/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/8745/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/2340/hdl/verilog" "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_17  -incr -mfcu  -sv -L axi_vip_v1_1_17 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/a317/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/3242" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/814a/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/1017/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/8745/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/2340/hdl/verilog" "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/4d04/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work zynq_ultra_ps_e_vip_v1_0_17  -incr -mfcu  -sv -L axi_vip_v1_1_17 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/a317/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/3242" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/814a/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/1017/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/8745/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/2340/hdl/verilog" "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/a317/hdl/zynq_ultra_ps_e_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/a317/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/3242" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/814a/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/1017/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/8745/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/2340/hdl/verilog" "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../bd/kria_starter_kit/ip/kria_starter_kit_zynq_ultra_ps_e_0_0/sim/kria_starter_kit_zynq_ultra_ps_e_0_0_vip_wrapper.v" \

vcom -work xil_defaultlib  -93  \
"../../../bd/kria_starter_kit/ip/kria_starter_kit_ila_0_0/sim/kria_starter_kit_ila_0_0.vhd" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/a317/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/3242" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/814a/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/1017/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/8745/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/2340/hdl/verilog" "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" \
"../../../bd/kria_starter_kit/ip/kria_starter_kit_clk_wiz_0_0/kria_starter_kit_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/kria_starter_kit/ip/kria_starter_kit_clk_wiz_0_0/kria_starter_kit_clk_wiz_0_0.v" \

vcom -work xil_defaultlib  -93  \
"../../../bd/kria_starter_kit/ip/kria_starter_kit_prescaler_0_0/sim/kria_starter_kit_prescaler_0_0.vhd" \
"../../../bd/kria_starter_kit/sim/kria_starter_kit.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

