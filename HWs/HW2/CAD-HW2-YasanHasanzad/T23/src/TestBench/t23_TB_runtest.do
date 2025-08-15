SetActiveLib -work
comp -include "$dsn\src\T23.vhd" 
comp -include "$dsn\src\TestBench\t23_TB.vhd" 
asim +access +r TESTBENCH_FOR_t23 
wave 
wave -noreg a
wave -noreg b
wave -noreg cin
wave -noreg sin
wave -noreg func
wave -noreg sout
wave -noreg cout
wave -noreg ov
wave -noreg z
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\t23_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_t23 
