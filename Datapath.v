// This is the datapath module
module datapath #(parameter WIDTH = 16, REGBITS = 4, IMML = 8, REG_ADD = 4, PSRL = 5)
					  (input clk, reset,
					   input PC_S, MEM_DATA_S, 						// Selector bits for all mux2
						input [1:0] MEM_S, WD_S, ALUA_S, ALUB_S,	   			// Selector bits for all mux4
						input INSTR_EN, ALU_OUT_EN, MEM_REG_EN, PC_EN,	// Flopenr bits
						input PSR_EN,												// Flopenr bits
						
						input SE_SIGN, REG_WR, 									// Control Signals
						input [WIDTH-1:0] MEM_OUT,								// Inputs for MEM_OUT and INSTR
						
						output [WIDTH-1:0] MEM_DATA, MEM_ADDR,				// Values that allow memory access
						output [PSRL-1:0] PSR_OUT,
						output [REG_ADD-1:0] OP_CODE, OP_EXT, Rdest_addr
);

	// Create localparams
	localparam CONST_ZERO = 16'b0;
	localparam CONST_ONE = 16'b1;
	
	// Create wires
	wire [WIDTH-1:0] IMM_EXT, PC_OUT, PC, Rsrc, ALU_RES, WD, ALUA_OUT, ALUB_OUT, MEM_DATA_OUT, ALU_OUT_VAL, INSTR, Rdest, rd1, rd2;
	wire [REG_ADD-1:0] alucont;
	wire [PSRL-1:0] PSR;
	wire [REG_ADD-1:0] op_cont;
	
	// Create wires for INSTRuction decoding
	wire[REG_ADD-1:0] Rsrc_addr;  //, Rdest_addr;
	wire[IMML-1:0] IMM;
	
	// Create wire to store random number
	wire[7:0] random_num;
	
	// Setting INSTRuction fields
	assign Rsrc_addr = INSTR[3:0];
	assign Rdest_addr = INSTR[11:8];
	assign IMM = INSTR[7:0];
	assign OP_CODE = INSTR[15:12];
	assign OP_EXT = INSTR[7:4]; 
	
	// create a sign extender
	signextend #(IMML) extend(IMM, SE_SIGN, IMM_EXT);
	
	// datapath registers
	flopenr #(WIDTH) pcreg(clk, reset, PC_EN, PC, PC_OUT);
	flopenr #(WIDTH) instr_reg(clk, reset, INSTR_EN, MEM_OUT, INSTR);
	flopenr #(WIDTH) alu_out(clk, reset, ALU_OUT_EN, ALU_RES, ALU_OUT_VAL);
	flopenr #(WIDTH) mem_data_reg(clk, reset, MEM_REG_EN, MEM_OUT, MEM_DATA_OUT);
	flopenr #(WIDTH) psr_reg(clk, reset, PSR_EN, PSR, PSR_OUT);
	flopr   #(WIDTH) rsrc(clk, reset, rd1, Rsrc);	
   flopr   #(WIDTH) rdest(clk, reset, rd2, Rdest);
	
	// datapath muxes all of the _s variables are control signals
	
	mux2 #(WIDTH) pc_update_mux(OP_CODE, 4'b0101, PC_EN, op_cont);
	mux2 #(WIDTH) mem_data_mux(Rdest, IMM_EXT, MEM_DATA_S, MEM_DATA);
	mux4 #(WIDTH) mem_mux(Rsrc, PC_OUT, Rdest, CONST_ZERO, MEM_S, MEM_ADDR);
	mux2 #(WIDTH) pc_mux(Rsrc, ALU_RES, PC_S, PC);
	mux4 #(WIDTH) wd_mux(IMM_EXT, Rsrc, MEM_DATA_OUT, ALU_OUT_VAL, WD_S, WD); // CONST_ZERO is a placeholder for no connection
	mux4 #(WIDTH) alua_mux(Rsrc, PC_OUT, IMM_EXT, CONST_ZERO, ALUA_S, ALUA_OUT); // CONST_ZERO is a placeholder for no connection
	mux4 #(WIDTH) alub_mux(Rdest, IMM_EXT, CONST_ONE, CONST_ZERO, ALUB_S, ALUB_OUT);
	
	// Instantiate the register file, the alu, the alucont, and ran_gen
   regfile    #(WIDTH,REGBITS) rf(clk, REG_WR, Rsrc_addr, Rdest_addr, Rdest_addr, WD, rd1, rd2);
   alu        #(WIDTH) 			 alunit(ALUA_OUT, ALUB_OUT, alucont, random_num, ALU_RES, PSR);
	alucontrol alu_cont(op_cont, OP_EXT, alucont);
	random_gen ran_gen(clk, reset, 8'b00000000, IMM_EXT, random_num); 
endmodule 
