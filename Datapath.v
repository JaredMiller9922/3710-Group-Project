// This is the datapath module
module datapath #(parameter WIDTH = 16, REGBITS = 3, IMM = 8, REG_ADD = 4)
					  (input clk, reset,
					   input wa_s, pc_s, alub_s, mem_s, // Selector bits for all mux2
						input [1:0] wd_s, alua_s, 			// Selector bits for all mux4
						input pcen,
						input signext_sign,
						input regwrite,
						input [2:0] alucont,
						input [IMM-1:0] imm,
						input [WIDTH-1:0] mem_out, 
						input [WIDTH-1:0] rsrc_addr, rdest_addr, // TODO: These shouldn't be inputs
						output [WIDTH-1:0] Rsrc,
						output [WIDTH-1:0] mem_addr
);

	// Create localparams
	localparam CONST_ZERO = 16'b0;
	localparam CONST_ONE = 16'b0;
	
	// Create wires

	wire [WIDTH-1:0] imm_ext, pc_out, pc, rd1, rd2, Rdest, alu_out, wd, alua_out, alub_out;
	// wire [REG_ADD-1:0] wa, rsrc_addr, rdest_addr;
	wire [REG_ADD-1:0] wa;
	
	// Instruction register TODO: Next checkpoint
	// flopenr #(WIDTH) instrmem(clk, reset, irwrite, memdata, instr);	
	// register file address fields
   // assign rsrc_addr = instr[REGBITS+20:21];
   // assign rdest_addr = instr[REGBITS+15:16];
   // mux2       #(REGBITS) regmux(instr[REGBITS+15:16], instr[REGBITS+10:11], regdst, wa);
	
	// assign rsrc_addr = 4'b0101;
	// assign rdest_addr = 4'b1001;
	
	// create a sign extender
	signextend #(IMM) extend(imm, signext_sign, imm_ext); 

	// datapath registers
	flopenr #(WIDTH) pcreg(clk, reset, pcen, pc_out, pc); // Program Counter
	flopr   #(WIDTH) rsrc(clk, reset, rd1, Rsrc);	
   flopr   #(WIDTH) rdest(clk, reset, rd2, Rdest);
	
	// datapath muxes all of the _s variables are control signals
	mux2 #(WIDTH) wa_mux(Rsrc, Rdest, wa_s, wa);
	mux2 #(WIDTH) mem_mux(Rsrc, pc_out, mem_s, mem_addr);
	mux4 #(WIDTH) wd_mux(imm, Rsrc, mem_out, alu_out, wd_s, wd); // CONST_ZERO is a placeholder for no connection
	mux2 #(WIDTH) pc_mux(Rsrc, alu_out, pc_s, pc_out);
	mux4 #(WIDTH) alua_mux(Rsrc, pc_out, imm_ext, CONST_ZERO, alua_s, alua_out); // CONST_ZERO is a placeholder for no connection
	mux2 #(WIDTH) alub_mux(Rdest, CONST_ONE, alub_s, alub_out);
	
	// Instantiate the register file and the alu
   regfile    #(WIDTH,REGBITS) rf(clk, regwrite, rsrc_addr, rdest_addr, wa, wd, rd1, rd2);
   alu        #(WIDTH) 			 alunit(Rsrc, Rdest, alucont, alu_out);
endmodule 