module memory_address_register(
input rstn,
input clk,
input [3:0] address_in,
input loadbar,
output reg [3:0] address_out
);

    always@(posedge clk)
    begin 
    	if(!rstn)	begin
       		 if(!loadbar)
       		     address_out<=address_in;
       		 else
       		     address_out<=address_out;
        end
	else
       		     address_out<=4'd0;
    end


endmodule
