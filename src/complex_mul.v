`timescale 1ns / 1ps  

module complex_mul(in1, in2, w_r, w_i, out1, out2);

	input [15:0] in1, in2, w_r, w_i;

	output [15:0] out1, out2; 

	assign out1 = (in1*w_r)-(in2*w_i);
	assign out2 = (in1*w_i)+(in2*w_r);

endmodule
