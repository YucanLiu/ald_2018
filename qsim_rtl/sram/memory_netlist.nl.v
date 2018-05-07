
`timescale 1 ns/1 ps
`celldefine
module memory_netlist (data_out, clk, cen, wen, addr, data_in);
  
   output [15:0]            data_out;
   input                    clk;
   input                    cen;
   input                    wen;
   input [6:0]              addr;
   input [15:0]             data_in;
   
   memory mem1 (data_out, clk, cen, wen, addr, data_in);

endmodule
`endcelldefine
