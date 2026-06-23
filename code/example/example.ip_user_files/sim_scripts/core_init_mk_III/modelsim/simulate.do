onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc"  -L xlslice_v1_0_4 -L xil_defaultlib -L axi_infrastructure_v1_1_0 -L axi_vip_v1_1_17 -L zynq_ultra_ps_e_vip_v1_0_17 -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.core_init_mk_III xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {core_init_mk_III.udo}

run 1000ns

quit -force
