onerror {quit -f}
vlib work
vlog -work work MazeRAMTester.vo
vlog -work work MazeRAMTester.vt
vsim -novopt -c -t 1ps -L cycloneiii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.MazeRAMTester_vlg_vec_tst
vcd file -direction MazeRAMTester.msim.vcd
vcd add -internal MazeRAMTester_vlg_vec_tst/*
vcd add -internal MazeRAMTester_vlg_vec_tst/i1/*
add wave /*
run -all
