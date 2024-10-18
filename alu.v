// the ALU performs the arithmetic functions. 
module alu #(parameter WIDTH = 16)
            (input      [WIDTH-1:0] Rsrc, Rdes, 
             input      [2:0]       alucont, 
             output reg [WIDTH-1:0] result);

   wire     [WIDTH-1:0] b2, sum, slt;

   always@(*)
      case(alucont)
			3'b010: 
			begin 
				result <= Rsrc + Rdes; // Addition
			end
			3'b110:
			begin
				result <= Rsrc + ~Rdes; // Subtraction
			end
			3'b000: 
			begin
				result <= Rsrc & Rdes; // Logical AND
			end
			3'b111: 
			begin
				result <= Rsrc ^ Rdes; // Logical XOR
			end
			3'b001: 
			begin
				result <= Rsrc | Rdes; // Logical OR
			end
			default: result <= 0; // Should never happen
      endcase
endmodule