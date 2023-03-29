module ram (
  input [3:0] address,
  input [7:0] data_in,
  input write_bar,
  input read_bar,
  input output_enable,
  output reg [7:0] data_out
);

  reg [7:0] data_out_temp;
  reg [7:0] mem [0:15]; // 16 bytes of memory

  always @(*) 
  begin
    if (!write_bar) 
    begin
      mem[address] <= data_in;
    end
	else if(!read_bar)
	begin
	  data_out_temp<=mem[address];
	end
  end
  
  always @(*)
  begin
    if(!output_enable)
        data_out<=data_out_temp;
    else
        data_out<=64'bz;
  end

endmodule


// module ram_tb;

  // Inputs
  // reg [3:0] address;
  // reg [7:0] data_in;
  // reg write_bar, output_enable;

  // Outputs
  // wire [7:0] data_out;

  // Instantiate the unit under test (UUT)
  // ram uut (
    // .address(address),
    // .data_in(data_in),
    // .write_bar(write_bar),
    // .output_enable(output_enable),
    // .data_out(data_out)
  // );

  // initial begin
    // Test write operations
    // write_bar = 0;
    // for (address = 0; address < 16; address = address + 1) begin
      // data_in=address+10;
      // #10;
    // end

    // Test read operations
    // write_bar = 1;
    // output_enable = 0;
    // for (address = 0; address < 16; address = address + 1) begin
      // #10;
      // $display("mem[%d] = %h", address, data_out);
    // end

    // End simulation
    // #10;
    // $finish;
  // end

// endmodule
