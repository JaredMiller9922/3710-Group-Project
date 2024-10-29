// This is the datapath module
module datapath #(parameter WIDTH = 16, REGBITS = 3, IMM = 8)
					  (input clk, reset,
					   input wa_s, pc_s, alub_s, // Selector bits for all mux2
						input [1:0] wd_s, alua_s, // Selector bits for all mux4
						                          // TODO: Finite state machine codes
						input [2:0] alucont
);

	// Create localparams
	localparam CONST_ZERO = 16'b0;
	localparam CONST_ONE = 16'b0;
	
	// Create wires
	
	// Instruction register TODO: Next checkpoint
	// flopenr #(WIDTH) instrmem(clk, reset, irwrite, memdata, instr);	
	// register file address fields
   // assign ra1 = instr[REGBITS+20:21];
   // assign ra2 = instr[REGBITS+15:16];
   // mux2       #(REGBITS) regmux(instr[REGBITS+15:16], instr[REGBITS+10:11], regdst, wa);
	
	// create a sign extender
	signextend #(IMM) (imm, signext_sign, imm_ext); 

	// datapath registers
	flopenr #(WIDTH) pcreg(clk, reset, pcen, pc_out, pc); // Program Counter
	flopr   #(WIDTH) rsrc(clk, reset, rd1, Rsrc);	
   flopr   #(WIDTH) rdest(clk, reset, rd2, Rdest);
	// TODO: Should the PSR be here
	
	// datapath muxes all of the _s variables are control signals
	mux2 #(WIDTH) wa_mux(Rsrc, Rdest, wa_s, wa);
	mux4 #(WIDTH) wd_mux(Imm, Rsrc, mem_out, alu_out, wd_s, wd); // CONST_ZERO is a placeholder for no connection
	mux2 #(WIDTH) pc_mux(Rsrc, alu_out, pc_s, pc_out);
	mux4 #(WIDTH) alua_mux(Rsrc, pc_out, imm_ext, CONST_ZERO, alua_s, alua_out); // CONST_ZERO is a placeholder for no connection
	mux2 #(WIDTH) alub_mux(Rdest, CONST_ONE, alub_s, alub_out);
	
	// Instantiate the register file and the alu
   regfile    #(WIDTH,REGBITS) rf(clk, regwrite, ra1, ra2, wa, wd, rd1, rd2);
   alu        #(WIDTH) 			 alunit(src1, src2, alucont, alu_out);
endmodule 