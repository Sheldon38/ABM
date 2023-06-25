module control_logic(
input rstn,
input clk,
input [3:0] instruction_register,
output load_a_bar,
output load_b_bar,
output load_out_bar,
output enable_a_bar,
output enable_b_bar,
output add_sub_bar,
output enable_alu_bar,
output pc_clr,
output load_pc,
output pc_inc,
output enable_pc,
output load_ir_bar,
output load_mar_bar,
output ram_write_bar,
output ram_read_bar,
output enable_ram_bar,
output enable_ir_bar
);
	wire counter_rst;
	wire [2:0] count;
	wire [15:0] control_signals_n;
	reg [15:0] control_signals_d;
	control_step_counter c1(rstn,counter_rst,clk,count);
	ram_for_control_unit microprogrammed_instructions(rstn,{1'b0,instruction_register,count},1'b0,control_signals_n);

	always@(posedge clk)	begin
		if(!rstn)	begin
		control_signals_d <= control_signals_n;
		end
		else
		control_signals_d <= 16'b0110111000111110;
	end

	assign counter_rst	= control_signals_d[15];
	assign enable_a_bar     = (control_signals_d [14:12] == 3'b000) ? 1'b0 : 1'b1;
	assign enable_b_bar     = (control_signals_d [14:12] == 3'b001) ? 1'b0 : 1'b1;
	assign enable_alu_bar   = (control_signals_d [14:12] == 3'b010) ? 1'b0 : 1'b1;
	assign enable_pc        = (control_signals_d [14:12] == 3'b011) ? 1'b1 : 1'b0;
	assign enable_ram_bar   = (control_signals_d [14:12] == 3'b100) ? 1'b0 : 1'b1;
	assign enable_ir_bar    = (control_signals_d [14:12] == 3'b101) ? 1'b0 : 1'b1;
	assign add_sub_bar      = control_signals_d[11];
	assign ram_read_bar     = control_signals_d[10];
	assign ram_write_bar    = control_signals_d[9];
	assign pc_inc           = control_signals_d[8];
	assign pc_clr           = control_signals_d[7];
	assign load_pc          = control_signals_d[6];
	assign load_out_bar     = control_signals_d[5];
	assign load_mar_bar     = control_signals_d[4];
	assign load_ir_bar      = control_signals_d[3];
	assign load_b_bar       = control_signals_d[2];
	assign load_a_bar       = control_signals_d[1];


//instruction_out_temp[7:4] will be storing the current instruction
	
	//microprogramming logic
	

	//hardcoding logic
	//wire [7:0] t_bar;
	//decoder	d1(count,t_bar);
	//assign counter_rst = rstn ? 1'b1 : t_bar [4];
	//assign enable_pc 	= ~t_bar [0] ? 1'b1 : 1'b0;	//fetching instruction from memory
	//assign load_mar_bar 	= ~t_bar [0] ? 1'b0 : 1'b1;	
	//assign ram_read_bar     = ~t_bar [0] ? 1'b0 : 1'b1;	
	//assign enable_ram_bar	= ~t_bar [1] ? 1'b0 : 1'b1; 
	//assign load_ir_bar     	= ~t_bar [1] ? 1'b0 : 1'b1;
	//assign pc_inc          	= ~t_bar [1] ? 1'b1 : 1'b0;
	//assign load_a_bar	=	1'b1;
	//assign load_b_bar       =	1'b1;
	//assign enable_a_bar     =	1'b1;
	//assign enable_b_bar     =	1'b1;
	//assign add_sub_bar      =	1'b1;
	//assign enable_alu_bar   =	1'b1;
	//assign pc_clr           =	1'b0;
	//assign load_pc          =	1'b0;
	//assign ram_write_bar    =	1'b1;
	//assign enable_ir_bar    =	1'b1;
endmodule



module control_step_counter(
input rstn,
input counter_reset,
input clk,
output reg [2:0] count
);

	always @(posedge clk)	begin
		if(!rstn)	begin
		count <= (counter_reset) ? 3'd0 : (count + 3'd1);
		end
		else
		count <= 3'd0 ;
	end

endmodule

module decoder(
input [2:0] count_in,
output reg [7:0] count_out
);
	always @(*)	begin
		case(count_in)
			3'b000  : count_out = 8'b1111_1110;
			3'b001  : count_out = 8'b1111_1101;
			3'b010  : count_out = 8'b1111_1011;
			3'b011  : count_out = 8'b1111_0111;
			3'b100  : count_out = 8'b1110_1111;
			3'b101  : count_out = 8'b1101_1111;
			3'b110  : count_out = 8'b1011_1111;
			3'b111  : count_out = 8'b0111_1111;
			default : count_out = 8'b1111_1111;
		endcase
	end
endmodule



module ram_for_control_unit (
  input rstn,
  input [7:0] address,
  input output_enable_bar,
  output [15:0] data_out
);

  reg [15:0] data_out_temp;
  reg [15:0] mem [0:127]; // 256 bytes of memory

  always @(*) 
  begin
	if(!rstn)	begin
		  data_out_temp<=mem[address];
	end
	else	begin
		  data_out_temp <= 8'd0;
	end
  end
  
  assign data_out = output_enable_bar ? 8'bz : data_out_temp;

endmodule

//module tb;
//	reg rstn,clk;
//	control_logic c1(rstn,clk);
//	
//	always	#5 clk=~clk;
//
//	initial	begin
//		rstn = 1'b1; clk=0;
//		#5 rstn = 1'b0;
//	end
//endmodule
