`include "register.v"
`include "alu.v"
`include "program_counter.v"
`include "ram.v"
`include "memory_address_register.v"
`include "instruction_register.v"
`include "control_step_counter.v"
module tb;

wire [7:0] datapath;
wire cout;
reg rstn;
reg clk;
wire load_a_bar,load_b_bar,load_out_bar,enable_a_bar,enable_b_bar,add_sub_bar,enable_alu_bar,pc_clr,load_pc,pc_inc,enable_pc,load_ir_bar,load_mar_bar,ram_write_bar,ram_read_bar,enable_ram_bar,enable_ir_bar;
wire [3:0] mar_to_ram;
wire [7:0] towards_display;
    
    register rega(rstn,clk,load_a_bar,enable_a_bar,datapath,datapath);
    register regb(rstn,clk,load_b_bar,enable_b_bar,datapath,datapath);
    register out_register(rstn,clk,load_out_bar,1'b0,datapath,towards_display);
    alu aluprime(add_sub_bar,rega.q,regb.q,enable_alu_bar,datapath,cout);
    program_counter pc(rstn,clk,pc_clr,load_pc,pc_inc,enable_pc,datapath,datapath);
    instruction_register ir(rstn,clk,load_ir_bar,enable_ir_bar,datapath,datapath);
    memory_address_register mar(rstn,clk,datapath,load_mar_bar,mar_to_ram);
    ram r1(rstn,mar_to_ram,datapath,ram_write_bar,ram_read_bar,enable_ram_bar,datapath);
    //hardcoding_on_datapath h1(datapath);
    control_logic cu(rstn,clk,ir.instruction_out_temp[7:4],load_a_bar,load_b_bar,load_out_bar,enable_a_bar,enable_b_bar,add_sub_bar,enable_alu_bar,pc_clr,load_pc,pc_inc,enable_pc,load_ir_bar,load_mar_bar,ram_write_bar,ram_read_bar,enable_ram_bar,enable_ir_bar);

always #5 clk=~clk;

initial
begin 
	$readmemb("instructions.txt",r1.mem); 
	$readmemb("micro_instructions.txt",cu.microprogrammed_instructions.mem); 
	rstn=1;clk=1;
	#12; rstn=0;
	//clk=0;pc_clr=1;load_pc=0;pc_inc=0;enable_a_bar=1;enable_b_bar=1;enable_alu_bar=1;enable_pc=0;enable_ram_bar=1;enable_ir_bar=1;
	//#6 pc_clr=0;pc_inc=1;
	//#50 pc_inc=0;enable_pc=1;load_mar_bar=0;ram_read_bar=0;
	//#10 load_mar_bar=1;enable_pc=0;enable_ram_bar=0;load_a_bar=0;
	//#10 pc_clr=1;load_mar_bar=0;ram_read_bar=0;enable_ram_bar=0;load_a_bar=0;enable_a_bar=0;
	//#10 pc_clr=0;pc_inc=1;

end
endmodule

module hardcoding_on_datapath(
output reg [7:0] datapath
);
initial
begin
		datapath=0;
		#1 datapath=8'bz;
end
endmodule
