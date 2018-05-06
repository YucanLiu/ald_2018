`timescale 1ns / 1ps

module testbench();

  parameter ADDR_BIT = 3;
  parameter DATA_BIT = 16;
  parameter MEM_HEIGHT = 8;

  reg clk;
  wire en1, we1, re1;
  wire [DATA_BIT-1 : 0] d_w1;
  wire [ADDR_BIT-1 : 0] addr_w1;
  wire [ADDR_BIT-1 : 0] addr_r1;
  reg mux_en;
  reg [DATA_BIT - 1 : 0] inp;
  wire [DATA_BIT - 1 : 0] calcu_result;
  wire [DATA_BIT - 1 : 0] d_r1;

  assign addr_w1 = 2;
  assign addr_r1 = 2;
  assign en1 = 1;
  assign we1 = 1;
  assign re1 = 1;
  mux21 m(inp, calcu_result, mux_en, d_w1);
  ram_bank r1 (clk, en1, we1, re1, addr_w1, d_w1, addr_r1, d_r1);
  assign calcu_result = d_r1 * 2;
  initial begin
    clk = 1;
    inp = 3;
    mux_en = 0;
    #50;
    mux_en = 1;

 /*   addr_w = 0;
    d_w = 0;
    #10
    addr_w = 1;
    d_w = 1;
    #10
    addr_w = 2;
    d_w = 2;
    #10
    addr_w = 3;
    d_w = 3;
    #10
    addr_w = 4;
    d_w = 4;
    #10
    addr_w = 5;
    d_w = 5;
    #10
    addr_w = 6;
    d_w = 6;
    #10
    addr_w = 7;
    d_w = 7;
    #50;

    re = 1;

    addr_r = 0;
    #10
    addr_r = 1;
    #10
    addr_r = 2;
    #10
    addr_r = 3;
    #10
    addr_r = 4;
    #10
    addr_r = 5;
    #10
    addr_r = 6;
    #10
    addr_r = 7;
    #50;

    we = 1;
    re = 1;

    addr_w = 3;
    d_w = 10;
    addr_r = 3;
    #50;*/

  end

  always
    #5 clk = ~clk;

endmodule
