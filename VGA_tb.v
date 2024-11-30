module VGA_tb;

// We set the clk and reset to reg because they will be used in an always block
reg clk;
reg reset;
reg [15:0] switches;


parameter WIDTH = 16;
parameter ADDR_WIDTH=10;



wire [WIDTH-1:0] memReadData;
wire [ADDR_WIDTH-1:0] address;

// Create an instance of the VGAcontrol

vgaControl vga (
    .clk50MHz(clk),            // System clock
    .clr(reset),                 // Clear signal
	 .address(address)
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
	 switches = 15'b111;

    // Hold reset for a few clock cycles
    #20 reset <= 1;  // De-assert reset (system comes out of reset)
	 
	 
	 vga.mem.ram[10'b0100000000] = 16'b0000000000000001;
    

    
end


endmodule