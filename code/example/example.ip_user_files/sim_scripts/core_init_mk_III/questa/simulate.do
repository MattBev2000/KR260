onbreak {quit -f}
onerror {quit -f}

vsim  -lib xil_defaultlib core_init_mk_III_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {core_init_mk_III.udo}

run 1000ns

quit -force
