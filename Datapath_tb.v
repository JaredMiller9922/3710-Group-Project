module Datapath_tb;

    // Inputs
    reg clk50MHz;
	 reg reset;

	 
		localparam WIDTH = 16;
		
		reg wa_s, pc_s, alub_s, mem_s; // Selector bits for all mux2
		reg [1:0] wd_s, alua_s; 			// Selector bits for all mux4
		reg pcen;
		reg signext_sign;
		wire [2:0] alucont;
		reg [WIDTH-1:0] mem_out;
		wire [WIDTH-1:0] Rsrc;
		wire [WIDTH-1:0] mem_addr;
	 
	 datapath #(16, 3, 8, 4) path (
		clk50MHz, reset,
		wa_s, pc_s, alub_s, mem_s, // Selector bits for all mux2
		wd_s, alua_s, 			// Selector bits for all mux4
		pcen,
		signext_sign,
		alucont,
		mem_out, 
		Rsrc,
		mem_addr
	  );
	  
	  reg [3:0] opcode;
	  reg [3:0] opext;
	  
	  alucontrol alucontrol1(
		opcode,
		opext, 
		alucont
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
			
			//Rsrc
			//mem_addr
			
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
