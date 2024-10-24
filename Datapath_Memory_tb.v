module Datapath_Memory_tb;

    // Inputs
   reg clk50MHz;
	reg [7:0] immediate;
	reg s;
	
	reg [15:0] value;
	reg [15:0] amount;
	reg dir;
	wire [15:0] shifted;
	
	 
   // Outputs
   wire [15:0] extended;

    // Instantiate the alu and register file
	 
	signextend #(8) extender(
		.imm(immediate),
		.sign(s),
		.y(extended)
	);
	
	shifter #(16) shift (
		.imm(value),
		.amount(amount),
		.dir(dir),
		.y(shifted)
	);

    // Clock generation
    initial begin
        clk50MHz = 0;
        forever #10 clk50MHz = ~clk50MHz; // 50MHz clock
    end
	 

    // Test sequence
    initial begin
		  
		  $display("Testing Non-Sign Extend");
		  immediate = 8'b11111111;
		  s = 0;
		  #20
		  if( extended != 16'b0000000011111111) begin
				$display("Error: extended got %b. Should be %b.", extended, 16'b0000000011111111);
		  end
		  
		  #20
		  
		  $display("Testing Sign Extend");
		  immediate = 8'b11111111;
		  s = 1;
		  #20
		  if( extended != 16'b1111111111111111) begin
				$display("Error: extended got %b. Should be %b.", extended, 16'b1111111111111111);
		  end
		  
		  #20
		  
		  $display("Testing Shifter: Left");
		  value = 16'b0000000000000010;
		  amount = 16'b0000000000000010;
		  dir = 0;
		  
		  #20
		  if( shifted != 16'b0000000000001000) begin
				$display("Error: extended got %b. Should be %b.", shifted, 16'b0000000000001000);
		  end
		  
		  #20
		  
		  $display("Testing Shifter: Right");
		  value = 16'b0000000000000010;
		  amount = 16'b0000000000000001;
		  dir = 1;
		  
		  #20
		  if( shifted != 16'b0000000000000001) begin
				$display("Error: extended got %b. Should be %b.", shifted, 16'b0000000000000001);
		  end
		

        // Stop simulation
    end

    // Monitor signals
    initial begin
        //$monitor("hSync=%b, vSync=%b, bright=%b, hCount=%d, vCount=%d", hSync, vSync, bright, hCount, vCount);
    end
endmodule