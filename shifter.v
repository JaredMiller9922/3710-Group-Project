module shifter #(parameter WIDTH = 16)
                   (input [WIDTH-1:0] imm,
						  input [WIDTH-1:0] amount,
						  input 				  dir,
                    output [WIDTH-1:0] y);
   assign y = dir ? imm >> amount : imm << amount;
endmodule
