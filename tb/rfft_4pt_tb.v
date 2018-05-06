`timescale 1ns / 1ps

module testbench ();
  parameter ADDR_BIT = 3;
  parameter DATA_BIT = 16;
  parameter MEM_HEIGHT = 8;

  reg [15:0] in0, in1, in2, in3, w_r, w_i;
  reg m0, m11, m14, m21, m22, m23, m24, bypass_en, clk;
  wire [15:0] mem0, mem1, mem2, mem3;
  reg [1:0] m12, m13;
  reg [ADDR_BIT*4 - 1: 0] addr_read, addr_write;
  reg [2:0] upcounter;
  rfft_4pt u (in0, in1, in2, in3, mem0, mem1, mem2, mem3, m0, m11, m12, m13, m14, m21, m22, m23, m24, w_r, w_i, bypass_en, addr_read, addr_write, clk);
  //always @(posedge clk)
//	upcounter <= upcounter + 1;

  initial begin
	clk = 1;
		in0 = 2;
		in1 = 3;
		in2 = 12;
		in3 = 20;
		w_r = 6;
		w_i = 7;
		m0 = 0;
		m11 = 1'b0;
		m12 = 2'b1;
		m13 = 2'b1;
		m14 = 1'b1;
		m21 = 0;
		m22 = 0;
		m23 = 1;
		m24 = 1;
		bypass_en = 1;
		addr_read = 12'b001010011100;
		addr_write = 12'b001010011100;
			
	#50
		in0 = 3;
		in1 = 4;
		in2 = 30;
		in3 = 40;
		w_r = 8;
		w_i = 9;
		m0 = 1;
		m11 = 0;
		m12 = 1;
		m13 = 1;
		m14 = 1;
		m21 = 0;
		m22 = 0;
		m23 = 1;
		m24 = 1;
		bypass_en = 1;
		addr_read = 12'b001010011100;
		addr_write = 12'b001010011100;
			
	
    
  end

  always
    #5 clk = ~clk;

endmodule // testbench
