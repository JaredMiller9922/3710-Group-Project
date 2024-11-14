// TODO: we need to implment shift logic
// the ALU performs the arithmetic functions. 
module alu #(parameter WIDTH = 16)
            (input      [WIDTH-1:0] Rsrc, Rdest, 
             input      [2:0]       alucont, 
             output reg [WIDTH-1:0] result,
             output reg [4:0] PSR // C F L Z N
             );						  // 0 1 2 3 4 

   wire [WIDTH-1:0] b2, sum, slt;
	reg carry;

   always@(*) begin
		PSR = 5'b0;
		carry = 0;
		
      case(alucont)
            3'b000: // Addition
            begin
					 {carry, result} = Rsrc + Rdest;
                PSR[0] = carry;
                PSR[1] = (Rdest[WIDTH-1] == Rsrc[WIDTH-1]) && (result[WIDTH-1] != Rdest[WIDTH-1]);
            end
            3'b001: // Subtraction
            begin
               {carry, result} = Rdest - Rsrc;
               PSR[0] = carry;		// Tim's Code
					PSR[1] <= (Rdest[WIDTH-1] != Rsrc[WIDTH-1]) && (result[WIDTH-1] != Rdest[WIDTH-1]); // Set F flag for signed overflow in subtraction.
					//PSR[1] <= (Rsrc[WIDTH-1] != Rdest[WIDTH-1]) && (result[WIDTH-1] != Rsrc[WIDTH-1]); // Set F flag for signed overflow in subtraction.
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
					result <= Rdest - Rsrc;
					PSR[2] <= (Rdest < Rsrc); // Set L flag if Rdest is less than Rsrc (unsigned comparison).
					PSR[3] <= (Rsrc - Rdest == 0);    // Tim's Code
					PSR[4] <= ($signed(Rdest) < $signed(Rsrc));
					//PSR[3] <= (Rdest - Rsrc == 0);
					//PSR[4] <= (Rsrc < Rdest);
				end
				3'b110: // MOV
            begin
               result <= Rsrc;
            end
            default:
				begin
					result <= 0; // Should never happen
					carry <= 0; // Should never happen
				end
      endcase
    end
endmodule