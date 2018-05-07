`timescale 1ns / 1ps  

module testbench;
	reg [15:0] in1, in2, w_r, w_i;
	wire [15:0] out1, out2;

	complex_mul u (in1, in2, w_r, w_i, out1, out2);

initial 
begin

	in1 = 0;
	in2 = 0;
	w_r = 0;
	w_i = 0;
#50

	in1 = 2;
	in2 = 3;
	w_r = 4;
	w_i = 5;

#50

	in1 = 3;
	in2 = 4;
	w_r = 5;
	w_i = 6;

#50

	in1 = 0;
	in2 = 0;
	w_r = 0;
	w_i = 0;

end



endmodule


