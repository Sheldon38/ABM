module instruction_register(
input loadbar,
input output_bar,
input [3:0] instruction_in,
output reg [3:0] instruction_out
);

	reg [3:0] instruction_out_temp;    

    always@(*)
    begin 
        if(!loadbar)
            instruction_out_temp<=instruction_in;
        else
            instruction_out_temp<=instruction_out_temp;
    end
    
    always@(*)
    begin
        if(!output_bar)
        begin
            instruction_out<=instruction_out_temp;
        end
        else
            instruction_out<=64'bz;
    end
endmodule
