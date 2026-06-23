vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xlslice_v1_0_4
vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/axi_infrastructure_v1_1_0
vlib questa_lib/msim/axi_vip_v1_1_17
vlib questa_lib/msim/zynq_ultra_ps_e_vip_v1_0_17

vmap xlslice_v1_0_4 questa_lib/msim/xlslice_v1_0_4
vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap axi_infrastructure_v1_1_0 questa_lib/msim/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_17 questa_lib/msim/axi_vip_v1_1_17
vmap zynq_ultra_ps_e_vip_v1_0_17 questa_lib/msim/zynq_ultra_ps_e_vip_v1_0_17

vlog -work xlslice_v1_0_4  -incr -mfcu  "+incdir+../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/a317/hdl" \
"../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/a97c/hdl/xlslice_v1_0_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/a317/hdl" \
"../../../bd/design_1/ip/design_1_xlslice_0_0/sim/design_1_xlslice_0_0.v" \

vlog -work axi_infrastructure_v1_1_0  -incr -mfcu  "+incdir+../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/a317/hdl" \
"../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_17  -incr -mfcu  -sv "+incdir+../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/a317/hdl" \
"../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/4d04/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work zynq_ultra_ps_e_vip_v1_0_17  -incr -mfcu  -sv "+incdir+../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/a317/hdl" \
"../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/a317/hdl/zynq_ultra_ps_e_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/a317/hdl" \
"../../../bd/design_1/ip/design_1_zynq_ultra_ps_e_0_0/sim/design_1_zynq_ultra_ps_e_0_0_vip_wrapper.v" \

vcom -work xil_defaultlib  -93  \
"../../../bd/design_1/sim/design_1.vhd" \


vlog -work xil_defaultlib \
"glbl.v"

