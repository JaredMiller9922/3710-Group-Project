// This is the datapath module
module datapath #(parameter WIDTH = 16, REGBITS = 3, IMM = 8, REG_ADD = 4, PSRL = 5)
					  (input clk, reset,
					   input pc_s, mem_s, 										// Selector bits for all mux2
						input [1:0] wd_s, alua_s, alub_s,	   			// Selector bits for all mux4
						input inst_en, alu_out_en, mem_reg_en, pc_en,	// Flopenr bits
						input psr_en,												// Flopenr bits
						
						input se_sign, reg_wr, 									// Control Signals
						input [WIDTH-1:0] mem_out, instr,					// Inputs for mem_out and instr
						
						input [REGBITS-1:0] alucont, 							// ALU control bits
						
						output [WIDTH-1:0] Rsrc, mem_addr,					// Values that allow memory access
						output [PSRL-1:0] psr_out
);

	// Create localparams
	localparam CONST_ZERO = 16'b0;
	localparam CONST_ONE = 16'b0;
	
	// Create wires
	wire [WIDTH-1:0] imm_ext, pc_out, pc, rd1, rd2, Rdest, alu_res, wd, alua_out, alub_out, mem_data_out, alu_out_val;
	
	// Create wires for instruction decoding
	wire[REG_ADD-1:0] rsrc_addr, rdest_addr, op_code, op_ext;
	wire[IMM-1:0] imm;
	
	// Setting instruction fields
	assign rsrc_addr = instr[3:0];
	assign rdest_addr = instr[11:8];
	assign imm = instr[7:0];
	assign op_code = instr[15:12];
	assign op_ext = instr[7:4]; 
	
	// create a sign extender
	signextend #(IMM) extend(imm, se_sign, imm_ext);
	
	// datapath registers
	flopenr #(WIDTH) pcreg(clk, reset, pc_en, pc_out, pc);
	flopenr #(WIDTH) instr_reg(clk, reset, inst_en, mem_out, instr);
	flopenr #(WIDTH) alu_out(clk, reset, alu_out_en, alu_res, alu_out_val);
	flopenr #(WIDTH) mem_data_reg(clk, reset, mem_reg_en, mem_out, mem_data_out);
	flopenr #(WIDTH) psr_reg(clk, reset, psr_en, PSR, psr_out);
	flopr   #(WIDTH) rsrc(clk, reset, rd1, Rsrc);	
   flopr   #(WIDTH) rdest(clk, reset, rd2, Rdest);
	
	// datapath muxes all of the _s variables are control signals
	mux2 #(WIDTH) mem_mux(Rdest, pc_out, mem_s, mem_addr);
	mux2 #(WIDTH) pc_mux(Rsrc, alu_out, pc_s, pc_out);
	mux4 #(WIDTH) wd_mux(imm_ext, Rsrc, mem_out, alu_out, wd_s, wd); // CONST_ZERO is a placeholder for no connection
	mux4 #(WIDTH) alua_mux(Rsrc, pc_out, imm_ext, CONST_ZERO, alua_s, alua_out); // CONST_ZERO is a placeholder for no connection
	mux4 #(WIDTH) alub_mux(Rdest, imm_ext, CONST_ONE, CONST_ONE, alub_s, alub_out);
	
	// Instantiate the register file, the alu, the alucont
   regfile    #(WIDTH,REGBITS) rf(clk, reg_wr, rsrc_addr, rdest_addr, Rdest, wd, rd1, rd2);
   alu        #(WIDTH) 			 alunit(Rsrc, Rdest, alucont, alu_res, PSR);
	alucontrol alu_cont(op_code, op_ext, alucont);
						
endmodule 
