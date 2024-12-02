module vgaControl #(parameter WIDTH = 16, parameter ADDR_WIDTH=10) (
    input clk50MHz,            // System clock
    input clr,                 // Clear signal
	 input [WIDTH-1:0] memReadData,	// Value read from memory
    output [7:0] VGA_R,        // VGA Red channel
    output [7:0] VGA_G,        // VGA Green channel
    output [7:0] VGA_B,        // VGA Blue channel
    output VGA_HS,             // VGA Horizontal Sync
    output VGA_VS,             // VGA Vertical Sync
    output VGA_BLANK_N,        // VGA Blank
    output VGA_SYNC_N,         // VGA Sync
    output VGA_CLK,             // VGA Clock
	 output reg [ADDR_WIDTH-1:0] address
);
    wire hSync, vSync, bright;
    wire [9:0] hCount, vCount;
    wire [2:0] rgb;
    wire [2:0] L, R;
	 //wire [WIDTH-1:0] memReadData;
	 
	 reg [15:0] pos0, pos1, pos2, pos3, pos4, pos5, pos6, pos7, pos8, pos9;
	 reg [15:0] pos10, pos11, pos12, pos13, pos14, pos15, pos16, pos17, pos18, pos19;
	 reg [15:0] pos20, pos21, pos22, pos23, pos24, pos25, pos26, pos27, pos28, pos29;
	 
    reg clk25MHz;
    
	// Timeing module for VGA control
	vgaTiming timing (
		.clk50MHz(clk50MHz),
		.clr(clr),
		.hSync(hSync),
		.vSync(vSync),
		.bright(bright),
		.hCount(hCount),
		.vCount(vCount)
	);

    // This bit gen is for displaying the solid colors on the screen
	bitGen color_gen (
		clk50MHz,
		bright,
		hCount,
		vCount,
		pos0, pos1, pos2, pos3, pos4, pos5, pos6, pos7, pos8, pos9,
		pos10, pos11, pos12, pos13, pos14, pos15, pos16, pos17, pos18, pos19,
		pos20, pos21, pos22, pos23, pos24, pos25, pos26, pos27, pos28, pos29,
		rgb
	);

	/*
	bram mem (
		.addr_b(address),
		.we_b(0), 
		.clk(clk50MHz), // clk or ~clk
		.q_b(memReadData)  // output
	);*/
    
    // This is the bitgen for displaying the tbird onto the screen
    /*
    TBird_bitGen_minimum tBirdGen (
        .bright(bright),
        .hCount(hCount),
        .vCount(vCount),
        .Left(L),
        .Right(R),
        .rgb(rgb)
    );
    
    // Instantiate thunderbird lights control
    thunder_bird_lights tbird (
        .Clk(clk50MHz), 
        .Clr(clr), 
        .LEFT(LEFT), 
        .RIGHT(RIGHT), 
        .HAZ(HAZ),
        .L(L),
        .R(R)
    );
    */


	initial begin
		address = 10'b0100000000;
   end 

    // Generate 25MHz clock for VGA from 50MHz system clock
    always @(posedge clk50MHz or negedge clr) begin
        if (clr == 0) begin
            clk25MHz <= 0;
				address = 10'b0011111111;
		  end
        else begin
            clk25MHz <= ~clk25MHz;
			
		
				if (address == 10'b0100000000)
					pos0 = memReadData;
				else if (address == 10'b0100000001)
					pos1 = memReadData;
				else if (address == 10'b0100000010)
					pos2 = memReadData;
				else if (address == 10'b0100000011)
					pos3 = memReadData;
				else if (address == 10'b0100000100)
					pos4 = memReadData;
				else if (address == 10'b0100000101)
					pos5 = memReadData;
				else if (address == 10'b0100000110)
					pos6 = memReadData;
				else if (address == 10'b0100000111)
					pos7 = memReadData;
				else if (address == 10'b0100001000)
					pos8 = memReadData;
				else if (address == 10'b0100001001)
					pos9 = memReadData;
				else if (address == 10'b0100001010)
					pos10 = memReadData;
				else if (address == 10'b0100001011)
					pos11 = memReadData;
				else if (address == 10'b0100001100)
					pos12 = memReadData;
				else if (address == 10'b0100001101)
					pos13 = memReadData;
				else if (address == 10'b0100001110)
					pos14 = memReadData;
				else if (address == 10'b0100001111)
					pos15 = memReadData;
				else if (address == 10'b0100010000)
					pos16 = memReadData;
				else if (address == 10'b0100010001)
					pos17 = memReadData;
				else if (address == 10'b0100010010)
					pos18 = memReadData;
				else if (address == 10'b0100010011)
					pos19 = memReadData;
				else if (address == 10'b0100010100)
					pos20 = memReadData;
				else if (address == 10'b0100010101)
					pos21 = memReadData;
				else if (address == 10'b0100010110)
					pos22 = memReadData;
				else if (address == 10'b0100010111)
					pos23 = memReadData;
				else if (address == 10'b0100011000)
					pos24 = memReadData;
				else if (address == 10'b0100011001)
					pos25 = memReadData;
				else if (address == 10'b0100011010)
					pos26 = memReadData;
				else if (address == 10'b0100011011)
					pos27 = memReadData;
				else if (address == 10'b0100011100)
					pos28 = memReadData;
				else if (address == 10'b0100011101)
					pos29 = memReadData;
				else if (address == 10'b0100011110) begin
					//pos30 = memReadData;
					address = 10'b0011111111;
				end
				address = address + 1;
			end
		
    end
	 
	 
	 always @(address) 
	 begin
		/*
		//if (address == 10'b0100000000)
			//pos0 = memReadData;
		if (address == 10'b0100000001)
			pos0 = memReadData;
		else if (address == 10'b0100000010)
			pos1 = memReadData;
		else if (address == 10'b0100000011)
			pos2 = memReadData;
		else if (address == 10'b0100000100)
			pos3 = memReadData;
		else if (address == 10'b0100000101)
			pos4 = memReadData;
		else if (address == 10'b0100000110)
			pos5 = memReadData;
		else if (address == 10'b0100000111)
			pos6 = memReadData;
		else if (address == 10'b0100001000)
			pos7 = memReadData;
		else if (address == 10'b0100001001)
			pos8 = memReadData;
		else if (address == 10'b0100001010)
			pos9 = memReadData;
		else if (address == 10'b0100001011)
			pos10 = memReadData;
		else if (address == 10'b0100001100)
			pos11 = memReadData;
		else if (address == 10'b0100001101)
			pos12 = memReadData;
		else if (address == 10'b0100001110)
			pos13 = memReadData;
		else if (address == 10'b0100001111)
			pos14 = memReadData;
		else if (address == 10'b0100010000)
			pos15 = memReadData;
		else if (address == 10'b0100010001)
			pos16 = memReadData;
		else if (address == 10'b0100010010)
			pos17 = memReadData;
		else if (address == 10'b0100010011)
			pos18 = memReadData;
		else if (address == 10'b0100010100)
			pos19 = memReadData;
		else if (address == 10'b0100010101)
			pos20 = memReadData;
		else if (address == 10'b0100010110)
			pos21 = memReadData;
		else if (address == 10'b0100010111)
			pos22 = memReadData;
		else if (address == 10'b0100011000)
			pos23 = memReadData;
		else if (address == 10'b0100011001)
			pos24 = memReadData;
		else if (address == 10'b0100011010)
			pos25 = memReadData;
		else if (address == 10'b0100011011)
			pos26 = memReadData;
		else if (address == 10'b0100011100)
			pos27 = memReadData;
		else if (address == 10'b0100011101)
			pos28 = memReadData;
		else if (address == 10'b0100011110)
			pos29 = memReadData;
		*/
	 end
	 
	 

    // Assign RGB outputs to VGA pins
    assign VGA_R = {8{rgb[2]}};
    assign VGA_G = {8{rgb[1]}};
    assign VGA_B = {8{rgb[0]}};
    assign VGA_HS = hSync;
    assign VGA_VS = vSync;
    
    // VGA_BLANK_N is high when in the bright region, otherwise low
    assign VGA_BLANK_N = bright;

    // VGA_SYNC_N tied to 0, as sync-on-green is not used
    assign VGA_SYNC_N = 1'b0;

    // VGA_CLK is the pixel clock (25MHz)
    assign VGA_CLK = clk25MHz;

endmodule
