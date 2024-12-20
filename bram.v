// Quartus Prime Verilog Template
// True Dual Port RAM with single clock

module bram #(parameter DATA_WIDTH=16, parameter ADDR_WIDTH=10)
(
	input [(DATA_WIDTH-1):0] data_a, data_b,
	input [(ADDR_WIDTH-1):0] addr_a, addr_b,
	input we_a, we_b, clk,
	output reg [(DATA_WIDTH-1):0] q_a, q_b
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	
	// The $readmemb function allows you to load the
   // RAM with data on initialization to the FPGA
	initial begin
	$display("Loading memory");
	$readmemb("C:/Users/Blake/Documents/CS3710/groupwork/3710-Group-Project/program.dat", ram);
	//$readmemb("C:/Users/Jesse/Documents/GitHub/ECE 3710/3710-Group-Project/program.dat", ram);
	//$readmemb("C:/Users/jared/Desktop/Fall 2024/3710-Group-Project/program.dat", ram);
	//$readmemb("C:/Users/jared/Desktop/Fall 2024/3710-Group-Project/test.dat", ram);
	$display("done loading");
	end

	// Port A 
	always @ (posedge clk)
	begin
		if (we_a) 
		begin
			ram[addr_a] <= data_a;
			q_a <= data_a;
		end
		else 
		begin
			q_a <= ram[addr_a];
		end 
	end 

	// Port B 
	always @ (posedge clk)
	begin
		if (we_b) 
		begin
			ram[addr_b] <= data_b;
			q_b <= data_b;
		end
		else 
		begin
			q_b <= ram[addr_b];
		end 
	end

endmodule
