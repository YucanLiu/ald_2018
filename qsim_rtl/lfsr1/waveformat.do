onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -radix decimal :testbench:in0
add wave -noupdate -radix decimal :testbench:in1
add wave -noupdate -radix decimal :testbench:in2
add wave -noupdate -radix decimal :testbench:in3
add wave -noupdate -radix decimal :testbench:w_r
add wave -noupdate -radix decimal :testbench:w_i
add wave -noupdate -radix binary :testbench:m0
add wave -noupdate -radix binary :testbench:m11
add wave -noupdate -radix binary :testbench:m12
add wave -noupdate -radix binary :testbench:m13
add wave -noupdate -radix binary :testbench:m14
add wave -noupdate -radix binary :testbench:m21
add wave -noupdate -radix binary :testbench:m22
add wave -noupdate -radix binary :testbench:m23
add wave -noupdate -radix binary :testbench:m24
add wave -noupdate -radix binary :testbench:en
add wave -noupdate -radix binary :testbench:we
add wave -noupdate -radix binary :testbench:re
add wave -noupdate -radix binary :testbench:bypass_en
add wave -noupdate -radix binary :testbench:addr_read
add wave -noupdate -radix binary :testbench:addr_write
add wave -noupdate -radix binary :testbench:upcounter
add wave -noupdate -radix binary :testbench:stage
add wave -noupdate -radix binary :testbench:read_s_index
add wave -noupdate -radix binary :testbench:clk
add wave -noupdate -radix binary :testbench:prepare_data
add wave -noupdate -radix decimal :testbench:mem0_i
add wave -noupdate -radix decimal :testbench:mem1_i
add wave -noupdate -radix decimal :testbench:mem2_i
add wave -noupdate -radix decimal :testbench:mem3_i
add wave -noupdate -radix decimal :testbench:mem0
add wave -noupdate -radix decimal :testbench:mem1
add wave -noupdate -radix decimal :testbench:mem2
add wave -noupdate -radix decimal :testbench:mem3
add wave -noupdate -radix decimal :testbench:input_d0;
add wave -noupdate -radix decimal :testbench:input_d1;
add wave -noupdate -radix decimal :testbench:input_d2;
add wave -noupdate -radix decimal :testbench:input_d3;




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
