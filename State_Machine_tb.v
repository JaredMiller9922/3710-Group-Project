module State_Machine_tb;
	
	
	parameter WIDTH = 16, REGBITS = 3, IMM = 8, REG_ADD = 4, PSRL = 5;
	
	// Inputs
	reg clk50MHz;
	reg reset;


	//Input
	reg [WIDTH-1:0] mem_out;        // data that is read from memory
	//Output
   wire memwrite;            			// write-enable to memory
   wire [WIDTH-1:0] mem_addr;       // address to memory
   wire [WIDTH-1:0] writedata; 		// write data to memory


	CPU computation(
		clk50MHz,                  // 50MHz clock
		reset,                // active-low reset
		mem_out,        // data that is read from memory
		memwrite,            // write-enable to memory
		mem_addr,           // address to memory
		writedata      // write data to memory
	);

	// Clock generation
	initial begin
	  clk50MHz = 0;
	  forever #5 clk50MHz = ~clk50MHz; // 50MHz clock  # 10 every cycle
	end

	// Test sequence
	initial begin
	  $display("Testing CPU");
	  $display("Current state is: %b", computation.cont.state);
	  
	  reset = 1;
	  
	  #10
	  
	  reset = 0;
	  $display("Current state is: %b", computation.cont.state);
	  
	  #10
	  
	  reset = 1;
	  
	  
	  
	  // 1101000100000101 MOVI $5 %r1
	  mem_out = 16'b1101000100000101;
	  $display("Running: MOVI $5 r1");
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  $display("Value at register1: %d", computation.dp.rf.RAM[1]);
	  
	  
	  
	  
	  // 0000001011010001 MOV %r1 %r2
	  mem_out = 16'b0000001011010001;
	  $display("Running: MOV r1 r2");
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  $display("Value at register2: %d", computation.dp.rf.RAM[2]);
	  
	  
	  
	  
	  // 0000001001010001 ADD %r1 %r2
	  mem_out = 16'b0000001001010001;
	  $display("Running: ADD r1 r2");
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  $display("Value at register2: %d", computation.dp.rf.RAM[2]);
	  
	  
	  
	  
	  // 0000000110010010 SUB %r2 %r1
	  mem_out = 16'b0000000110010010;
	  $display("Running: SUB r2 r1");
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  $display("Value at register1: %d", computation.dp.rf.RAM[1]);
	  
	  
	  
	end

	 
	 

endmodule
