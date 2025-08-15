SetActiveLib -work
comp -include "$dsn\src\T41.vhd" 
comp -include "$dsn\src\TestBench\t41_TB.vhd" 
asim +access +r TESTBENCH_FOR_t41 
wave 
wave -noreg clk
wave -noreg reset
wave -noreg x
wave -noreg output
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\t41_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_t41 
