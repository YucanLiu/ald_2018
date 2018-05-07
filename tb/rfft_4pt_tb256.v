`timescale 1ns / 1ps

module testbench ();
  parameter ADDR_BIT = 6;
  parameter DATA_BIT = 16;
  parameter N = 256;
  parameter n = 8;
  parameter MEM_HEIGHT = N / 4;

  /* all the input data is stored here */  
  //reg [DATA_BIT * MEM_HEIGHT * 4 - 1 : 0] input_data;
  parameter [DATA_BIT - 1 : 0] input_data[0 : N - 1] = '{16'b0, {15'b0, 1'b1}, {14'b0, 2'b10}, {14'b0, 2'b11}, {13'b0, 3'b100}, {13'b0, 3'b101}, {13'b0, 3'b110}, {13'b0, 3'b111}, {12'b0, 4'b1000}, {12'b0, 4'b1001}, {12'b0, 4'b1010}, {12'b0, 4'b1011}, {12'b0, 4'b1100}, {12'b0, 4'b1101}, {12'b0, 4'b1110}, {12'b0, 4'b1111}, {11'b0, 5'b10000}, {11'b0, 5'b10001}, {11'b0, 5'b10010}, {11'b0, 5'b10011}, {11'b0, 5'b10100}, {11'b0, 5'b10101}, {11'b0, 5'b10110}, {11'b0, 5'b10111}, {11'b0, 5'b11000}, {11'b0, 5'b11001}, {11'b0, 5'b11010}, {11'b0, 5'b11011}, {11'b0, 5'b11100}, {11'b0, 5'b11101}, {11'b0, 5'b11110}, {11'b0,5'b11111}};
   parameter [DATA_BIT - 1 : 0] twiddle_r[0 : N / 2 - 1] = '{16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1};
   parameter [DATA_BIT - 1 : 0] twiddle_i[0 : N / 2 - 1] = '{16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1};

  reg [DATA_BIT - 1 : 0] in0, in1, in2, in3, w_r, w_i;
  reg m0, m11, m14, m21, m22, m23, m24, bypass_en, clk;
  wire [DATA_BIT - 1 : 0] mem0, mem1, mem2, mem3;
  wire [DATA_BIT - 1 : 0] mem0_i, mem1_i, mem2_i, mem3_i;
  reg [1 : 0] m12, m13;
  reg en, re, we;
  reg [ADDR_BIT * 4 - 1 : 0] addr_read, addr_write;
  reg [ADDR_BIT - 1 : 0] upcounter;
  reg [ADDR_BIT - 1 : 0] read_s_index;
  reg start;
  reg rst;
  reg prepare_data;
  reg [3 : 0] stage;
  rfft_4pt u (in0, in1, in2, in3, mem0_i, mem1_i, mem2_i, mem3_i, mem0, mem1, mem2, mem3, m0, m11, m12, m13, m14, m21, m22, m23, m24, en, we, re, w_r, w_i, bypass_en, addr_read, addr_write, clk);
  
  /* cycle counter for each stage */
  always @(posedge clk)
	if (rst)
		upcounter <= 0;
	else if (start)
		upcounter <= upcounter + 1;
		//upcounter <= 3'b101;
	
  /* twiddle setup */
  always @(upcounter or stage)
	case (stage)
		3'b000: begin
			w_r = twiddle_r[upcounter];
			w_i = twiddle_i[upcounter];
			bypass_en = 1;
			end
		3'b001: begin
			w_r = twiddle_r[upcounter];
			w_i = twiddle_i[upcounter];
			bypass_en = 1;
			end
		3'b010: begin
			w_r = twiddle_r[upcounter];
			w_i = twiddle_i[upcounter];
			bypass_en = 1;
			end
		3'b011: begin
			w_r = twiddle_r[upcounter];
			w_i = twiddle_i[upcounter];
			bypass_en = 1;
			end
		3'b100: begin
			w_r = twiddle_r[upcounter];
			w_i = twiddle_i[upcounter];
			bypass_en = 0;
			end
		3'b101: begin
			w_r = twiddle_r[upcounter];
			w_i = twiddle_i[upcounter];
			bypass_en = 0;
			end
		default: begin
			 w_r = twiddle_r[upcounter];
			 w_i = twiddle_i[upcounter];
			 bypass_en = 0;
			 end
	endcase

  /* stage counter */
  always @(upcounter /*or prepare_data*/)
	if (upcounter == 3'b000)
		stage = stage + 1;

  /* load data control */
  always @(upcounter or stage)
	begin
	case (stage)
		3'b000: read_s_index = upcounter;
		3'b001: read_s_index = upcounter;
		3'b010: read_s_index = MEM_HEIGHT / 2 + upcounter >= MEM_HEIGHT ? MEM_HEIGHT / 2 + upcounter - MEM_HEIGHT : MEM_HEIGHT / 2 + upcounter;
		3'b011: read_s_index = MEM_HEIGHT / 4 * 3 + upcounter >= MEM_HEIGHT ? MEM_HEIGHT / 4 * 3 + upcounter - MEM_HEIGHT : MEM_HEIGHT / 4 * 3 + upcounter;
		3'b100: read_s_index = MEM_HEIGHT / 8 * 7 + upcounter >= MEM_HEIGHT ? MEM_HEIGHT / 8 * 7 + upcounter - MEM_HEIGHT : MEM_HEIGHT / 8 * 7 + upcounter;
		3'b101: read_s_index = MEM_HEIGHT / 2 + upcounter >= MEM_HEIGHT ? MEM_HEIGHT / 2 + upcounter - MEM_HEIGHT : MEM_HEIGHT / 2 + upcounter;
		3'b110: read_s_index = MEM_HEIGHT / 2 + upcounter >= MEM_HEIGHT ? MEM_HEIGHT / 2 + upcounter - MEM_HEIGHT : MEM_HEIGHT / 2 + upcounter;
		3'b111: read_s_index = MEM_HEIGHT / 2 + upcounter >= MEM_HEIGHT ? MEM_HEIGHT / 2 + upcounter - MEM_HEIGHT : MEM_HEIGHT / 2 + upcounter;
	endcase
	end

  /* load data control */
  always @(upcounter)
	begin
	if (prepare_data)
		begin
		addr_write[2 : 0] = 7;
		addr_write[5 : 3] = 7;
		addr_write[8 : 6] = 7;
		addr_write[11 : 9] = 7;
		//in0 = input_data[upcounter];
		//in1 = input_data[MEM_HEIGHT + upcounter];
		//in2 = input_data[MEM_HEIGHT * 2 + upcounter];
		//in3 = input_data[MEM_HEIGHT * 3 + upcounter];
		in0 = input_data[0];
		in1 = input_data[MEM_HEIGHT];
		in2 = input_data[MEM_HEIGHT * 2];
		in3 = input_data[MEM_HEIGHT * 3];
		end
	else
		begin
		addr_read[2 : 0] = 7;
		addr_read[5 : 3] = 7;
		addr_read[8 : 6] = 7;//read_s_index;
		addr_read[11 : 9] = 7;
		addr_write[2 : 0] = 7;
		addr_write[5 : 3] = 7;//upcounter;
		addr_write[8 : 6] = 7;//upcounter;
		addr_write[11 : 9] = 7;//upcounter;
		end
	end

  /* control signals */
  always @(upcounter or stage)
	begin
		m11 = 0;
		m12 = 1;
		m13 = 1;
		m14 = 1;
		m21 = 0;
		m22 = 0;
		m23 = 1;
		m24 = 1;
	end

  /* data input */
  

  initial begin
	clk = 1;
	rst = 1;
	#20
	rst = 0;
	start = 1;
	upcounter = 3'b111;
	stage = 0;
	m0 = 0;
	prepare_data = 1;
	en = 1;
	re = 1;
	we = 1;
	
	#80
	we = 0;
	#20
	re = 1;
	en = 1;
	
	
	#80
	prepare_data = 0;	
	upcounter = 3'b111;
	stage = 0;
	m0 = 1;
			
	
    
  end

  always
    #5 clk = ~clk;

endmodule // testbench
