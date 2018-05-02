onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -radix decimal :testbench:in0
add wave -noupdate -radix decimal :testbench:in1
add wave -noupdate -radix decimal :testbench:in2
add wave -noupdate -radix decimal :testbench:in3
add wave -noupdate -radix decimal :testbench:w_r
add wave -noupdate -radix decimal :testbench:w_i
add wave -noupdate -radix binary :en
add wave -noupdate -radix decimal :testbench:out0
add wave -noupdate -radix decimal :testbench:out1
add wave -noupdate -radix decimal :testbench:out2
add wave -noupdate -radix decimal :testbench:out3



TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 223
configure wave -valuecolwidth 89
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ns} {12 ns}