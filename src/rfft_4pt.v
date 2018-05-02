`timescale 1ns / 1ps  

module rfft_4pt(in0, in1, in2, in3, out0, out1, out2, out3, m0, m11, m12, m13, m14, m21, m22, m23, m24, w_r, w_i, en);

	input [15:0] in0, in1, in2, in3;
	inout [15:0] out0, out1, out2, out3;
	input [15:0] w_r, w_i;
	input m0, m11, m14, m21, m22, m23, m24, en;
	input [1:0] m12, m13;

	wire [15:0] m0o0, m0o1, m0o2, m0o3; // output of m0 mux

	wire [15:0] d0, d1, d2, d3;
	wire [15:0] m11o, m12o, m13o, m14o; // output of m1 muxes

	wire [15:0] dout0, dout1, dout2, dout3;
	

	// MUX m0
	2to1 mux_m00 (in0, out0, m0, m0o0);
	2to1 mux_m01 (in1, out1, m0, m0o1);
	2to1 mux_m02 (in2, out2, m0, m0o2);
	2to1 mux_m03 (in3, out3, m0, m0o3);


	// some logic here...
	

	// MUX m11 - m14
	2to1 mux_m11 (d0, d2, m11, m11o);
	3to1 mux_m12 (d0, d1, d2, m12, m12o);
	3to1 mux_m13 (d1, d2, d3, m13, m13o);
	2to1 mux_m14 (d1, d3, m14, m14o);

	

	// PE section
	pe pe (d0, d1, d2, d3, w_r, w_i, en, dout0, dout1, dout2, dout3);

	// MUX m21 - m24
	2to1 mux_m21 (dout0, dout2, m21, out0);
	2to1 mux_m22 (dout1, dout3, m22, out1);
	2to1 mux_m23 (dout0, dout2, m23, out2);
	2to1 mux_m24 (dout1, dout3, m24, out3);
	

endmodule
