`timescale 1ns / 1ps  

module testbench ();
	
	reg[15:0] in1, in2, in3;
	reg[1:0] sel;
	wire[15:0] out;

	mux31 u (in1, in2, in3, sel, out);

initial
begin
	in1 = 0;
	in2 = 0;
	in3 = 0;
	sel = 0;

	#50 in1 = 1;
	in2 = 2;
	in3 = 3;
	sel = 2'b00;

	#50 sel = 2'b01;

	#50 sel = 2'b10;

	#50;
end

endmodule
