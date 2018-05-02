##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work
vmap work work

# Include Netlist and Testbench
vlog -incr ../../src/ram_bank.v


vlog -incr ../../tb/ram_bank_tb.v  

# Run Simulator
vsim -t ns -lib work testbench
do waveformat.do
run -all
