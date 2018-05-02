##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist and Testbench
vlog -incr ../../src/mux21.v 
vlog -incr ../../src/complex_mul.v 
vlog -incr ../../src/pe.v 

vlog -incr ../../tb/pe_tb.v  

# Run Simulator 
vsim -t ns -lib work testbench 
do waveformat.do   
run -all
