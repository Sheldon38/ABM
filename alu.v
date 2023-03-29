module alu(
input add_subbar,
input [7:0] a,
input [7:0] b,
input enablebar,
output reg [7:0] alu_output,
output cout
);

wire [7:0] adder_input_b;
wire adder_cin;
wire [7:0] adder_sum;

eight_bit_adder eb(adder_cin,a,adder_input_b,adder_sum,cout);


    assign adder_input_b=add_subbar?b:8'hFF^b;
    assign adder_cin=add_subbar?1'b0:1'b1;


    always@(*)
    begin
        if(!enablebar)
        begin
            alu_output<=adder_sum;
        end
        else
            alu_output<=64'bz;
    end    


    
endmodule

module eight_bit_adder(
input cin,
input [7:0] a,
input [7:0] b,
output [7:0] sum,
output cout
);
assign {cout,sum}=a+b+cin;
endmodule

module tb;

    reg add_subbar;
    reg [7:0] a;
    reg [7:0] b;
    reg enablebar;
    wire [7:0] alu_output;
    wire cout;
    
    alu alu_dut(add_subbar,a,b,enablebar,alu_output,cout);
    
    initial
    begin
        enablebar=1;a=8'd69;b=8'd7;add_subbar=1;
        #5 enablebar=0;
        #5 add_subbar=0;
        #5 b=8'd30; a=8'd33; add_subbar=1;
        #5 add_subbar=0;
    end
    
    initial
    begin
       $monitor("a : %b    b : %b   alu_output : %b   cout : %b",a,b,alu_output,cout); 
    end

endmodule