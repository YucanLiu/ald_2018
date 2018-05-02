`timescale 1ns / 1ps

module ram_bank(clk, en, we, re, addr_w, d_w, addr_r, d_r);

  parameter ADDR_BIT = 3;
  parameter DATA_BIT = 16;
  parameter MEM_HEIGHT = 8;

  input clk, en, we, re;
  input [DATA_BIT-1 : 0] d_w;
  input [ADDR_BIT-1 : 0] addr_w;

  input [ADDR_BIT-1 : 0] addr_r;
  output [DATA_BIT - 1 : 0] d_r;

  reg [DATA_BIT-1 : 0] mem [0 : MEM_HEIGHT-1];
  reg [DATA_BIT-1 : 0] d_r_o;

  always @ ( posedge clk ) begin

    if (en) begin
      if (we) begin
        mem[addr_w] <= d_w;
      end
      if (re) begin
        d_r_o <= mem[addr_r];
      end
    end

  end

  assign d_r = d_r_o;

endmodule // ram_bank
