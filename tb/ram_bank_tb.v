`timescale 1ns / 1ps

module testbench();

  parameter ADDR_BIT = 3;
  parameter DATA_BIT = 16;
  parameter MEM_HEIGHT = 8;

  reg clk, en, we, re;
  reg [DATA_BIT-1 : 0] d_w;
  reg [ADDR_BIT-1 : 0] addr_w;

  wire [DATA_BIT - 1 : 0] d_r;
  wire [ADDR_BIT-1 : 0] addr_r;

  ram_bank r1 (clk, en, we, re, addr_w, d_w, addr_r, d_r);

  initial begin
    clk = 0;
    en = 0;
    we = 0;
    re = 0;
    #50;
    en = 1;
    we = 1;
    re = 0;

    addr_w = 0;
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

  end

  always
    #5 clk = ~clk;

endmodule
