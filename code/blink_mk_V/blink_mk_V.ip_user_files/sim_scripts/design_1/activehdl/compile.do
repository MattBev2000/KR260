transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib activehdl/xlslice_v1_0_4
vlib activehdl/xil_defaultlib
vlib activehdl/axi_infrastructure_v1_1_0
vlib activehdl/axi_vip_v1_1_17
vlib activehdl/zynq_ultra_ps_e_vip_v1_0_17

vmap xlslice_v1_0_4 activehdl/xlslice_v1_0_4
vmap xil_defaultlib activehdl/xil_defaultlib
vmap axi_infrastructure_v1_1_0 activehdl/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_17 activehdl/axi_vip_v1_1_17
vmap zynq_ultra_ps_e_vip_v1_0_17 activehdl/zynq_ultra_ps_e_vip_v1_0_17

vlog -work xlslice_v1_0_4  -v2k5 "+incdir+../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/a317/hdl" -l xlslice_v1_0_4 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l zynq_ultra_ps_e_vip_v1_0_17 \
"../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/a97c/hdl/xlslice_v1_0_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/a317/hdl" -l xlslice_v1_0_4 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l zynq_ultra_ps_e_vip_v1_0_17 \
"../../../bd/design_1/ip/design_1_xlslice_0_0/sim/design_1_xlslice_0_0.v" \

vlog -work axi_infrastructure_v1_1_0  -v2k5 "+incdir+../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/a317/hdl" -l xlslice_v1_0_4 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l zynq_ultra_ps_e_vip_v1_0_17 \
"../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_17  -sv2k12 "+incdir+../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/a317/hdl" -l xlslice_v1_0_4 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l zynq_ultra_ps_e_vip_v1_0_17 \
"../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/4d04/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work zynq_ultra_ps_e_vip_v1_0_17  -sv2k12 "+incdir+../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/a317/hdl" -l xlslice_v1_0_4 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l zynq_ultra_ps_e_vip_v1_0_17 \
"../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/a317/hdl/zynq_ultra_ps_e_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../blink_mk_V.gen/sources_1/bd/design_1/ipshared/a317/hdl" -l xlslice_v1_0_4 -l xil_defaultlib -l axi_infrastructure_v1_1_0 -l axi_vip_v1_1_17 -l zynq_ultra_ps_e_vip_v1_0_17 \
"../../../bd/design_1/ip/design_1_zynq_ultra_ps_e_0_0/sim/design_1_zynq_ultra_ps_e_0_0_vip_wrapper.v" \

vcom -work xil_defaultlib -93  \
"../../../bd/design_1/sim/design_1.vhd" \


vlog -work xil_defaultlib \
"glbl.v"

