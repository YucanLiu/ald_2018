`timescale 1ns / 1ps  

module complex_mul(in1, in2, w_r, w_i, out1, out2);

	input [15:0] in1, in2, w_r, w_i;
	//wire [31:0] tempinput1, tempinput2; 
	wire [31:0] temp1, temp2; 
	//output [15:0] out1, out2;
	output [16:0] out1, out2;
	
	//wire symbol1, symbol2;
	//assign simbol1 = in1[15];
	//assign simbol2 = in2[15];
	//assign tempinput1 = {{16{in1[15]}}, in1};
	//assign tempinput2 = {{16{in2[15]}}, in2};
	//assign w_r32 = {{16{w_r[15]}}, w_r};
	//assign w_i32 = {{16{w_i[15]}}, w_i};

	assign temp1 = in1 * w_r - in2 * w_i;//(tempinput1*w_r32);//-(tempinput1*w_i32);
	assign temp2 = in1 * w_i + in2 * w_r;//(tempinput2*w_i32);//+(tempinput2*w_r32);

	assign out1 = temp1;//[23:8];
	assign out2 = temp2;//[23:8];

endmodule
