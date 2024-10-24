module GroupProject3710 #(parameter WIDTH = 16, REGBITS = 4) (
	input [3:0] opcode,
	input [3:0] opext,
	input clk, regwrite,
	input [REGBITS-1:0] ra1, ra2, wa, 
	input [WIDTH-1:0]   wd,
	input [WIDTH-1:0] Rsrc, Rdest,
	output [WIDTH-1:0] result
);

wire [WIDTH-1:0] rd1, rd2;
wire [2:0] alucont;

// Instantiate regfile
regfile regfile1 (
	.clk(clk),
	.regwrite(regwrite),
	.ra1(ra1),
	.ra2(ra2),
	.wa(wa),
	.wd(wd),
	.rd1(rd1),
	.rd2(rd2)
);
					  
// Instantiate alucontrol
alucontrol alucontrol1 (
	.opcode(opcode),
	.opext(opext),
	.alucont(alucont)
);

// Instantiate alu
alu alu1 (
	.Rsrc(Rsrc),
	.Rdest(Rdest),
	.alucont(alucont),
	.result(result)

);	

//Because it won't compile correctly otherwise
shifter #(16) shift (
	.imm(),
	.amount(),
	.dir(),
	.y()
);

//In Datapath
//flopenr     #(8)      instrmem(clk, reset, irwrite, memdata, instr);		 

endmodule




module signextend #(parameter WIDTH = 8)
                   (input [WIDTH-1:0] imm,
						  input 				  sign,
                    output [WIDTH+WIDTH-1:0] y);
   assign y = sign ? {{8{imm[7]}}, imm} : {{8{1'b0}}, imm};
endmodule

