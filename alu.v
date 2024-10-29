// the ALU performs the arithmetic functions. 
module alu #(parameter WIDTH = 16)
            (input      [WIDTH-1:0] Rsrc, Rdest, 
             input      [2:0]       alucont, 
             output reg [WIDTH-1:0] result,
                 output reg [4:0] PSR // C F L Z N
                 );						  // 0 1 2 3 4 

   wire [WIDTH-1:0] b2, sum, slt;
	reg cary;

   always@(*) begin
		PSR = 5'b0;
      case(alucont)
            3'b000: // Addition
            begin
					 {cary, result} = Rsrc + Rdest;
                PSR[0] = cary;
                PSR[1] = (Rdest[WIDTH-1] == Rsrc[WIDTH-1]) && (result[WIDTH-1] != Rdest[WIDTH-1]);
            end
            3'b001: // Subtraction
            begin
               {cary, result} = Rsrc - Rdest;
               PSR[0] = cary;
					PSR[1] <= (Rdest[WIDTH-1] != Rsrc[WIDTH-1]) && (result[WIDTH-1] != Rdest[WIDTH-1]); // Set F flag for signed overflow in subtraction.
					PSR[2] <= (Rdest < Rsrc); // Set L flag if Rdest is less than Rsrc (unsigned comparison).
         end
            3'b010: // Logical AND
            begin
               result <= Rsrc & Rdest; 
            end
            3'b011: // Logical XOR
            begin
               result <= Rsrc ^ Rdest; 
            end
            3'b100: // Logical OR
            begin
               result <= Rsrc | Rdest; 
            end
				3'b101: // Compare
				begin
					 // Set Zero flag (Z) if the result is zero.
					result <= Rsrc - Rdest;
					PSR[3] <= (Rsrc - Rdest == 0);
					PSR[4] <= (Rdest < Rsrc);
				end
            default: result <= 0; // Should never happen
      endcase
    end
endmodule