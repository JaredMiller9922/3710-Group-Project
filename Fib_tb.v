// tb_MiniMips
module Fib_tb;

// We set the clk and reset to reg because they will be used in an always block
reg clk;
reg reset;
reg [15:0] switches;

// Create an instance of the MiniMips
GroupProject3710 uut (
	.clk(clk),
    .reset(reset),
	 .switches(switches)
);

// Create a clock
initial begin
	  clk = 0;
	  forever #5 clk = ~clk; // 50MHz clock  # 10 every cycle
	end

// Test Sequence
initial begin
    // Initialize variables
    reset <= 0;  // Assert reset (active low)
	 switches = 15'b10;

    // Hold reset for a few clock cycles
    #20 reset <= 1;  // De-assert reset (system comes out of reset)
    

    #2000000;
    if (uut.mem.ram[255] != 8'h0D) 
    //if (uut.cpu.dp.rf.RAM[255] != 8'h0d)
        $display("ERROR: mem.ram[255] should be 0x0D but was 0x%0h", uut.mem.ram[255]);
    else 
        $display("All is well");
    $finish;  // End the simulation after the test
end


endmodule