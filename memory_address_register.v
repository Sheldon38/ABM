module memory_address_register(
input clk,
input [3:0] address_in,
input loadbar,
output reg [3:0] address_out
);

	
	//reg [3:0] address_out_temp;

    always@(posedge clk)
    begin 
        if(!loadbar)
            address_out<=address_in;
        else
            address_out<=address_out;
    end

    //always@(*)
    //begin
    //    if(!output_bar)
    //    begin
    //        address_out<=address_out_temp;
    //    end
    //    else
    //        address_out<=64'bz;
    //end


endmodule
