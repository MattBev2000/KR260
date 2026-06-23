vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xlslice_v1_0_4
vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/axi_infrastructure_v1_1_0
vlib modelsim_lib/msim/axi_vip_v1_1_17
vlib modelsim_lib/msim/zynq_ultra_ps_e_vip_v1_0_17

vmap xlslice_v1_0_4 modelsim_lib/msim/xlslice_v1_0_4
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap axi_infrastructure_v1_1_0 modelsim_lib/msim/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_17 modelsim_lib/msim/axi_vip_v1_1_17
vmap zynq_ultra_ps_e_vip_v1_0_17 modelsim_lib/msim/zynq_ultra_ps_e_vip_v1_0_17

vlog -work xlslice_v1_0_4  -incr -mfcu  "+incdir+../../../../../../doc/core_init_mk_III/ipshared/ec67/hdl" "+incdir+../../../../../../doc/core_init_mk_III/ipshared/a317/hdl" \
"../../../../../../doc/core_init_mk_III/ipshared/a97c/hdl/xlslice_v1_0_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../../../doc/core_init_mk_III/ipshared/ec67/hdl" "+incdir+../../../../../../doc/core_init_mk_III/ipshared/a317/hdl" \
"../../../bd/core_init_mk_III/ip/core_init_mk_III_xlslice_0_0/sim/core_init_mk_III_xlslice_0_0.v" \

vlog -work axi_infrastructure_v1_1_0  -incr -mfcu  "+incdir+../../../../../../doc/core_init_mk_III/ipshared/ec67/hdl" "+incdir+../../../../../../doc/core_init_mk_III/ipshared/a317/hdl" \
"../../../../../../doc/core_init_mk_III/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_17  -incr -mfcu  -sv "+incdir+../../../../../../doc/core_init_mk_III/ipshared/ec67/hdl" "+incdir+../../../../../../doc/core_init_mk_III/ipshared/a317/hdl" \
"../../../../../../doc/core_init_mk_III/ipshared/4d04/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work zynq_ultra_ps_e_vip_v1_0_17  -incr -mfcu  -sv "+incdir+../../../../../../doc/core_init_mk_III/ipshared/ec67/hdl" "+incdir+../../../../../../doc/core_init_mk_III/ipshared/a317/hdl" \
"../../../../../../doc/core_init_mk_III/ipshared/a317/hdl/zynq_ultra_ps_e_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../../../doc/core_init_mk_III/ipshared/ec67/hdl" "+incdir+../../../../../../doc/core_init_mk_III/ipshared/a317/hdl" \
"../../../bd/core_init_mk_III/ip/core_init_mk_III_zynq_ultra_ps_e_0_0/sim/core_init_mk_III_zynq_ultra_ps_e_0_0_vip_wrapper.v" \

vcom -work xil_defaultlib  -93  \
"../../../bd/core_init_mk_III/sim/core_init_mk_III.vhd" \


vlog -work xil_defaultlib \
"glbl.v"

