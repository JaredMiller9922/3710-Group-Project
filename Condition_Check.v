

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


case(branch_cond)
									EQ:      nextstate <= PC_UP;
									default: nextstate <= WRITE; // should happen
                     endcase