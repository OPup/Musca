onerror {quit -f}
vlib work
vlog -work work TestBench.vo
vlog -work work TestBench.vt
vsim -novopt -c -t 1ps -L cycloneiii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.TestBench_vlg_vec_tst
vcd file -direction TestBench.msim.vcd
vcd add -internal TestBench_vlg_vec_tst/*
vcd add -internal TestBench_vlg_vec_tst/i1/*
add wave /*
run -all
