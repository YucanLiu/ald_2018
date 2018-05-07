`timescale 1ns / 1ps

module top_level (prepare_data, clk, rst, input_data0, input_data1, input_data2, input_data3, mem0_o, mem1_o, mem2_o, mem3_o);
  parameter ADDR_BIT = 6;
  parameter DATA_BIT = 16;
  parameter N = 256;
  parameter n = 8;
  parameter MEM_HEIGHT = N / 4;

  parameter [DATA_BIT - 1 : 0] twiddle_r[0 : N / 2 - 1] = '{16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1,16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1,16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1,16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1,16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1};
  parameter [DATA_BIT - 1 : 0] twiddle_i[0 : N / 2 - 1] = '{16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1,16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1,16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1,16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1,16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1, 16'b1};

  input clk;
  input rst;
  input prepare_data;
  input [DATA_BIT - 1 : 0] input_data0;//[0 : 3];
  input [DATA_BIT - 1 : 0] input_data1;//[0 : 3];
  input [DATA_BIT - 1 : 0] input_data2;//[0 : 3];
  input [DATA_BIT - 1 : 0] input_data3;//[0 : 3];
  wire [DATA_BIT - 1 : 0] in0, in1, in2, in3;
  reg  w_r, w_i;
  reg m11, m14, m21, m22, m23, m24, bypass_en;
  wire m0;
  wire [DATA_BIT - 1 : 0] mem0_i, mem1_i, mem2_i, mem3_i;
  wire [DATA_BIT - 1 : 0] mem0, mem1, mem2, mem3;
  output [DATA_BIT - 1 : 0] mem0_o, mem1_o, mem2_o, mem3_o;
  reg [1 : 0] m12, m13;
  reg en, re, we;
  reg [ADDR_BIT * 4 - 1 : 0] addr_read, addr_write;
  reg [ADDR_BIT - 1 : 0] upcounter;
  reg [ADDR_BIT - 1 : 0] read_s_index;
  reg start;
  reg [3 : 0] stage;
  rfft_4pt256 u (in0, in1, in2, in3, mem0_i, mem1_i, mem2_i, mem3_i, mem0, mem1, mem2, mem3, m0, m11, m12, m13, m14, m21, m22, m23, m24, en, we, re, w_r, w_i, bypass_en, addr_read, addr_write, clk);
  assign mem0_o = mem0;
  assign mem1_o = mem1;
  assign mem2_o = mem2;
  assign mem3_o = mem3;
 
  assign in0 = input_data0;
  assign in1 = input_data1;
  assign in2 = input_data2;
  assign in3 = input_data3;
  /* cycle counter for each stage */
  always @(posedge clk)
	if (rst)
		upcounter <= 0;
	else
		upcounter <= upcounter + 1;

  /* stage counter */
  always @(upcounter /*or prepare_data*/)
        if (upcounter == 6'b000000 && prepare_data == 0)
                stage = stage + 1;
	
  /* twiddle setup */
  always @(upcounter or stage)
	case (stage)
		4'b0000: begin
			w_r = twiddle_r[upcounter];
			w_i = twiddle_i[upcounter];
			bypass_en = 1;
			end
		4'b0001: begin
			w_r = twiddle_r[upcounter];
			w_i = twiddle_i[upcounter];
			bypass_en = 1;
			end
		4'b0010: begin
			w_r = twiddle_r[upcounter];
			w_i = twiddle_i[upcounter];
			bypass_en = 1;
			end
		4'b0011: begin
			w_r = twiddle_r[upcounter];
			w_i = twiddle_i[upcounter];
			bypass_en = 1;
			end
		4'b0100: begin
			w_r = twiddle_r[upcounter];
			w_i = twiddle_i[upcounter];
			bypass_en = 0;
			end
		4'b0101: begin
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


  /* load data control */
  always @(upcounter or stage)
	begin
	case (stage)
		4'b0000: read_s_index = upcounter;
		4'b0001: read_s_index = upcounter;
		4'b0010: read_s_index = {~upcounter[5], upcounter[4:0]};//MEM_HEIGHT / 2 + upcounter >= MEM_HEIGHT ? MEM_HEIGHT / 2 + upcounter - MEM_HEIGHT : MEM_HEIGHT / 2 + upcounter;
		4'b0011: read_s_index = {~upcounter[5], ~upcounter[4], upcounter[3:0]};//MEM_HEIGHT / 4 * 3 + upcounter >= MEM_HEIGHT ? MEM_HEIGHT / 4 * 3 + upcounter - MEM_HEIGHT : MEM_HEIGHT / 4 * 3 + upcounter;
		4'b0100: read_s_index = {~upcounter[5], ~upcounter[4], ~upcounter[3], upcounter[2:0]};//MEM_HEIGHT / 2 + upcounter >= MEM_HEIGHT ? MEM_HEIGHT / 2 + upcounter - MEM_HEIGHT : MEM_HEIGHT / 2 + upcounter;
		4'b0101: read_s_index = {~upcounter[5], ~upcounter[4], ~upcounter[3], ~upcounter[2], upcounter[1:0]};//MEM_HEIGHT / 2 + upcounter >= MEM_HEIGHT ? MEM_HEIGHT / 2 + upcounter - MEM_HEIGHT : MEM_HEIGHT / 2 + upcounter;
		4'b0110: read_s_index = {~upcounter[5], ~upcounter[4], ~upcounter[3], ~upcounter[2], ~upcounter[1], upcounter[0]};//MEM_HEIGHT / 2 + upcounter >= MEM_HEIGHT ? MEM_HEIGHT / 2 + upcounter - MEM_HEIGHT : MEM_HEIGHT / 2 + upcounter;
		4'b0111: read_s_index = {~upcounter[5], ~upcounter[4], ~upcounter[3], ~upcounter[2], ~upcounter[1], ~upcounter[0]};//MEM_HEIGHT / 2 + upcounter >= MEM_HEIGHT ? MEM_HEIGHT / 2 + upcounter - MEM_HEIGHT : MEM_HEIGHT / 2 + upcounter;
		4'b1000: read_s_index = {6'b0};//MEM_HEIGHT / 8 * 7 + upcounter >= MEM_HEIGHT ? MEM_HEIGHT / 8 * 7 + upcounter - MEM_HEIGHT : MEM_HEIGHT / 8 * 7 + upcounter;
	endcase
	end

  /* load data control */
  always @(upcounter)
	begin
	if (prepare_data)
		begin
		addr_write[5 : 0] = upcounter;
		addr_write[11 : 6] = upcounter;
		addr_write[17 : 12] = upcounter;
		addr_write[23 : 18] = upcounter;
		addr_read[5 : 0] = upcounter;
		addr_read[11 : 6] = upcounter;
		addr_read[17 : 12] = upcounter;
		addr_read[23 : 18] = upcounter;
		end
	else
		begin
		addr_read[5 : 0] = upcounter;
		addr_read[11 : 6] = upcounter;
		addr_read[17 : 12] = read_s_index;
		addr_read[23 : 18] = read_s_index;
		addr_write[5 : 0] = upcounter;
		addr_write[11 : 6] = upcounter;
		addr_write[17 : 12] = read_s_index;
		addr_write[23 : 18] = read_s_index;
		end
	end

  /* control signals */
  always @(upcounter or stage)
	begin
	case (stage)
		4'b0000: begin
			end 
		4'b0001: begin
			m11 = 0;
			m12 = 2;
			m13 = 0;
			m14 = 1;
			if (upcounter[n - 3] == 1) 
				begin
				m21 = 1;
				m22 = 1;
				m23 = 0;
				m24 = 0;
				end
			else
				begin
				m21 = 0;
				m22 = 0;
				m23 = 1;
				m24 = 1;
				end
			end
   		4'b0010: begin
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
				m24 = 0;
				end
			else
				begin
				m21 = 0;
				m22 = 0;
				m23 = 1;
				m24 = 1;
				end
			end
		4'b0011: begin
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
				m14 = 0;
				end
			else
				begin
				m11 = 0;
				m12 = 2;
				m13 = 0;
				m14 = 1;
				end
			if (upcounter[n - 4] == 1) 
				begin
				m21 = 1;
				m22 = 1;
				m23 = 0;
				m24 = 0;
				end
			else
				begin
				m21 = 0;
				m22 = 0;
				m23 = 1;
				m24 = 1;
				end
			end
		4'b0100: begin
			if (upcounter[n - 3 : n - 5] == 0)
				begin
				m11 = 0;
				m12 = 1;
				m13 = 1;
				m14 = 1;
				end
			else if (upcounter[n - 5] == 1)
				begin
				m11 = 1;
				m12 = 0;
				m13 = 2;
				m14 = 0;
				end
			else
				begin
				m11 = 0;
				m12 = 2;
				m13 = 0;
				m14 = 1;
				end
			if (upcounter[n - 5] == 1) 
				begin
				m21 = 1;
				m22 = 1;
				m23 = 0;
				m24 = 0;
				end
			else
				begin
				m21 = 0;
				m22 = 0;
				m23 = 1;
				m24 = 1;
				end
			end
		4'b0101: begin
		 	if (upcounter[n - 3 : n - 6] == 0)
                                begin
                                m11 = 0;
                                m12 = 1;
                                m13 = 1;
                                m14 = 1;
                                end
                        else if (upcounter[n - 6] == 1)
                                begin
                                m11 = 1;
                                m12 = 0;
                                m13 = 2;
                                m14 = 0;
                                end
                        else
                                begin
                                m11 = 0;
                                m12 = 2;
                                m13 = 0;
                                m14 = 1;
                                end
                        if (upcounter[n - 6] == 1)
                                begin
                                m21 = 1;
                                m22 = 1;
                                m23 = 0;
                                m24 = 0;
                                end
                        else
                                begin
                                m21 = 0;
                                m22 = 0;
                                m23 = 1;
                                m24 = 1;
                                end
                        end
		4'b0110: begin
			 if (upcounter[n - 3 : n - 7] == 0)
                                begin
                                m11 = 0;
                                m12 = 1;
                                m13 = 1;
                                m14 = 1;
                                end
                        else if (upcounter[n - 7] == 1)
                                begin
                                m11 = 1;
                                m12 = 0;
                                m13 = 2;
                                m14 = 0;
                                end
                        else
                                begin
                                m11 = 0;
                                m12 = 2;
                                m13 = 0;
                                m14 = 1;
                                end
                        if (upcounter[n - 7] == 1)
                                begin
                                m21 = 1;
                                m22 = 1;
                                m23 = 0;
                                m24 = 0;
                                end
                        else
                                begin
                                m21 = 0;
                                m22 = 0;
                                m23 = 1;
                                m24 = 1;
                                end
                        end
		4'b0111: begin
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
                                m14 = 0;
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
                                m24 = 0;
                                end
                         else
                                begin
                                m21 = 0;
                                m22 = 0;
                                m23 = 1;
                                m24 = 1;
                                end
                        end
		default: begin
			 m11 = 0;
			 m12 = 1;
			 m13 = 1;
			 m14 = 1;
			 m21 = 0;
			 m22 = 0;
			 m23 = 1;
			 m24 = 1;
			 end
	endcase
	end

  assign m0 = ~prepare_data;
  /* data input */
  

  initial begin
	en = 1;
	we = 1;
	re = 1;	
	
			
	
    
  end


endmodule // testbench
