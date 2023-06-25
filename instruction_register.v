module instruction_register(
input rstn,
input clk,
input loadbar,
input output_bar,
input [7:0] instruction_in,
output reg [7:0] instruction_out
);

	reg [7:0] instruction_out_temp;    

    always@(posedge clk)
    begin 
    	if(!rstn)	begin
        	if(!loadbar)
        	    instruction_out_temp<=instruction_in;
        	else
        	    instruction_out_temp<=instruction_out_temp;
	end
	else	begin
		instruction_out_temp<=8'd0;
	end
	
    end
    
    always@(posedge clk)
    begin
    	if(!rstn)	begin
        	if(!output_bar)
        	begin
        	    instruction_out<=instruction_out_temp;
        	end
        	else
        	    instruction_out<=8'bz;
        end
	else	begin
        	    instruction_out<=8'd0;
	end
    end
endmodule
