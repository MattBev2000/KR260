transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xlslice_v1_0_4
vlib riviera/xil_defaultlib
vlib riviera/axi_infrastructure_v1_1_0
vlib riviera/axi_vip_v1_1_17
vlib riviera/zynq_ultra_ps_e_vip_v1_0_17

vmap xlslice_v1_0_4 riviera/xlslice_v1_0_4
vmap xil_defaultlib riviera/xil_defaultlib
vmap axi_infrastructure_v1_1_0 riviera/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_17 riviera/axi_vip_v1_1_17
vmap zynq_ultra_ps_e_vip_v1_0_17 riviera/zynq_ultra_ps_e_vip_v1_0_17

vlog -work xlslice_v1_0_4  -incr -v2k5 "+incdir+../../../../../../doc/core_init_mk_III/ipshared/ec67/hdl" "+incdir+../../../../../../doc/core_init_mk_III/ipshared/a317/hdl" -l xlslice_v1_0_4 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l zynq_ultra_ps_e_vip_v1_0_17 \
"../../../../../../doc/core_init_mk_III/ipshared/a97c/hdl/xlslice_v1_0_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../../../doc/core_init_mk_III/ipshared/ec67/hdl" "+incdir+../../../../../../doc/core_init_mk_III/ipshared/a317/hdl" -l xlslice_v1_0_4 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l zynq_ultra_ps_e_vip_v1_0_17 \
"../../../bd/core_init_mk_III/ip/core_init_mk_III_xlslice_0_0/sim/core_init_mk_III_xlslice_0_0.v" \

vlog -work axi_infrastructure_v1_1_0  -incr -v2k5 "+incdir+../../../../../../doc/core_init_mk_III/ipshared/ec67/hdl" "+incdir+../../../../../../doc/core_init_mk_III/ipshared/a317/hdl" -l xlslice_v1_0_4 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l zynq_ultra_ps_e_vip_v1_0_17 \
"../../../../../../doc/core_init_mk_III/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_17  -incr "+incdir+../../../../../../doc/core_init_mk_III/ipshared/ec67/hdl" "+incdir+../../../../../../doc/core_init_mk_III/ipshared/a317/hdl" -l xlslice_v1_0_4 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l zynq_ultra_ps_e_vip_v1_0_17 \
"../../../../../../doc/core_init_mk_III/ipshared/4d04/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work zynq_ultra_ps_e_vip_v1_0_17  -incr "+incdir+../../../../../../doc/core_init_mk_III/ipshared/ec67/hdl" "+incdir+../../../../../../doc/core_init_mk_III/ipshared/a317/hdl" -l xlslice_v1_0_4 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l zynq_ultra_ps_e_vip_v1_0_17 \
"../../../../../../doc/core_init_mk_III/ipshared/a317/hdl/zynq_ultra_ps_e_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../../../doc/core_init_mk_III/ipshared/ec67/hdl" "+incdir+../../../../../../doc/core_init_mk_III/ipshared/a317/hdl" -l xlslice_v1_0_4 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l zynq_ultra_ps_e_vip_v1_0_17 \
"../../../bd/core_init_mk_III/ip/core_init_mk_III_zynq_ultra_ps_e_0_0/sim/core_init_mk_III_zynq_ultra_ps_e_0_0_vip_wrapper.v" \

vcom -work xil_defaultlib -93  -incr \
"../../../bd/core_init_mk_III/sim/core_init_mk_III.vhd" \


vlog -work xil_defaultlib \
"glbl.v"

