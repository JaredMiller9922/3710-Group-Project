// A separate module to control the function that 
// that ALU is performing based on the opcode
module alucontrol(input 	  [3:0] opcode,
                  input      [3:0] opext, 
                  output reg [2:0] alucont);

   always @(*)
      case(opcode): // I-Type Instructions
         4'b0101: alucont <= 3'b000; // add (for addi)
         4'b1001: alucont <= 3'b001; // sub (for subi)
			4'b0001: alucont <= 3'b010; // and (for andi)
			4'b0011: alucont <= 3'b011; // xor (for xori)
			4'b0010: alucont <= 3'b100; // or  (for ori)
         default: case(opext)       // R-Type instructions
                     4'b0101: alucont <= 3'b010; // add (for add)
                     4'b1001: alucont <= 3'b110; // subtract (for sub)
                     4'b0001: alucont <= 3'b000; // logical and (for and)
                     4'b0011: alucont <= 3'b111; // logical xor (for xor)
							4'b0010: alucont <= 3'b001; // logical or (for or)
                     default: alucont <= 3'b101; // should never happen
                  endcase
      endcase
endmodule