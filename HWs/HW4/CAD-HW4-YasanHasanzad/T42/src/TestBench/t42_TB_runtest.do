SetActiveLib -work
comp -include "$dsn\src\T42.vhd" 
comp -include "$dsn\src\TestBench\t42_TB.vhd" 
asim +access +r TESTBENCH_FOR_t42 
wave 
wave -noreg clk
wave -noreg reset
wave -noreg output
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\t42_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_t42 
