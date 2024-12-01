// A separate module to control the function that 
// that ALU is performing based on the opcode
module alucontrol(input 	  [3:0] opcode,
                  input      [3:0] opext, 
                  output reg [3:0] alucont);

   always @(*)
      case(opcode) // I-Type Instructions
         4'b0101: alucont <= 4'b0000; // add (for addi)
         4'b1001: alucont <= 4'b0001; // sub (for subi)
			4'b0001: alucont <= 4'b0010; // and (for andi)
			4'b0011: alucont <= 4'b0011; // xor (for xori)
			4'b0010: alucont <= 4'b0100; // or  (for ori)
			4'b1011: alucont <= 4'b0101; // comp (for compi)
			4'b1101: alucont <= 4'b0110; // mov (for movi)
			4'b1000:
				case (opext)
					4'b0100: alucont <= 4'b0111; // lsh
					default: alucont <= 4'b1000; // lshi
				endcase
			4'b1111: alucont <= 4'b1001; // lui
         default: case(opext)       // R-Type instructions
                     4'b0101: alucont <= 4'b0000; // add (for add)
                     4'b1001: alucont <= 4'b0001; // subtract (for sub)
                     4'b0001: alucont <= 4'b0010; // logical and (for and)
                     4'b0011: alucont <= 4'b0011; // logical xor (for xor)
							4'b0010: alucont <= 4'b0100; // logical or (for or)
							4'b1011: alucont <= 4'b0101; // compare
							4'b1101: alucont <= 4'b0110; // mov
							4'b0100: alucont <= 4'b1111; // MOVRI
                     default: alucont <= 4'b0000; // should never happen
                  endcase
      endcase
endmodule