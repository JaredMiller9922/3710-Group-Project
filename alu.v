// TODO: we need to implment shift logic
// the ALU performs the arithmetic functions. 
module alu #(parameter WIDTH = 16)
            (input      [WIDTH-1:0] Rsrc, Rdest, 
             input      [2:0]       alucont, 
             output reg [WIDTH-1:0] result,
                 output reg [5:0] PSR // C F L Z N
                 );

   wire     [WIDTH-1:0] b2, sum, slt;

   always@(*) begin
      case(alucont)
            3'b000: 
            begin 
                result <= Rsrc + Rdest; // Addition
                PSR[0] = result < Rdest;
                PSR[1] = (Rdest[WIDTH-1] == Rsrc[WIDTH-1]) && (result[WIDTH-1] != Rdest[WIDTH-1]);
            end
            3'b001:
            begin
                result <= Rsrc - Rdest; // Subtraction
                PSR[0] <= (Rdest > Rsrc); // Set C flag if there's a borrow in subtraction.
            PSR[1] <= (Rdest[WIDTH-1] != Rsrc[WIDTH-1]) && (result[WIDTH-1] != Rdest[WIDTH-1]); // Set F flag for signed overflow in subtraction.
            PSR[2] <= (Rdest < Rsrc); // Set L flag if Rdest is less than Rsrc (unsigned comparison).
         end
            3'b010: 
            begin
                result <= Rsrc & Rdest; // Logical AND
            end
            3'b011: 
            begin
                result <= Rsrc ^ Rdest; // Logical XOR
            end
            3'b100: 
            begin
                result <= Rsrc | Rdest; // Logical OR
            end
            default: result <= 0; // Should never happen
      endcase

        // Set Zero flag (Z) if the result is zero.
      PSR[3] <= (result == 0);

      // Set Negative flag (N) if the most significant bit (MSB) of the result is 1.
      PSR[4] <= result[WIDTH-1]; 
    end
endmodule