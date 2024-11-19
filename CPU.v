// A separate module to control the function that 
// that ALU is performing based on the opcode
module CPU #(parameter WIDTH = 16, REGBITS = 4, IMM = 8, REG_ADD = 4, PSRL = 5)
	(
	input clk,                  	// 50MHz clock
	input reset,                	// active-low reset
	input [WIDTH-1:0] mem_out,  	// data that is read from memory
   output MEM_WR_S,            	// write-enable to memory
   output [WIDTH-1:0] mem_addr,  // address to memory
   output [WIDTH-1:0] writedata  // write data to memory
	);
	
	
	wire [3:0] OP_CODE;
	wire [3:0] OP_EXT;
	wire [3:0] branch_cond;
	wire [4:0] PSR_OUT;
	// TODO (JM): I commented this out but didn't delete it just in case Jesse wanted it
	// output [1:0] WD_S, ALUA_S, ALUB_S <= 2'b00;
	wire [1:0] WD_S, ALUA_S, ALUB_S;
	wire PC_S, PC_EN, REG_WR, INSTR_EN, ALU_OUT_EN, MEM_REG_EN, MEM_S, SE_SIGN, PSR_EN;
	
	controller cont(
				  clk, reset, 
              OP_CODE, 
				  OP_EXT,
				  branch_cond,
				  PSR_OUT,
				  WD_S, ALUA_S, ALUB_S,
				  PC_S, PC_EN, REG_WR, INSTR_EN, ALU_OUT_EN, MEM_REG_EN, MEM_WR_S, MEM_S, SE_SIGN, PSR_EN
				  );
				  
	datapath dp(
				.clk(clk), 
				.reset(reset),
				.PC_S(PC_S), 					// Selector bits for all mux2
				.MEM_S(MEM_S), 				// Selector bits for all mux2
				.WD_S(WD_S), 					// Selector bits for all mux4
				.ALUA_S(ALUA_S), 				// Selector bits for all mux4
				.ALUB_S(ALUB_S),	   		// Selector bits for all mux4
				.INSTR_EN(INSTR_EN), 		// Flopenr bits
				.ALU_OUT_EN(ALU_OUT_EN), 	// Flopenr bits
				.MEM_REG_EN(MEM_REG_EN), 	// Flopenr bits
				.PC_EN(PC_EN),					// Flopenr bits
				.PSR_EN(PSR_EN),				// Flopenr bits
				.SE_SIGN(SE_SIGN), 			// Control Signals
				.REG_WR(REG_WR), 		// Control Signals
				.MEM_OUT(mem_out),			// Inputs for MEM_OUT and instr
				.Rdest(writedata), 			// Values that allow memory access
				.MEM_ADDR(mem_addr),			// Values that allow memory access
				.PSR_OUT(PSR_OUT),
				.OP_CODE(OP_CODE),
				.OP_EXT(OP_EXT),
				.Rdest_addr(branch_cond)
				);

	
	
	
   //controller  cont(clk, reset, instr[31:26], zero, memwrite, 
   //                 alusrca, memtoreg, iord, pcen, regwrite, regdst,
   //                 pcsource, alusrcb, aluop, irwrite);
   //alucontrol  ac(aluop, instr[5:0], alucont);
   //datapath    #(WIDTH, REGBITS) 
   //            dp(clk, reset, memdata, alusrca, memtoreg, iord, pcen,
   //               regwrite, regdst, pcsource, alusrcb, irwrite, alucont,
   //               zero, instr, adr, writedata);
	
endmodule