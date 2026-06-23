transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xilinx_vip
vlib riviera/xpm
vlib riviera/xlslice_v1_0_4
vlib riviera/xil_defaultlib
vlib riviera/axi_infrastructure_v1_1_0
vlib riviera/axi_vip_v1_1_17
vlib riviera/zynq_ultra_ps_e_vip_v1_0_17

vmap xilinx_vip riviera/xilinx_vip
vmap xpm riviera/xpm
vmap xlslice_v1_0_4 riviera/xlslice_v1_0_4
vmap xil_defaultlib riviera/xil_defaultlib
vmap axi_infrastructure_v1_1_0 riviera/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_17 riviera/axi_vip_v1_1_17
vmap zynq_ultra_ps_e_vip_v1_0_17 riviera/zynq_ultra_ps_e_vip_v1_0_17

vlog -work xilinx_vip  -incr "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlslice_v1_0_4 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l zynq_ultra_ps_e_vip_v1_0_17 \
"C:/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"C:/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"C:/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"C:/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"C:/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"C:/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"C:/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"C:/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"C:/Xilinx/Vivado/2024.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -incr "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/a317/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/3242" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/814a/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/1017/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/8745/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/2340/hdl/verilog" "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlslice_v1_0_4 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l zynq_ultra_ps_e_vip_v1_0_17 \
"C:/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  -incr \
"C:/Xilinx/Vivado/2024.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xlslice_v1_0_4  -incr -v2k5 "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/a317/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/3242" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/814a/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/1017/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/8745/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/2340/hdl/verilog" "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlslice_v1_0_4 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l zynq_ultra_ps_e_vip_v1_0_17 \
"../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/a97c/hdl/xlslice_v1_0_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/a317/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/3242" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/814a/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/1017/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/8745/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/2340/hdl/verilog" "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlslice_v1_0_4 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l zynq_ultra_ps_e_vip_v1_0_17 \
"../../../bd/kria_starter_kit/ip/kria_starter_kit_xlslice_0_0/sim/kria_starter_kit_xlslice_0_0.v" \

vlog -work axi_infrastructure_v1_1_0  -incr -v2k5 "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/a317/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/3242" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/814a/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/1017/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/8745/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/2340/hdl/verilog" "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlslice_v1_0_4 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l zynq_ultra_ps_e_vip_v1_0_17 \
"../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_17  -incr "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/a317/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/3242" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/814a/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/1017/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/8745/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/2340/hdl/verilog" "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlslice_v1_0_4 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l zynq_ultra_ps_e_vip_v1_0_17 \
"../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/4d04/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work zynq_ultra_ps_e_vip_v1_0_17  -incr "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/a317/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/3242" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/814a/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/1017/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/8745/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/2340/hdl/verilog" "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlslice_v1_0_4 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l zynq_ultra_ps_e_vip_v1_0_17 \
"../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/a317/hdl/zynq_ultra_ps_e_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/a317/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/3242" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/814a/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/1017/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/8745/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/2340/hdl/verilog" "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlslice_v1_0_4 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l zynq_ultra_ps_e_vip_v1_0_17 \
"../../../bd/kria_starter_kit/ip/kria_starter_kit_zynq_ultra_ps_e_0_0/sim/kria_starter_kit_zynq_ultra_ps_e_0_0_vip_wrapper.v" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/kria_starter_kit/ip/kria_starter_kit_ila_0_0/sim/kria_starter_kit_ila_0_0.vhd" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/a317/hdl" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/3242" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/814a/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/1017/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/8745/hdl/verilog" "+incdir+../../../../blink_mk_III.gen/sources_1/bd/kria_starter_kit/ipshared/2340/hdl/verilog" "+incdir+C:/Xilinx/Vivado/2024.1/data/xilinx_vip/include" -l xilinx_vip -l xpm -l xlslice_v1_0_4 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l zynq_ultra_ps_e_vip_v1_0_17 \
"../../../bd/kria_starter_kit/ip/kria_starter_kit_clk_wiz_0_0/kria_starter_kit_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/kria_starter_kit/ip/kria_starter_kit_clk_wiz_0_0/kria_starter_kit_clk_wiz_0_0.v" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/kria_starter_kit/ip/kria_starter_kit_prescaler_0_0/sim/kria_starter_kit_prescaler_0_0.vhd" \
"../../../bd/kria_starter_kit/sim/kria_starter_kit.vhd" \

vlog -work xil_defaultlib \
"glbl.v"

