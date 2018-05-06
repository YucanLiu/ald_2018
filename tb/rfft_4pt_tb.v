`timescale 1ns / 1ps

module testbench ();
  parameter ADDR_BIT = 3;
  parameter DATA_BIT = 16;
  parameter MEM_HEIGHT = 8;

  reg [15:0] in0, in1, in2, in3, w_r, w_i;
  reg m0, m11, m14, m21, m22, m23, m24, bypass_en, clk;
  reg [15:0] mem0, mem1, mem2, mem3;
  reg [1:0] m12, m13;
  reg [ADDR_BIT*4 : 0] addr_read, addr_write;

  initial begin
    clk = 1;
    
  end

  always
    #5 clk = ~clk;

endmodule // testbench
