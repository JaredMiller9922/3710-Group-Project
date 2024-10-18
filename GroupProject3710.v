module GroupProject3710 #(parameter WIDTH = 16, REGBITS = 4) (
	input [3:0] opcode,
	input [3:0] opext,
	input clk, regwrite,
	input [REGBITS-1:0] ra1, ra2, wa, 
	input [WIDTH-1:0]   wd,
	input [WIDTH-1:0] Rsrc, Rdest
);

wire [WIDTH-1:0] rd1, rd2;
wire [2:0] alucont;
wire [WIDTH-1:0] result;

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

endmodule