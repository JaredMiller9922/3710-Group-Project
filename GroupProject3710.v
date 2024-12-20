module GroupProject3710 #(parameter WIDTH = 16, REGBITS = 4, ADDR_WIDTH = 10) (
    input clk, reset, ps2_clk, ps2_data,
	 input left_button, right_button, shoot_button,
	 output [7:0] LEDS,
    output [6:0] seg1, seg0,   // score segs
    output [7:0] VGA_R,        // VGA Red channel
    output [7:0] VGA_G,        // VGA Green channel
    output [7:0] VGA_B,        // VGA Blue channel
    output VGA_HS,             // VGA Horizontal Sync
    output VGA_VS,             // VGA Vertical Sync
    output VGA_BLANK_N,        // VGA Blank
    output VGA_SYNC_N,         // VGA Sync
    output VGA_CLK             // VGA Clock
);

    wire we_a, we_b;
    wire [WIDTH-1:0] data_a, data_b, readMemData_a, readMemData_b;
    wire [ADDR_WIDTH-1:0] addr_a, addr_b;
    wire [WIDTH-1:0] q_a, q_b;
    wire [WIDTH-1:0] keyboard_input;
	 reg [WIDTH-1:0] button_input;
    wire [7:0] score;
	 
	 //assign LEDS = keyboard_input;
	 assign keyboard_input = LEDS;

    CPU computation (
        .clk(clk),              // 50MHz clock
        .reset(reset),          // active-low reset
        .mem_out(readMemData_a),// data that is read from memory
        .MEM_WR_S(we_a),        // write-enable to memory
        .mem_addr(addr_a),      // address to memory
        .writedata(data_a)      // write data to memory
    );

    // Instantiate bram
    bram mem (
        .data_a(data_a),
        .data_b(data_b),
        .addr_a(addr_a), 
        .addr_b(addr_b),
        .we_a(we_a), 
        .we_b(0), 
        .clk(~clk), // clk or ~clk
        .q_a(q_a),  // output
        .q_b(q_b)   // output
    );
    
    ps2_keyboard keyboard (
        .clk(clk),
        .ps2_clk(ps2_clk),
        .ps2_data(ps2_data),
        .reset(reset),
        //.keyboard_input(keyboard_input), // output
		  .LEDS(LEDS)
    );
	 
	 // This is for the FPGA button to work
	 always @(*) begin
		 if (~left_button) begin
			  button_input <= 28;
		 end else if (~right_button) begin 
			  button_input <= 35;
		 end else if (~shoot_button)begin
			  button_input <= 41;
		 end else begin
			  button_input <= 0;
		 end
	 end	 

    vgaControl vga (
        .clk50MHz(clk),            // System clock
        .clr(reset),               // Clear signal
        .memReadData(q_b),
        .VGA_R(VGA_R),             // VGA Red channel
        .VGA_G(VGA_G),             // VGA Green channel
        .VGA_B(VGA_B),             // VGA Blue channel
        .VGA_HS(VGA_HS),           // VGA Horizontal Sync
        .VGA_VS(VGA_VS),           // VGA Vertical Sync
        .VGA_BLANK_N(VGA_BLANK_N), // VGA Blank
        .VGA_SYNC_N(VGA_SYNC_N),   // VGA Sync
        .VGA_CLK(VGA_CLK),         // VGA Clock
        .address(addr_b)
    );
    
    seven_seg_display score_display (
        .score(score[6:0]), // Input score in decimal (range 0-99)
        .seg1(seg1),        // Seven-segment output for tens digit
        .seg0(seg0)         // Seven-segment output for ones digit
    );

    wire a_enable, b_enable, io_a, io_b;

    // Memory-Mapped I/O for a
    assign io_a = addr_a[9] & addr_a[8];
    assign a_enable = io_a & we_a;

    flopenr flop_a(~clk, reset, a_enable, data_a, score); 
    mux2 mux_a(q_a, keyboard_input | button_input, io_a, readMemData_a);

endmodule
