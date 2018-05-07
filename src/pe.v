`timescale 1ns / 1ps  

module pe (in0, in1, in2, in3, w_r, w_i, en, out0, out1, out2, out3);
	
	input [15:0] in0, in1, in2, in3, w_r, w_i;
	input en;
	output [15:0] out0, out1, out2, out3; //reg

	wire [15:0] multi_r, multi_i;
	

	assign out0 = in0 + in1;
	assign out1 = in2 + in3;

	complex_mul multi(in0+in1, in2+in3, w_r, w_i, multi_r, multi_i);

	mux21 m31 (in0+in1, multi_r, en, out2);
	mux21 m32 (in2+in3, multi_i, en, out3);
	

endmodule
