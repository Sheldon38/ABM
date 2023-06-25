module register #(parameter WIDTH=8)(
input rstn,
input clk,
input loadbar,
input enablebar,
input [WIDTH-1:0] register_input,
output [WIDTH-1:0] register_output
);
    wire [WIDTH-1:0] d;
    wire [WIDTH-1:0] q;
    
    generate
        genvar i;
        for(i=0;i<WIDTH;i=i+1)
        begin
            d_flip_flop  dff(rstn,clk,d[i],q[i]);
        end
    endgenerate
    
    //always@(*)
    //begin
    //    if(!loadbar)
    //    begin
    //        assign d=register_input;
    //    end
    //    else
    //        assign d=q;
    //end
    assign d=(loadbar) ? q : register_input;
    assign register_output = enablebar ? 64'bz : q;
    
    //always@(*)
    //begin
    //    if(!enablebar)
    //    begin
    //        register_output=q;
    //    end
    //    else
    //        register_output=64'bz;
    //end
    
    
endmodule


module d_flip_flop(
input rstn,
input clk,
input d,
output reg q
);

    always@(posedge clk)
    begin
	if(!rstn)
        q<=d;
	else
	q<=1'b0;
    end

endmodule

// module tb;
// parameter WIDTH=8;
// reg clk,loadbar,enablebar;
// reg [WIDTH-1:0] register_input;
// wire [WIDTH-1:0] register_output;

// always #5 clk=~clk;

// register rega(clk,loadbar,enablebar,register_input,register_output);

// initial
// begin
    // clk=0;loadbar=1;enablebar=1;register_input=8'd69;
    // #5 loadbar=0;
    // #10 loadbar=1;register_input=8'dz;
    // #1000;
    // #5 enablebar=0;
// end

// endmodule
