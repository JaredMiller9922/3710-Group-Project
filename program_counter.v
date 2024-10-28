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


module mux4 #(parameter WIDTH = 16)
             (input      [WIDTH-1:0] d0, d1, d2, d3,
              input      [1:0]       s, 
              output reg [WIDTH-1:0] y);

   always @(*)
      case(s)
         2'b00: y <= d0;
         2'b01: y <= d1;
         2'b10: y <= d2;
         2'b11: y <= d3;
      endcase
endmodule