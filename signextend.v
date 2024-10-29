module signextend #(parameter WIDTH = 8)
                   (input [WIDTH-1:0] imm,
						  input 				  sign,
                    output [WIDTH+WIDTH-1:0] y);
   assign y = sign ? {{8{imm[7]}}, imm} : {{8{1'b0}}, imm};
endmodule