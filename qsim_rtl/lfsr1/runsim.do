##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work
vmap work work

# Include Netlist and Testbench
vlog -incr /homes/user/fall17/yl3791/ald_2018/src/complex_mul.v
vlog -incr /homes/user/fall17/yl3791/ald_2018/src/ram_bank.v
vlog -incr /homes/user/fall17/yl3791/ald_2018/src/mux21.v
vlog -incr /homes/user/fall17/yl3791/ald_2018/src/mux31.v
vlog -incr /homes/user/fall17/yl3791/ald_2018/src/pe.v
vlog -incr /homes/user/fall17/yl3791/ald_2018/src/rfft_4pt.v

vlog -incr /homes/user/fall17/yl3791/ald_2018/tb/rfft_4pt_tb.v  

# Run Simulator
vsim -t ns -lib work testbench
do waveformat.do
run -all
