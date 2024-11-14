// TODO: we need to implment shift logic
// the ALU performs the arithmetic functions. 
module alu #(parameter WIDTH = 16)
            (input      [WIDTH-1:0] Rsrc, Rdest, 
             input      [3:0]       alucont, 
             output reg [WIDTH-1:0] result,
             output reg [4:0] PSR // C F L Z N
             );						  // 0 1 2 3 4 

   wire [WIDTH-1:0] b2, sum, slt;
	reg carry;

   always@(*) begin
		PSR = 5'b0;
		carry = 0;
		
      case(alucont)
            4'b0000: // Addition
            begin
					 {carry, result} = Rsrc + Rdest;
                PSR[0] = carry;
                PSR[1] = (Rdest[WIDTH-1] == Rsrc[WIDTH-1]) && (result[WIDTH-1] != Rdest[WIDTH-1]);
            end
            4'b0001: // Subtraction
            begin
               {carry, result} = Rdest - Rsrc;
               PSR[0] = carry;		// Tim's Code
					//PSR[1] <= (Rdest[WIDTH-1] != Rsrc[WIDTH-1]) && (result[WIDTH-1] != Rdest[WIDTH-1]); // Set F flag for signed overflow in subtraction.
					//PSR[2] <= (Rdest < Rsrc); // Set L flag if Rdest is less than Rsrc (unsigned comparison).
					PSR[1] <= (Rsrc[WIDTH-1] != Rdest[WIDTH-1]) && (result[WIDTH-1] != Rsrc[WIDTH-1]); // Set F flag for signed overflow in subtraction.
					PSR[2] <= (Rsrc < Rdest); // Set L flag if Rdest is less than Rsrc (unsigned comparison).
				end
            4'b0010: // Logical AND
            begin
               result <= Rsrc & Rdest; 
            end
            4'b0011: // Logical XOR
            begin
               result <= Rsrc ^ Rdest; 
            end
            4'b0100: // Logical OR
            begin
               result <= Rsrc | Rdest; 
            end
				4'b0101: // Compare
				begin
					 // Set Zero flag (Z) if the result is zero.
					result <= Rdest - Rsrc;
					//PSR[3] <= (Rsrc - Rdest == 0);    // Tim's Code
					//PSR[4] <= (Rdest < Rsrc);
					PSR[3] <= (Rdest - Rsrc == 0);
					PSR[4] <= (Rsrc < Rdest);
				end
				4'b0110: // MOV
            begin
               result <= Rsrc;
            end
				4'b0111: // LSH
				begin
					// TODO: result <= Rdest shifted to the right once
					// if Ramount is negative shift left Ramount
					if (Rsrc[WIDTH-1] == 1)
					begin
						result <= Rdest << Rsrc;
					end
					else 
					begin
						result <= Rdest >> Rsrc;
					end
				end
				4'b1000: // LSHI
				begin
					if (Rsrc[4] == 0) 
					begin
						result <= Rdest << Rsrc; // Shift Left
					end
					else 
					begin
						result <= Rdest >> Rsrc; // Shift Right
					end		
				end
				4'b1001: // LUI
				begin 
					result <= {Rdest[15-8], 8'b00000000};
				end
            default:
				begin
					result <= 0; // Should never happen
					carry <= 0; // Should never happen
				end
      endcase
    end
endmodule