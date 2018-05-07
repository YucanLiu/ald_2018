`timescale 1ns / 1ps  

module rfft_4pt256(in0, in1, in2, in3, mem0_i, mem1_i, mem2_i, mem3_i, mem0_o, mem1_o, mem2_o, mem3_o, m0, m11, m12, m13, m14, m21, m22, m23, m24, en, we, re, w_r, w_i, bypass_en, addr_read, addr_write, clk);

  	parameter ADDR_BIT = 6;

	input [15:0] in0, in1, in2, in3;
	wire [15:0] out0, out1, out2, out3;
	input [15:0] w_r, w_i;
	input m0, m11, m14, m21, m22, m23, m24, bypass_en, clk;
	input [1:0] m12, m13;
	input en, we, re;
	input [ADDR_BIT*4 -1 : 0] addr_read, addr_write;

	wire [15:0] m0o0, m0o1, m0o2, m0o3; // output of m0 mux

	//wire [15:0] d0, d1, d2, d3;
	wire [15:0] m11o, m12o, m13o, m14o; // output of m1 muxes

	wire [15:0] dout0, dout1, dout2, dout3;
	output [15:0] mem0_o, mem1_o, mem2_o, mem3_o;
	wire [15:0] mem0, mem1, mem2, mem3;	
	output [15:0] mem0_i, mem1_i, mem2_i, mem3_i;

	// MUX m0
	mux21 mux_m00 (in0, out0, m0, m0o0);
	mux21 mux_m01 (in1, out1, m0, m0o1);
	mux21 mux_m02 (in2, out2, m0, m0o2);
	mux21 mux_m03 (in3, out3, m0, m0o3);


	// RAM bank
	ram_bank256 r0 (clk, en, we, re, addr_write[ADDR_BIT -1 : 0], m0o0, addr_read[ADDR_BIT - 1 : 0], mem0);
	ram_bank256 r1 (clk, en, we, re, addr_write[ADDR_BIT*2 -1 : ADDR_BIT], m0o1, addr_read[ADDR_BIT*2 - 1 : ADDR_BIT], mem1);
	ram_bank256 r2 (clk, en, we, re, addr_write[ADDR_BIT*3 -1 : ADDR_BIT*2], m0o2, addr_read[ADDR_BIT*3 - 1 : ADDR_BIT*2], mem2);
	ram_bank256 r3 (clk, en, we, re, addr_write[ADDR_BIT*4 -1 : ADDR_BIT*3], m0o3, addr_read[ADDR_BIT*4 - 1 : ADDR_BIT*3], mem3);
	

	// MUX m11 - m14
	mux21 mux_m11 (mem0, mem2, m11, m11o);
	mux31 mux_m12 (mem0, mem1, mem2, m12, m12o);
	mux31 mux_m13 (mem1, mem2, mem3, m13, m13o);
	mux21 mux_m14 (mem1, mem3, m14, m14o);

	

	// PE section
	pe pe (m11o, m12o, m13o, m14o, w_r, w_i, bypass_en, dout0, dout1, dout2, dout3);

	// MUX m21 - m24
	mux21 mux_m21 (dout0, dout2, m21, out0);
	mux21 mux_m22 (dout1, dout3, m22, out1);
	mux21 mux_m23 (dout0, dout2, m23, out2);
	mux21 mux_m24 (dout1, dout3, m24, out3);
	
	assign mem0_i = m0o0;
	assign mem1_i = m0o1;
	assign mem2_i = m0o2;
	assign mem3_i = m0o3;
	assign mem0_o = mem0;
	assign mem1_o = mem1;
	assign mem2_o = mem2;
	assign mem3_o = mem3;
endmodule
