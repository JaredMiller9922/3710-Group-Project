module controller(input            clk, reset, 
                  input      [3:0] op, 
						input      [3:0] op_ext,
						input		  [3:0] branch_cond,
						input 	  [4:0] PSR,
						// TODO (JM): I commented this out but didn't delete it just in case Jesse wanted it
                  // output [1:0] WD_S, ALUA_S, ALUB_S <= 2'b00;
						output reg [1:0] WD_S, ALUA_S, ALUB_S, MEM_DATA_S,
						output reg PC_S, PC_EN, REG_WR_EN, INSTR_EN, ALU_OUT_EN, MEM_REG_EN, MEM_WR_S, MEM_S, SE_SIGN, PSR_EN
						);

	// Paramaters used for state names allows for easy 
	// changing of state encodings
   parameter   FETCH			=  5'b00000;
   parameter   DECODE  		=  5'b00001;
   parameter   RTYPE_EX 	=  5'b00010;
   parameter   ITYPE_EX 	=  5'b00011;
   parameter   WRITE			=  5'b00100;
   parameter   LB_MEM		=  5'b00101;
   parameter   LB_LOAD 		=  5'b00110;
   parameter   SB_MEM_R		=  5'b00111;
   parameter   B_COND 		=  5'b01000;
	parameter   J_COND 		=  5'b01001;
   parameter   CALC_DISP	=  5'b01010;
	parameter   JUMP			=  5'b01011;
   parameter   CALC_RLINK	=  5'b01100;
	parameter   WR_RLINK_J	=  5'b01101;
	parameter   PC_UP			=  5'b01110;
	parameter	SB_MEM_I		=  5'b01111;
	parameter   PURGATORY	=  5'b11111;

	// parameters used for instruction types 
   parameter   OP_EXT	=  4'b0100;
	parameter   SB			=  4'b0100;
	parameter   LB			=  4'b0000;
	parameter   JCOND		=  4'b1100;
	parameter   JAL		=  4'b1000;
	parameter   CMP		=  4'b1011;
	
	
   parameter   RTYPE		=  4'b0000;
	parameter   LSH		=  4'b1000;
   parameter   BCOND		=  4'b1100;
	
	parameter   ANDI		=  4'b0001;
	parameter   ORI		=  4'b0010;
	parameter   XORI		=  4'b0011;
	parameter   MOVI		=  4'b1101;
	
	wire branch;
	
	conditionCheck cond_check(branch_cond, PSR, branch);
	
   reg [4:0] state, nextstate;       // state register and nextstate value
   reg       pcwrite, pcwritecond;   // Write to the PC? 

   // state register
   always @(posedge clk)
      if(~reset) state <= FETCH;
      else state <= nextstate;

   // next state logic (Combinational) 
   always @(*)
      begin
         case(state)
            FETCH:  nextstate <= DECODE;
            DECODE:  case(op)
                        OP_EXT:	case(op_ext)
										SB:		nextstate <= SB_MEM_R;
										LB:		nextstate <= LB_MEM;
										JCOND:
											begin
												case(branch)
													1 : nextstate <= JUMP;
													default : nextstate <= PC_UP;
												endcase
											end
										JAL:		nextstate <= CALC_RLINK;
										default: nextstate <= PURGATORY; // should never happen
										endcase
                        RTYPE:   nextstate <= RTYPE_EX;
								LSH:   case(op_ext)
										4'b0100:      nextstate <= RTYPE_EX;	// LSH
										default: nextstate <= ITYPE_EX; // should happen
									endcase
								BCOND: 											
									begin
										case(branch)
											1 : nextstate <= CALC_DISP;
											default : nextstate <= PC_UP;
										endcase
									end
                        default: nextstate <= ITYPE_EX; // should often happen
                     endcase
            RTYPE_EX:  case(op_ext)
									CMP:      nextstate <= PC_UP;
									default: nextstate <= WRITE; // should happen
                     endcase
            ITYPE_EX:	case(op)
									CMP:      nextstate <= PC_UP;
									default: nextstate <= WRITE; // should happen
                     endcase
				WRITE:    nextstate <= PC_UP;
            LB_MEM:	nextstate <= LB_LOAD;
            LB_LOAD:	nextstate <= PC_UP;
            SB_MEM_R:	nextstate <= PC_UP;
            B_COND:	case(branch)
									1'b1:      	nextstate <= CALC_DISP;
									default: 	nextstate <= PC_UP; // should happen
                     endcase
				J_COND:	case(branch)
									1'b1:      	nextstate <= JUMP;
									default: 	nextstate <= PC_UP; // should happen
                     endcase
				CALC_DISP:   nextstate <= FETCH;
            JUMP:     nextstate <= FETCH;
				CALC_RLINK: nextstate <= WR_RLINK_J;
            WR_RLINK_J: nextstate <= FETCH;
				PC_UP: nextstate <= FETCH;
            default: nextstate <= PURGATORY; // should never happen
         endcase
      end

	// This combinational block generates the outputs from each state. 
   always @(*)
      begin
			// set all outputs to zero, then conditionally assert just the appropriate ones
			WD_S <= 2'b00;
			ALUA_S <= 2'b00;
			ALUB_S <= 2'b00;
			PC_S <= 0;
			PC_EN <= 0;
			MEM_S <= 0;
			MEM_DATA_S <= 0;
			REG_WR_EN <= 0;
			INSTR_EN <= 0;
			ALU_OUT_EN <= 0;
			MEM_REG_EN <= 0;
			MEM_WR_S <= 0;
			SE_SIGN <= 1;
			PSR_EN <= 0;
				
         case(state)
			FETCH: 
				begin
				MEM_S <= 1;
				INSTR_EN <= 1;
				end
         DECODE: 
			begin
			end
			RTYPE_EX:
				begin
				ALU_OUT_EN <= 1;
				PSR_EN <= 1;
				end
			WRITE:
			begin
				WD_S <= 2'b11;
				REG_WR_EN <= 1;
			end
			PC_UP:
				begin
				ALUA_S <= 2'b01;
				ALUB_S <= 2'b10;
				PC_S <= 1;
				PC_EN <= 1;
				end
			ITYPE_EX:
				begin
				ALUA_S <= 2'b10;
				ALU_OUT_EN <= 1;
				PSR_EN <= 1;
				case(op)			// DO 0 EXTEND ON THESE I-TYPE INSTRUCTIONS AND SIGN EXTEND FOR EVERYTHING ELSE
					ANDI:		SE_SIGN <= 0;
					ORI:		SE_SIGN <= 0;
					XORI:		SE_SIGN <= 0;
					default: SE_SIGN <= 1; // should happen
            endcase
            end
				LB_MEM:
				begin
					WD_S <= 2'b10;
					MEM_REG_EN <= 1;
				end
				LB_LOAD:
					begin
					WD_S <= 2'b10;
					REG_WR_EN <= 1;
					end
            SB_MEM_R:
					begin
					MEM_WR_S <= 1;
					MEM_DATA_S <= 0;
					end
				CALC_DISP: 
					begin
					ALUA_S <= 2'b01;
					ALUB_S <= 2'b01;
					PC_S <= 1;
					PC_EN <= 1;
               end
				JUMP:
					begin
					PC_EN <= 1;
					end
				CALC_RLINK:
					begin
					ALUA_S <= 2'b01;
					ALUB_S <= 2'b10;
					ALU_OUT_EN <= 1;
					end
             WR_RLINK_J:
					begin
					WD_S <= 2'b11;
					PC_EN <= 1;
					REG_WR_EN <= 1;
               end
				default: 
					begin
					
					end
         endcase
      end
	// TODO (JM): I commented this out but didn't delete it just in case Jesse wanted it
   // assign pcen = pcwrite | (pcwritecond & zero);
endmodule