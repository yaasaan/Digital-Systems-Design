SetActiveLib -work
comp -include "$dsn\src\T43.vhd" 
comp -include "$dsn\src\TestBench\t43_TB.vhd" 
asim +access +r TESTBENCH_FOR_t43 
wave 
wave -noreg clk
wave -noreg reset
wave -noreg x
wave -noreg datain
wave -noreg dataout
wave -noreg valid
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\t43_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_t43 
