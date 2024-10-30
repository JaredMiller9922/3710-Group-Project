module Datapath_tb;

	// Inputs
   reg clk50MHz;
	reg reset;

	 
	localparam WIDTH = 16;
	localparam IMM = 8;
		
	reg wa_s, pc_s, alub_s, mem_s;   // Selector bits for all mux2
	reg [1:0] wd_s, alua_s; 			// Selector bits for all mux4
	reg pcen;
	reg signext_sign;
	reg [WIDTH-1:0] mem_out;
	reg [IMM-1:0] imm;
	reg [WIDTH-1:0] rsrc_addr, rdest_addr, wa;
	wire [2:0] alucont;
	wire [WIDTH-1:0] Rsrc;
	wire [WIDTH-1:0] mem_addr;
	 
	datapath #(16, 3, 8, 4) path (
		.clk(clk50MHz), 
		.reset(reset),
      .wa_s(wa_s), .pc_s(pc_s), .alub_s(alub_s), .mem_s(mem_s), // Selector bits for all mux2
      .wd_s(wd_s), .alua_s(alua_s),             					 // Selector bits for all mux4
      .pcen(pcen),
      .signext_sign(signext_sign),
      .alucont(alucont),
      .mem_out(mem_out), 
      .Rsrc(Rsrc),
      .mem_addr(mem_addr),
		.rsrc_addr(rsrc_addr),
		.rdest_addr(rdest_addr),
		.wa(wa),
		.imm(imm)
	);
	  
	reg [3:0] opcode;
	reg [3:0] opext;
	  
	alucontrol alucontrol1(
		.opcode(opcode),
		.opext(opext), 
		.alucont(alucont)
	);

   // Clock generation
	initial begin
		clk50MHz = 0;
		forever #10 clk50MHz = ~clk50MHz; // 50MHz clock
   end

   // Test sequence
   initial begin
		#20;
		reset = 0;
		#20;
		reset = 1;
		#20;
		
		// Test Datapath
		  
		// test Add instruction
		wa_s = 1;
		pc_s = 0;
		alub_s = 0;
		mem_s = 0;
		wd_s = 2'b11;
		alua_s = 2'b00;
		pcen = 0;
		signext_sign = 0;
		opcode = 4'b0000;
		opext = 4'b0101;
		mem_out = 0;
			
		#100;
			
		$display("alu_out: %b, Rdest: %b, alua_out: %b, rd1: %b, Rsrc: %b. %b", path.alu_out, path.Rdest, path.alua_out, path.rd1, path.Rsrc, path.alucont);
		  
		  
		  
		// test Addi instruction
		  
		  
		// test Mov instruction
		  
		  
		// test Load instruction
		  
		  
		// test Store instruction
		  
		  
		// test Bcond instruction 
		  
		  
		// test Jcond instruction
		  
		  
		// test Jal instruction
    end

endmodule
