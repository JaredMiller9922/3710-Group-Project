// This is the datapath module
module datapath #(paramter WIDTH = 16, REGBITS = 3)
(
	// Create localparams
	localparam CONST_ZERO = 16'b0;
	
	// Create wires
	
	// Instruction register and decoder
	// TODO: Next checkpoint
	
	// datapath registers
	flopenr #(WIDTH) pcreg(clk, reset, pcen, nextpc, pc); // Program Counter
	// TODO: Should the PSR be here
	
	// datapath muxes all of the _s variables are control signals
	mux2 #(WIDTH) wa_mux(Rsrc, Rdest, wa_s, wa);
	mux4 #(WIDTH) wd_mux(Imm, Rsrc, im_out, CONST_ZERO, wd_s, wd); // CONST_ZERO is a placeholder for no connection
	mux2 #(WIDTH) pc_mux(Rsrc, alu_out, pc_s, pc_out);
	mux2 #(WIDTH) shft_mux(Rsrc, Imm, shft_s, shft_out);
	mux4 #(WIDTH) alua_mux(Rsrc, pc_out, imm, CONST_ZERO, alua_s, alua_out); // CONST_ZERO is a placeholder for no connection
	
	// Instantiate the register file and the alu
);

endmodule 

// TODO: Delete this it is from MiniMips
module datapath #(parameter WIDTH = 8, REGBITS = 3)
                 (input              clk, reset, 
                  input  [WIDTH-1:0] memdata, 
                  input              alusrca, memtoreg, iord, pcen, regwrite, regdst,
                  input  [1:0]       pcsource, alusrcb, 
                  input  [3:0]       irwrite, 
                  input  [2:0]       alucont, 
                  output             zero, 
                  output [31:0]      instr, 
                  output [WIDTH-1:0] adr, writedata);

   // the size of the parameters must be changed to match the WIDTH parameter
   localparam CONST_ZERO = 8'b0;
   localparam CONST_ONE =  8'b1;

   wire [REGBITS-1:0] ra1, ra2, wa;
   wire [WIDTH-1:0]   pc, nextpc, md, rd1, rd2, wd, a, src1, src2, aluresult,
                          aluout, constx4;

   // shift left constant field by 2 - turns addreses
   // into word addresses
   assign constx4 = {instr[WIDTH-3:0],2'b00};

   // register file address fields
   assign ra1 = instr[REGBITS+20:21];
   assign ra2 = instr[REGBITS+15:16];
   mux2       #(REGBITS) regmux(instr[REGBITS+15:16], instr[REGBITS+10:11], regdst, wa);

   // load instruction into four 8-bit registers over four cycles
   flopenr     #(8)      ir0(clk, reset, irwrite[0], memdata[7:0], instr[7:0]);
   flopenr     #(8)      ir1(clk, reset, irwrite[1], memdata[7:0], instr[15:8]);
   flopenr     #(8)      ir2(clk, reset, irwrite[2], memdata[7:0], instr[23:16]);
   flopenr     #(8)      ir3(clk, reset, irwrite[3], memdata[7:0], instr[31:24]);

   // datapath registers and muxes
   flopenr    #(WIDTH)  pcreg(clk, reset, pcen, nextpc, pc);
   flopr      #(WIDTH)  mdr(clk, reset, memdata, md);
   flopr      #(WIDTH)  areg(clk, reset, rd1, a);	
   flopr      #(WIDTH)  wrd(clk, reset, rd2, writedata);
   flopr      #(WIDTH)  res(clk, reset, aluresult, aluout);
   mux2       #(WIDTH)  adrmux(pc, aluout, iord, adr);
   mux2       #(WIDTH)  src1mux(pc, a, alusrca, src1);
   mux4       #(WIDTH)  src2mux(writedata, CONST_ONE, instr[WIDTH-1:0], 
                                constx4, alusrcb, src2);
   mux4       #(WIDTH)  pcmux(aluresult, aluout, constx4, CONST_ZERO, pcsource, nextpc);
   mux2       #(WIDTH)  wdmux(aluout, md, memtoreg, wd);

   // instantiate the register file, ALU, and zerodetect on the ALU output
   regfile    #(WIDTH,REGBITS) rf(clk, regwrite, ra1, ra2, wa, wd, rd1, rd2);
   alu        #(WIDTH) alunit(src1, src2, alucont, aluresult);
   zerodetect #(WIDTH) zd(aluresult, zero);
endmodule