`timescale 1ns / 1ps  

module testbench ();

	reg [15:0] in0, in1, in2, in3, w_r, w_i;
	reg en;
	wire [15:0] out0, out1, out2, out3;

	pe u(in0, in1, in2, in3, w_r, w_i, en, out0, out1, out2, out3);

initial 
begin
	in0 = 2;
	in1 = 2;
	in2 = 3;
	in3 = 4;
	w_r = 5;
	w_i = 6;
	
	en = 0;
	
#50 
	en = 1;

#50;
end

endmodule
