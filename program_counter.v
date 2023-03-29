module program_counter(
input clk,
input clr,
input jump,
input count_increment,
input counter_output_enable,
input [3:0] count_in,
output reg [3:0] count_out
);

    reg [3:0] count_temp;
    
always @(posedge clk)
begin
    case({count_increment,jump,clr})
    3'b000 : begin end
    3'b001 : begin count_temp<=0; end
    3'b010 : begin count_temp<=count_in[3:0]; end
    3'b011 : begin count_temp<=count_in[3:0]; end
    3'b100 : begin count_temp<=count_temp+1; end
    3'b101 : begin count_temp<=0; end
    3'b110 : begin count_out<=count_in; end
    3'b111 : begin count_temp<=0; end
    endcase
end

always @(*)
begin
    if(counter_output_enable)
        count_out<=count_temp;
    else
        count_out<=64'bz;
end

endmodule

// module tb();

  // reg clk;
  // reg clr;
  // reg jump;
  // reg count_increment;
  // reg counter_output_enable;
  // reg [7:0] count_in;

  // wire [7:0] count_out;

  // program_counter dut (
    // .clk(clk),
    // .clr(clr),
    // .jump(jump),
    // .count_increment(count_increment),
    // .counter_output_enable(counter_output_enable),
    // .count_in(count_in),
    // .count_out(count_out)
  // );

// initial
// begin
    // clk=0;
    // forever #5 clk=~clk;
// end

// initial
// begin
    // {count_increment,jump,clr}=3'b000;
    // #5 {count_increment,jump,clr}=3'b001;
    // #10 {count_increment,jump,clr}=3'b100; counter_output_enable<=1;
    // #100 {count_increment,jump,clr}=3'b010; count_in=8'h45;
    // #10 {count_increment,jump,clr}=3'b100; 
    
// end

// endmodule