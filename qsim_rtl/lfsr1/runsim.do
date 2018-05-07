##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work
vmap work work

# Include Netlist and Testbench
vlog -incr /homes/user/spring18/wb2331/study/ald_2018/src/complex_mul.v
vlog -incr /homes/user/spring18/wb2331/study/ald_2018/src/ram_bank256.v
vlog -incr /homes/user/spring18/wb2331/study/ald_2018/src/mux21.v
vlog -incr /homes/user/spring18/wb2331/study/ald_2018/src/mux31.v
vlog -incr /homes/user/spring18/wb2331/study/ald_2018/src/pe.v
vlog -incr /homes/user/spring18/wb2331/study/ald_2018/src/rfft_4pt256.v
vlog -incr /homes/user/spring18/wb2331/study/ald_2018/src/top_level.v

vlog -incr /homes/user/spring18/wb2331/study/ald_2018/tb/top_level_tb256.v  

# Run Simulator
vsim -t ns -lib work testbench
do waveformat.do
run -all
