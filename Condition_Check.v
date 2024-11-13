module Condition_Check (
		input [3:0] branch_cond,
		input [4:0] PSR, // C F L Z N
		output branch
		);

	// Condition codes
	parameter   EQ	=  4'b0000;
	parameter   NE	=  4'b0001;
	parameter   GE	=  4'b1101;
	parameter   CS	=  4'b0010;
	parameter   CC	=  4'b0011;
	parameter   HI	=  4'b0100;
	parameter   LS	=  4'b0101;
	parameter   LO	=  4'b1010;
	parameter   HS	=  4'b1011;
	parameter   GT	=  4'b0110;
	parameter   LE	=  4'b0111;
	parameter   FS	=  4'b1000;
	parameter   FC	=  4'b1001;
	parameter   LT	=  4'b1100;
	parameter   UC	=  4'b1110;
	

	always @(*)
      begin
		branch <= 0;
		case(branch_cond)
				EQ:	begin
							if (PSR[3] == 1) begin
								branch <= 1;
							end
						end
				NE:	begin
							if (PSR[3] == 0) begin
								branch <= 1;
							end
						end
				GE:	begin  // C F L Z N
							if (PSR[3] == 1 || PSR[4] == 1) begin
								branch <= 1;
							end
						end
				CS:	begin
							if (PSR[1] == 1) begin
								branch <= 1;
							end
						end
				CC:	begin
							if (PSR[1] == 0) begin
								branch <= 1;
							end
						end
				HI:	begin
							if (PSR[2] == 1) begin
								branch <= 1;
							end
						end
				LS:	begin		// C F L Z N
							if (PSR[2] == 0) begin
								branch <= 1;
							end
						end
				LO:	begin
							if (PSR[2] == 0 && PSR[3] == 0) begin
								branch <= 1;
							end
						end
				HS:	begin
							if (PSR[2] == 1 || PSR[3] == 1) begin
								branch <= 1;
							end
						end
				GT:	begin
							if (PSR[4] == 1) begin
								branch <= 1;
							end
						end
				LE:	begin
							if (PSR[4] == 0) begin
								branch <= 1;
							end
						end
				FS:	begin
							if (PSR[1] == 1) begin
								branch <= 1;
							end
						end
				FC:	begin
							if (PSR[1] == 0) begin
								branch <= 1;
							end
						end
				LT:	begin
							if (PSR[4] == 0 && PSR[3] == 0) begin
								branch <= 1;
							end
						end
				UC:	begin
							branch <= 1;
						end
				
				
				default: branch <= 0; // should never happen
		endcase
		end
	
	
endmodule