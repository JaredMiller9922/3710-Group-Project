module GroupProject3710 #(parameter WIDTH = 16, REGBITS = 4) (
	input [3:0] opcode,
	input [3:0] opext,
	input clk, regwrite, we_a, we_b, reset,
	input [REGBITS-1:0] ra1, ra2, wa, 
	input [WIDTH-1:0]   wd,
	input [WIDTH-1:0] Rsrc, Rdest,
	input [9:0] switches,
	output [9:0] LEDs_a, LEDs_b,
	output [WIDTH-1:0] result, q_a, q_b
);

wire [WIDTH-1:0] rd1, rd2, data_a, data_b, readMemData_a, readMemData_b;
wire [2:0] alucont;
wire [9:0] addr_a, addr_b;
wire a_enable, b_enable, io_a, io_b;

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

// Instantiate bram
bram MEM (
	.data_a(data_a),
	.data_b(data_b),
	.addr_a(addr_a), 
	.addr_b(addr_b),
	.we_a(we_a), 
	.we_b(we_b), 
	.clk(~clk), // clk or ~clk
	.q_a(q_a), // output
	.q_b(q_b)  // output
);

// Memory-Mapped I/O for a
assign io_a = addr_a[9] & addr_a[8];
assign a_enable = io_a & we_a;

flopenr flop_a(~clk, reset, a_enable, data_a, LEDs_a); 
mux2 mux_a(q_a, switches, io_a, readMemData_a);

// Memory-Mapped I/O for b
assign io_b = addr_b[9] & addr_b[8];
assign b_enable = io_b & we_b;

flopenr flop_b(~clk, reset, b_enable, data_b, LEDs_b); 
mux2 mux_b(q_b, switches, io_b, readMemData_b);

//In Datapath
//flopenr     #(8)      instrmem(clk, reset, irwrite, memdata, instr);		 

endmodule




module signextend #(parameter WIDTH = 8)
                   (input [WIDTH-1:0] imm,
						  input 				  sign,
                    output [WIDTH+WIDTH-1:0] y);
   assign y = sign ? {{8{imm[7]}}, imm} : {{8{1'b0}}, imm};
endmodule

