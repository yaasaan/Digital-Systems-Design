SetActiveLib -work
comp -include "$dsn\src\T32.vhd" 
comp -include "$dsn\src\TestBench\t32_TB.vhd" 
asim +access +r TESTBENCH_FOR_t32 
wave 
wave -noreg clk
wave -noreg reset
wave -noreg command
wave -noreg dataIn
wave -noreg dataOut
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\t32_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_t32 
