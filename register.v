module register #(parameter WIDTH=8)(
input clk,
input loadbar,
input enablebar,
input [WIDTH-1:0] register_input,
output reg [WIDTH-1:0] register_output
);
    reg [WIDTH-1:0] d;
    wire [WIDTH-1:0] q;
    
    generate
        genvar i;
        for(i=0;i<WIDTH;i=i+1)
        begin
            d_flip_flop  dff(clk,d[i],q[i]);
        end
    endgenerate
    
    always@(*)
    begin
        if(!loadbar)
        begin
            assign d=register_input;
        end
        else
            assign d=q;
    end
    
    always@(*)
    begin
        if(!enablebar)
        begin
            register_output<=q;
        end
        else
            register_output<=64'bz;
    end
    
    
endmodule


module d_flip_flop(
input clk,
input d,
output reg q
);

    always@(posedge clk)
    begin
        q<=d;
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