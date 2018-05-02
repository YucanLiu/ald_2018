##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist and Testbench
vlog -incr ./memory.v 
vlog -incr ./memory_test.v 

# Run Simulator 
vsim -t ns -lib work memory_test 
do waveformat.do   
run -all
