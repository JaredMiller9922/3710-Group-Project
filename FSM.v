module FSM #(parameter WIDTH = 16, WRITE = 1'b0, READ = 1'b1)
                   (input State,
						  output reg we_a,
						  output reg we_b);
						  
   always @(*) begin
		case (State)
				WRITE: begin
					 we_a <= 1; // Enable writing
					 we_b <= 1;
				end
				READ: begin
					 we_a <= 0; // Disable writing
					 we_b <= 0;
				end
		  endcase
	 end
endmodule
