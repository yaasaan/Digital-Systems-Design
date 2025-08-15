SetActiveLib -work
comp -include "$dsn\src\T33.vhd" 
comp -include "$dsn\src\TestBench\t33_TB.vhd" 
asim +access +r TESTBENCH_FOR_t33 
wave 
wave -noreg clk
wave -noreg reset
wave -noreg x
wave -noreg a
wave -noreg b
wave -noreg z
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\t33_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_t33 
