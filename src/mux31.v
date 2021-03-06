`timescale 1ns / 1ps  

module mux31 (in1, in2, in3, en, out);
	
	input [15:0] in1, in2, in3;
	input [1:0] en;
	output reg [15:0] out;

	always @ (in1 or in2 or in3 or en)
	begin
		case (en)
		2'b00: out = in1;
		2'b01: out = in2;
		2'b10: out = in3;
		default: $display("Error in Mux 3 to 1");
		endcase
	end

endmodule
