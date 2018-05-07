`timescale 1ns / 1ps

module testbench ();
  parameter ADDR_BIT = 3;
  parameter DATA_BIT = 16;
  parameter N = 32;
  parameter n = 5;
  parameter MEM_HEIGHT = N / 4;

  /* all the input data is stored here */  
  //reg [DATA_BIT * MEM_HEIGHT * 4 - 1 : 0] input_data;
  parameter [DATA_BIT - 1 : 0] input_data[0 : N - 1] = '{16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1};
  parameter [DATA_BIT - 1 : 0] twiddle_r[0 : N / 2 - 1] = '{16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1};
  parameter [DATA_BIT - 1 : 0] twiddle_i[0 : N / 2 - 1] = '{16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1};

  reg [DATA_BIT - 1 : 0] in0, in1, in2, in3, w_r, w_i;
  reg m0, m11, m14, m21, m22, m23, m24, bypass_en, clk;
  wire [DATA_BIT - 1 : 0] mem0, mem1, mem2, mem3;
  reg [1 : 0] m12, m13;
  reg [ADDR_BIT * 4 - 1 : 0] addr_read, addr_write;
  reg [ADDR_BIT - 1 : 0] upcounter;
  reg [ADDR_BIT - 1 : 0] read_s_index;
  reg start;
  reg rst;
  reg prepare_data;
  reg [2 : 0] stage;
  rfft_4pt u (in0, in1, in2, in3, mem0, mem1, mem2, mem3, m0, m11, m12, m13, m14, m21, m22, m23, m24, w_r, w_i, bypass_en, addr_read, addr_write, clk);
  
  /* cycle counter for each stage */
  always @(posedge clk)
	if (rst)
		upcounter <= 0;
	else if (start)
		upcounter <= upcounter + 1;
	
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
		addr_write[11 : 9] = upcounter;
		addr_write[8 : 6] = upcounter;
		addr_write[5 : 3] = upcounter;
		addr_write[2 : 0] = upcounter;
		in0 = input_data[upcounter];
		in1 = input_data[MEM_HEIGHT + upcounter];
		in2 = input_data[MEM_HEIGHT * 2 + upcounter];
		in3 = input_data[MEM_HEIGHT * 3 + upcounter];
		end
	else
		begin
		addr_read[11 : 9] = upcounter;
		addr_read[8 : 6] = upcounter;
		addr_read[5 : 3] = read_s_index;
		addr_read[2 : 0] = read_s_index;
		addr_write[11 : 9] = upcounter;
		addr_write[8 : 6] = upcounter;
		addr_write[5 : 3] = read_s_index;
		addr_write[2 : 0] = read_s_index;
		end
	end

  /* control signals */
  always @(upcounter or stage)
	begin
	case (stage)
		3'b000: begin
			end 
		3'b001: begin
			m11 = 0;
			m12 = 2;
			m13 = 0;
			m14 = 1;
			if (upcounter[n - 3] == 1) 
				begin
				m21 = 1;
				m22 = 1;
				m23 = 0;
				m23 = 0;
				end
			else
				begin
				m21 = 0;
				m22 = 0;
				m23 = 1;
				m24 = 1;
				end
			end
   		3'b010: begin
			if (upcounter[n - 3] == 0)
				begin
				m11 = 0;
				m12 = 1;
				m13 = 1;
				m14 = 1;
				end
			else
				begin
				m11 = 1;
				m12 = 0;
				m13 = 2;
				m14 = 0;
				end
			if (upcounter[n - 4] == 1) 
				begin
				m21 = 1;
				m22 = 1;
				m23 = 0;
				m23 = 0;
				end
			else
				begin
				m21 = 0;
				m22 = 0;
				m23 = 1;
				m24 = 1;
				end
			end
		3'b011: begin
			if (upcounter[n - 3] == 0 && upcounter[n - 4] == 0)
				begin
				m11 = 0;
				m12 = 1;
				m13 = 1;
				m14 = 1;
				end
			else if (upcounter[n - 4] == 1)
				begin
				m11 = 1;
				m12 = 0;
				m13 = 2;
				m14 = 1;
				end
			else
				begin
				m11 = 0;
				m12 = 2;
				m13 = 0;
				m14 = 1;
				end
			if (upcounter[0] == 1) 
				begin
				m21 = 1;
				m22 = 1;
				m23 = 0;
				m23 = 0;
				end
			else
				begin
				m21 = 0;
				m22 = 0;
				m23 = 1;
				m24 = 1;
				end
			end
		3'b100: begin
			if (upcounter[n - 3 : 0] == 0)
				begin
				m11 = 0;
				m12 = 1;
				m13 = 1;
				m14 = 1;
				end
			else if (upcounter[0] == 1)
				begin
				m11 = 1;
				m12 = 0;
				m13 = 2;
				m14 = 1;
				end
			else
				begin
				m11 = 0;
				m12 = 2;
				m13 = 0;
				m14 = 1;
				end
			m21 = 0;
			m22 = 0;
			m23 = 1;
			m23 = 1;
			end
		3'b101: begin
			m11 = 0;
			m12 = 1;
			m13 = 1;
			m14 = 1;
			end
		default: begin
			 m11 = 0;
			 m12 = 1;
			 m13 = 1;
			 m14 = 1;
			 end
	endcase
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
	
	
	#40
	prepare_data = 0;	
	upcounter = 3'b111;
	stage = 0;
	m0 = 1;
			
	
    
  end

  always
    #5 clk = ~clk;

endmodule // testbench
