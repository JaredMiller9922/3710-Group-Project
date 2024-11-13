module controller(input            clk, reset, 
                  input      [5:0] op, 
                  input            zero,
						input		  [3:0] branch_cond, 
                  output reg       memwrite, alusrca, memtoreg, iord, 
                  output           pcen, 
                  output reg       regwrite, regdst, 
                  output reg [1:0] pcsource, alusrcb, aluop, 
                  output reg [3:0] irwrite);

	// Paramaters used for state names allows for easy 
	// changing of state encodings
   parameter   FETCH			=  4'b0000;
   parameter   DECODE  		=  4'b0001;
   parameter   RTYPE_EX 	=  4'b0010;
   parameter   ITYPE_EX 	=  4'b0011;
   parameter   WRITE			=  4'b0100;
   parameter   LB_MEM		=  4'b0101;
   parameter   LB_LOAD 		=  4'b0110;
   parameter   SB_MEM		=  4'b0111;
   parameter   B_COND 		=  4'b1000;
	parameter   J_COND 		=  4'b1001;
   parameter   CALC_DISP	=  4'b1010;
	parameter   JUMP			=  4'b1011;
   parameter   CALC_RLINK	=  4'b1100;
	parameter   WR_RLINK_J	=  4'b1101;
	parameter   PC_UP			=  4'b1110;
	parameter   PURGATORY	=  4'b1111;

	// parameters used for instruction types 
   parameter   OP_EXT	=  4'b0100;
	parameter   SB			=  4'b0100;
	parameter   LB			=  4'b0000;
	parameter   JCOND		=  4'b1100;
	parameter   JAL		=  4'b1000;
	parameter   CMP		=  4'b1011;
	
	
   parameter   RTYPE		=  4'b0000;
   parameter   BCOND		=  4'b1100;
	
	
	//Condition_Check(branch_cond, branch);
	

	

   reg [3:0] state, nextstate;       // state register and nextstate value
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
                        OP_EXT:	case(op_ext)	//TODO add op_ext
										SB:		nextstate <= SB_MEM;
										LB:		nextstate <= LB_MEM;
										JCOND:	nextstate <= COND;
										JAL:		nextstate <= CALC_RLINK;
										default: nextstate <= PURGATORY; // should never happen
										endcase
                        RTYPE:   nextstate <= RTYPE_EX;
                        BCOND:     nextstate <= COND;
                        default: nextstate <= PURGATORY; // should never happen
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
            SB_MEM:	nextstate <= PC_UP;
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
            default: nextstate <= PURGATORY; // should never happen
         endcase
      end

	// This combinational block generates the outputs from each state. 
   always @(*)
      begin
            // set all outputs to zero, then conditionally assert just the appropriate ones
            irwrite <= 4'b0000;
            pcwrite <= 0; pcwritecond <= 0;
            regwrite <= 0; regdst <= 0;
            memwrite <= 0;
            alusrca <= 0; alusrcb <= 2'b00; aluop <= 2'b00;
            pcsource <= 2'b00;
            iord <= 0; memtoreg <= 0;
				
				
				WD_S <= 2'b00;
				ALU_A <= 2'b00;
				ALU_B <= 2'b00;
				PC_S <= 0;
				PC_EN <= 0;
				MEM_S <= 0;
				REG_WR_EN <= 0;
				INSTR_EN <= 0;
				ALU_OUT_EN <= 0;
				MEM_REG_EN <= 0;
				MEM_WR_S <= 0;
				
				
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
                  end
               WRITE:
                  begin
                     WD_S <= 2'b11;
							REG_WR_EN <= 1;
                  end
               PC_UP:
						begin
							ALU_A <= 2'b01;
							ALU_B <= 2'b10;
							PC_S <= 1;
							PC_EN <= 1;
						end
               ITYPE_EX:
                  begin
                     ALU_A <= 2'b01;
                     ALU_OUT_EN <= 1;
                  end
               LB_MEM:
                  begin
                     MEM_REG_EN <= 1;
                  end
               LB_LOAD:
                  begin
                     WD_S <= 2'b10;
                  end
               SB_MEM:
                  begin
                     MEM_WR_S <= 1;
                  end
               CALC_DISP: 
                  begin
                     ALU_A <= 2'b01;
							ALU_B <= 2'b01;
							PC_S <= 1;
							PC_EN <= 1;
                  end
               JUMP:
                  begin
                     PC_EN <= 1;
                  end
               CALC_RLINK:
                  begin
                     ALU_A <= 2'b01;
							ALU_OUT_EN <= 1;
                  end
               WR_RLINK_J:
                  begin
                     WD_S <= 2'b11;
							PC_EN <= 1;
							REG_WR_EN <= 1;
                  end
         endcase
      end
   assign pcen = pcwrite | (pcwritecond & zero); // program counter enable
endmodule