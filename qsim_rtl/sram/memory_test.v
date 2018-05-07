`timescale 1ns/1ps

module memory_test ();

reg clk, cen, wen;
reg [6:0]addr;
reg [15:0]data_in;
wire [15:0]data_out;

initial
begin
	$dumpfile ("ssc2189.vcd");
	$dumpvars (0, memory_test);
end

memory memory1 (data_out, clk, cen, wen, addr, data_in);

initial
begin
	clk = 1'b1;
	cen = 1'b0;
	wen = 1'b0;
	addr = 7'd0;
	data_in = 16'd0;
	
	#200000 $stop;
end

// cen = 0 for read and write to occur
// cen = 0, wen = 1 for read mode
// cen = 0, wen = 0 for write mode

always
begin
	#100 clk = ~clk;
end

always @(posedge clk)
begin
	if ((addr != 7'b1111_111) && (wen == 1'b0))
	begin
		#220 addr <= addr + 1'b1;
		data_in <= data_in + 1'b1;
		#280 ;
	end
	else
	begin
		#180 wen <= 1'b1;
		addr <= addr + 1'b1;
		#20 ;
	end
	
end

endmodule
