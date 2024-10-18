// the ALU performs the arithmetic functions. 
module alu #(parameter WIDTH = 16)
            (input      [WIDTH-1:0] a, b, 
             input      [2:0]       alucont, 
             output reg [WIDTH-1:0] result);

   wire     [WIDTH-1:0] b2, sum, slt;

   assign b2 = alucont[2] ? ~b:b; 
   assign sum = a + b2 + alucont[2];

   always@(*)
      case(alucont[2:0])
         2'b00: result <= a & b;  // logical AND
         2'b01: result <= a | b;  // logical OR
         2'b10: result <= sum;    // Add/Sub
         2'b11: result <= a ^ b;  // set-less-than
      endcase
endmodule