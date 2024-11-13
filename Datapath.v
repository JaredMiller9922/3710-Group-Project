// This is the datapath module
module datapath #(parameter WIDTH = 16, REGBITS = 3, IMM = 8, REG_ADD = 4)
					  (input clk, reset,
					   input pc_s, mem_s, 						// Selector bits for all mux2
						input [1:0] wd_s, alua_s, alub_s,	// Selector bits for all mux4
						input pc_en,
						input sign_ext_s,
						input regwrite,
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
	flopenr #(WIDTH) alu_out(clk, reset, alu_out_en, alu_res, alu_out);
	flopenr #(WIDTH) mem_data_reg(clk, reset, mem_reg_en, mem_data_out);
	flopr   #(WIDTH) rsrc(clk, reset, rd1, Rsrc);	
   flopr   #(WIDTH) rdest(clk, reset, rd2, Rdest);
	
	// datapath muxes all of the _s variables are control signals
	mux2 #(WIDTH) mem_mux(Rdest, pc_out, mem_s, mem_addr);
	mux4 #(WIDTH) wd_mux(imm_ext, Rsrc, mem_out, alu_out, wd_s, wd); // CONST_ZERO is a placeholder for no connection
	mux2 #(WIDTH) pc_mux(Rsrc, alu_out, pc_s, pc_out);
	mux4 #(WIDTH) alua_mux(Rsrc, pc_out, imm_ext, CONST_ZERO, alua_s, alua_out); // CONST_ZERO is a placeholder for no connection
	mux4 #(WIDTH) alub_mux(Rdest, imm_ext, CONST_ONE, CONST_ONE, alub_s, alub_out);
	
	// Instantiate the register file, the alu, and the alucont
   regfile    #(WIDTH,REGBITS) rf(clk, regwrite, rsrc_addr, rdest_addr, Rdest, wd, rd1, rd2);
   alu        #(WIDTH) 			 alunit(Rsrc, Rdest, alucont, alu_res);
	alucontrol alu_cont(op_code, op_ext, alucont);
						
endmodule 
