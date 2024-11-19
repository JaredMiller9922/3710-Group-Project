module GroupProject3710 #(parameter WIDTH = 16, REGBITS = 4) (
	input clk, reset,
	input [7:0] switches,
	output [7:0] LEDs_a, LEDs_b
);

	wire we_a, we_b;
	wire [WIDTH-1:0] data_a, data_b, readMemData_a, readMemData_b;
	wire [WIDTH-1:0] addr_a, addr_b;
	wire [WIDTH-1:0] q_a, q_b;


	CPU computation (
		.clk(clk),              	// 50MHz clock
		.reset(reset),             // active-low reset
		.mem_out(readMemData_a),   // data that is read from memory
		.MEM_WR_S(we_a),           // write-enable to memory
		.mem_addr(addr_a),         // address to memory
		.writedata(data_a)      	// write data to memory
		);


	// Instantiate bram
	bram mem (
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


	wire a_enable, b_enable, io_a, io_b;

	// Memory-Mapped I/O for a
	assign io_a = addr_a[15] & addr_a[14];
	assign a_enable = io_a & we_a;

	flopenr flop_a(~clk, reset, a_enable, data_a, LEDs_a); 
	mux2 mux_a(q_a, {8'b0, switches}, io_a, readMemData_a);

	// Memory-Mapped I/O for b
	assign io_b = addr_b[9] & addr_b[8];
	assign b_enable = io_b & we_b;

	flopenr flop_b(~clk, reset, b_enable, data_b, LEDs_b); 
	mux2 mux_b(q_b, {8'b0, switches}, io_b, readMemData_b);
 

endmodule
