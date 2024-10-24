module Datapath_Memory_tb;

    // Inputs
    reg clk50MHz;
    reg [7:0] immediate;
    reg s;
    
    reg [15:0] value;
    reg [15:0] amount;
    reg dir;
    wire [15:0] shifted;
    
    reg [15:0] write_data_a, write_data_b;
    reg [9:0] addr_a, addr_b;
    reg we_a, we_b;
     
    // Outputs
    wire [15:0] extended;
    wire [15:0] read_data_a, read_data_b;

    // Instantiate the ALU and Register File
    signextend #(8) extender (
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

    bram #(16,10) bram (
        .data_a(write_data_a),
		  .data_b(write_data_b),
        .addr_a(addr_a),
		  .addr_b(addr_b),
        .we_a(we_a),
		  .we_b(we_b),
        .clk(clk50MHz),
        .q_a(read_data_a),
		  .q_b(read_data_b)
    );

    // State encoding
    reg [1:0] State;

    // Different States for FSM
    parameter
        WRITE  = 1'b0,
        READ   = 1'b1;

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
        #20;
        if (extended != 16'b0000000011111111) 
            $display("Error: extended got %b. Should be %b.", extended, 16'b0000000011111111);

        #20;

        $display("Testing Sign Extend");
        immediate = 8'b11111111;
        s = 1;
        #20;
        if (extended != 16'b1111111111111111) 
            $display("Error: extended got %b. Should be %b.", extended, 16'b1111111111111111);

        #20;

        $display("Testing Shifter: Left");
        value = 16'b0000000000000010;
        amount = 16'b0000000000000010;
        dir = 0;
        #20;
        if (shifted != 16'b0000000000001000) 
            $display("Error: shifted got %b. Should be %b.", shifted, 16'b0000000000001000);

        #20;

        $display("Testing Shifter: Right");
        value = 16'b0000000000000010;
        amount = 16'b0000000000000001;
        dir = 1;
        #20;
        if (shifted != 16'b0000000000000001) 
            $display("Error: shifted got %b. Should be %b.", shifted, 16'b0000000000000001);

        #200;
		  
		  // TEST MEMORY
		  
		  $display("Testing WRITE");
		  
		  State <= WRITE;
		  // Write data to address 0x00
		  addr_a <= 10'h000;
		  write_data_a <= 16'b0000000000001111;
		  
		  // Write data to address 0x02
		  addr_b <= 10'h002;
		  write_data_b <= 16'b0011000000000000;
		  #20;

		  // Write data to address 0x01
		  addr_a <= 10'h001;
		  write_data_a <= 16'b0000000011110000;
		  
		  // Write data to address 0x03
		  addr_b <= 10'h003;
		  write_data_b <= 16'b0000110000000000;
		  #20;
		  		  
		  $display("Testing READ");
		  
		  State <= READ;
		  #20;
		 
		  // Read back data from address 0x00
		  addr_a <= 10'h000;
		  // Read back data from address 0x02
		  addr_b <= 10'h002;
		  #20;
		  if (read_data_a != 16'b0000000000001111)
			  $display("Read Error: Address 0x000 expected: 0000000000001111 but got: %b", read_data_a);

		  if (read_data_b != 16'b0011000000000000)
			  $display("Read Error: Address 0x002 expected: 0011000000000000 but got: %b", read_data_b);

		  // Read back data from address 0x01
		  addr_a <= 10'h001;
		  // Read back data from address 0x03
		  addr_b <= 10'h003;
		  #20;
		  if (read_data_a != 16'b0000000011110000)
			  $display("Read Error: Address 0x001 expected: 0000000011110000 but got: %b", read_data_a);
		  
		  if (read_data_b != 16'b0000110000000000)
			  $display("Read Error: Address 0x003 expected: 0000110000000000 but got: %b", read_data_b); 
		  
		  $display("Testing WRITE to change prev values");
		  
		  State <= WRITE;
		  // Modify data at 0x00
		  addr_a <= 10'h000;
		  write_data_a <= 16'b0000000000000011;
		  // Modify data at 0x02
		  addr_b <= 10'h002;
		  write_data_b <= 16'b0011111111111111;
		  #20;
		  if (read_data_a != 16'b0000000000000011)
			  $display("Modify Error: Address 0x000 expected: 0000000000000011 but got: %b", read_data_a);
		  if (read_data_b != 16'b0011111111111111)
			  $display("Modify Error: Address 0x000 expected: 0011111111111111 but got: %b", read_data_b);

		  // Modify data at 0x01
		  addr_a <= 10'h001;
		  write_data_a <= 16'b0000000000110000;
		  // Modify data at 0x03
		  addr_b <= 10'h003;
		  write_data_b <= 16'b0011111111110000;
		  #20;
		  if (read_data_a != 16'b0000000000110000)
			  $display("Modify Error: Address 0x001 expected: 0000000000110000 but got: %b", read_data_a);
		  if (read_data_b != 16'b0011111111110000)
			  $display("Modify Error: Address 0x001 expected: 0011111111110000 but got: %b", read_data_b);
			  
			  
    end
	 
	 
	 always @(*) begin
		case (State)
				WRITE: begin
					 we_a <= 1; // Enable writing
					 we_b <= 1;
				end
				READ: begin
					 we_a <= 0; // Disable writing
					 we_b <= 0;
				end
				default: begin
					 State <= WRITE; // Default case, go back to WRITE state
				end
		  endcase
	 end

endmodule
