#################################################
# Primetime 
# Script for static timing analysis
# MS 7/2015
#################################################

#################################################
# Units are defined in the .lib file
# time: ns
#################################################

## Global
set sh_enable_page_mode true
set power_enable_analysis true

## Setting files/paths
set verilog_files {./memory_netlist.nl.v}
#set spef_files {lfsr1.spef}
set my_toplevel memory_netlist
set search_path "."
set link_path "* memory_tt_1p2v_25c_syn.lib" 

## Read design
read_lib "memory_tt_1p2v_25c_syn.lib"
read_verilog $verilog_files
link_design -keep_sub_designs $my_toplevel
#read_parasitics -keep_capacitive_coupling $spef_files

## Timing Constraints
source ./timing.tcl


###################################################
## Run STA 
###################################################
check_timing
report_design
report_reference
report_constraint
report_constraint -all_violators -significant_digits 3
report_timing -significant_digits 3

## Power analysis
#read_vcd -strip_path /testbench/DUT_0 FIR.vcd
#estimate_clock_network_power sc_svtgp_025_res/HS65_GS_BFX4
#update_power
#create_power_waveforms -output "vcd"
#report_power -include_estimated_clock_network
report_power
#report_power -hierarchy
#report_lfsr1ing_activity -average_activity -hierarchy -base_clock $clk_port
#report_lfsr1ing_activity 
 
# Exiting primetime
quit
