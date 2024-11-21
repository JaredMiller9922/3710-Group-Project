module State_Machine_tb;
	
	
	parameter WIDTH = 16, REGBITS = 4, IMM = 8, REG_ADD = 4, PSRL = 5;
	
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
	
	/*// Instantiate bram
	bram MEM (
		.data_a(writedata),
		.data_b(data_b),
		.addr_a(mem_addr), 
		.addr_b(addr_b),
		.we_a(memwrite), 
		.we_b(we_b), 
		.clk(~clk), // clk or ~clk
		.q_a(mem_out), // output
		.q_b(q_b)  // output
	);*/
	
	
	
	

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
	  $display("PC: %b", computation.dp.PC_OUT);
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
	  $display("PC: %b", computation.dp.PC_OUT);
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
	  $display("PC: %b", computation.dp.PC_OUT);
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
	  
	  
	  
	  
	  // 0101000100001000 ADDI $8 %r1
	  mem_out = 16'b0101000100001000;
	  $display("PC: %b", computation.dp.PC_OUT);
	  $display("Running: ADDI $8 r1");
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
	  
	  
	  
	  
	  // 0000000110010010 SUB %r2 %r1
	  mem_out = 16'b0000000110010010;
	  $display("PC: %b", computation.dp.PC_OUT);
	  $display("Running: SUB r2 r1");
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  $display("Value at register1: %d", $signed(computation.dp.rf.RAM[1]));
	  
	  
	  
	  
	  // 1001000100001001 SUBI $9 %r1
	  mem_out = 16'b1001000100001001;
	  $display("PC: %b", computation.dp.PC_OUT);
	  $display("Running: SUBI $9 r1");
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
	  $display("Value at register1: %d", $signed(computation.dp.rf.RAM[1]));
	  
	  
	  
	  
	  // 0000001000010001 AND %r1 %r2
	  mem_out = 16'b0000001000010001;
	  $display("PC: %b", computation.dp.PC_OUT);
	  $display("Running: AND r1 r2");
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
	  $display("Value at register2: %d", $signed(computation.dp.rf.RAM[2]));
	  
	  
	  
	  
	  // 0001000100001001 ANDI $9 %r1
	  mem_out = 16'b0001000100001001;
	  $display("PC: %b", computation.dp.PC_OUT);
	  $display("Running: ANDI $9 r1");
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
	  $display("Value at register1: %d", $signed(computation.dp.rf.RAM[1]));
	  
	  
	  
	  
	  // 1101001100000001 MOVI $3 %r3
	  mem_out = 16'b1101001100000001;
	  $display("PC: %b", computation.dp.PC_OUT);
	  $display("Running: MOVI $3 r3");
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
	  $display("Value at register3: %d", computation.dp.rf.RAM[3]);
	  $display("Pos register3: %d", (-$signed(computation.dp.rf.RAM[3])));
	  
	  
	  
	  
	  
	  
	  
	  // 0000001000100001 OR %r1 %r2
	  mem_out = 16'b0000001000100001;
	  $display("PC: %b", computation.dp.PC_OUT);
	  $display("Running: OR r1 r2");
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
	  $display("Value at register2: %b", computation.dp.rf.RAM[2]);
	  
	  
	  
	  
	  
	  // 0010000100001111 ORI $15 %r1
	  mem_out = 16'b0010000100001111;
	  $display("PC: %b", computation.dp.PC_OUT);
	  $display("Running: ORI $15 r1");
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
	  $display("Value at register1: %b", computation.dp.rf.RAM[1]);
	  
	  
	  
	  
	  // 0000001000110001 XOR %r1 %r2
	  mem_out = 16'b0000001000110001;
	  $display("PC: %b", computation.dp.PC_OUT);
	  $display("Running: XOR r1 r2");
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
	  $display("Value at register2: %b", computation.dp.rf.RAM[2]);
	  
	  
	  
	  
	  // 0011000100010111 XORI $23 %r1
	  mem_out = 16'b0011000100010111;
	  $display("PC: %b", computation.dp.PC_OUT);
	  $display("Running: XORI $23 r1");
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
	  $display("Value at register1: %b", computation.dp.rf.RAM[1]);
	  
	  
	  
	  
	  // 1000001001000011 LSH %r3 %r2
	  mem_out = 16'b1000001001000011;
	  $display("PC: %b", computation.dp.PC_OUT);
	  $display("Running: LSH r3 r2");
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
	  $display("Value at register2: %b", computation.dp.rf.RAM[2]);
	  
	  
	  
	  
	  // 1000000100000100 LSHI $4 %r1
	  mem_out = 16'b1000000100000100;
	  $display("PC: %b", computation.dp.PC_OUT);
	  $display("Running: LSHI $4 r1");
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
	  $display("Value at register1: %b", computation.dp.rf.RAM[1]);
	  
	  
	  
	  
	  
	  // 1111001100000101 LUI $5 %R3
	  mem_out = 16'b1111001100000101;
	  $display("PC: %b", computation.dp.PC_OUT);
	  $display("Running: LUI $5 R3");
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
	  $display("Value at register3: %b", computation.dp.rf.RAM[3]);
	  
	  
	  
	  
	  
	  // 1101010000001000 MOVI $8 %r4
	  mem_out = 16'b1101010000001000;
	  $display("PC: %b", computation.dp.PC_OUT);
	  $display("Running: MOVI $8 r4");
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
	  $display("Value at register4: %d", computation.dp.rf.RAM[4]);
	  
	  
	  
	  
	  
	  // 1101010100000110 MOVI $6 %r5
	  mem_out = 16'b1101010100000110;
	  $display("PC: %b", computation.dp.PC_OUT);
	  $display("Running: MOVI $6 r5");
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
	  $display("Value at register5: %d", computation.dp.rf.RAM[5]);
	  
	  
	  
	  
	  
	  
	  // 1101011011111100 MOVI $-4 %r6
	  mem_out = 16'b1101011011111100;
	  $display("PC: %b", computation.dp.PC_OUT);
	  $display("Running: MOVI $-4 r6");
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
	  $display("Value at register6: %d", computation.dp.rf.RAM[6]);
	  
	  
	  
	  
	  // 0000010110110101 CMP %r5 %r5
	  mem_out = 16'b0000010110110101;
	  $display("PC: %b", computation.dp.PC_OUT);
	  $display("Running: CMP r5 r5");
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  $display("Flags: %b", computation.dp.PSR_OUT);
	  
	  
	  
	  
	  
	  // 0000010110110100 CMP %r4 %r5
	  mem_out = 16'b0000010110110100;
	  $display("PC: %b", computation.dp.PC_OUT);
	  $display("Running: CMP r4 r5");
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  $display("Flags: %b", computation.dp.PSR_OUT);
	  
	  
	  
	  
	  
	  
	  // 1011010100001001 CMPI $9 %r5
	  mem_out = 16'b1011010100001001;
	  $display("PC: %b", computation.dp.PC_OUT);
	  $display("Running: CMPI $9 r5");
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  $display("Flags: %b", computation.dp.PSR_OUT);
	  
	  
	  
	  
	  
	  // 1011011011111011 CMPI $-5 %r6
	  mem_out = 16'b1011011011111011;
	  $display("PC: %b", computation.dp.PC_OUT);
	  $display("Running: CMPI $-5 r6");
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  $display("Flags: %b", computation.dp.PSR_OUT);

	  
	  
	  
	  // 1100000000000100 BEQ $4
	  mem_out = 16'b1100000000000100;
	  $display("PC: %b", computation.dp.PC_OUT);
	  $display("Running: BEQ $4");
	  $display("Flags: %b", computation.dp.PSR_OUT);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  $display("PC: %b", computation.dp.PC_OUT);
	  
	  
	  
	  
	  
	  
	  // 0000010110110101 CMP %r5 %r5
	  mem_out = 16'b0000010110110101;
	  $display("PC: %b", computation.dp.PC_OUT);
	  $display("Running: CMP r5 r5");
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  $display("Flags: %b", computation.dp.PSR_OUT);
	  
	  
	  
	  
	  
	  
	  // 1100000000000100 BEQ $4
	  mem_out = 16'b1100000000000100;
	  $display("PC: %b", computation.dp.PC_OUT);
	  $display("Running: BEQ $4");
	  $display("Flags: %b", computation.dp.PSR_OUT);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  $display("PC: %b", computation.dp.PC_OUT);
	 
	  
	  
	  
	  
	  // 0100000111000101 JNE %r5
	  mem_out = 16'b0100000111000101;
	  $display("Running: JNE r5");
	  $display("Flags: %b", computation.dp.PSR_OUT);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  $display("PC: %b", computation.dp.PC_OUT);
	  
	  
	  
	  
	  
	  
	  
	  // 0100000011000100 JEQ %r4
	  mem_out = 16'b0100000011000100;
	  $display("Running: JEQ r4");
	  $display("Flags: %b", computation.dp.PSR_OUT);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  $display("PC: %b", computation.dp.PC_OUT);
	  
	  
	  
	  
	  
	  
	  
	  
	  // 0100010110000100 JALR %r5 %r4
	  mem_out = 16'b0100010110000100;
	  $display("Running: JALR r5 r4");
	  $display("Flags: %b", computation.dp.PSR_OUT);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  $display("Value at register4: %d", computation.dp.rf.RAM[4]);
	  $display("Value at register5: %d", computation.dp.rf.RAM[5]);
	  $display("PC: %b", computation.dp.PC_OUT);

	  
	  
	  
	  #10
	  $display("PC: %b", computation.dp.PC_OUT);
	  $display("Value at register4: %d", computation.dp.rf.RAM[4]);
	  $display("Value at register5: %d", computation.dp.rf.RAM[5]);
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  /*// 0100010000000101 LOAD %r4 %r5
	  mem_out = 16'b0100010000000101;
	  $display("PC: %b", computation.dp.PC_OUT);
	  $display("Running: LOAD r4 r5");
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
	  $display("Value at register5: %d", computation.dp.rf.RAM[5]);
	  
	  
	  
	  
	  // 0100010001000101 STOR %r4 %r5
	  mem_out = 16'b0100010001000101;
	  $display("PC: %b", computation.dp.PC_OUT);
	  $display("Running: STOR r4 r5");
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  #10
	  $display("Current state is: %b", computation.cont.state);
	  $display("Value at register6: %d", computation.dp.rf.RAM[6]);*/
	  
	  
	  
	  
	end

	 
	 

endmodule
