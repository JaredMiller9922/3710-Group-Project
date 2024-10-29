module program_counter #(parameter WIDTH = 16)(
	input clk, reset, pcen, zero,
	input [1:0] pcsource,
	input [WIDTH-1:0] aluresult, aluout, constx4, nextpc, 
	output pc
);

	localparam CONST_ZERO = 16'b0;
	
   flopenr #(WIDTH) pcreg(clk, reset, pcen, nextpc, pc);
	mux4 #(WIDTH) pcmux(aluresult, aluout, constx4, CONST_ZERO, pcsource, nextpc);

endmodule