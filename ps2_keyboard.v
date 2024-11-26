module ps2_keyboard(
    input wire clk,          		// System clock
    input wire ps2_clk,       	// PS/2 clock line
    input wire ps2_data,      	// PS/2 data line
	 input wire reset,				// reset
	 output reg [15:0] keyboard_input
);

	 reg [7:0] scan_code;
    reg [10:0] shift_reg;    // 11-bit shift register for PS/2 data
    reg [3:0] bit_count;     // Count bits received
    reg parity;              // Parity check

    always @(negedge ps2_clk or negedge reset) begin
		if (!reset) begin
			bit_count <= 0;
			shift_reg <= 0;
		end
		else begin 
			if (bit_count < 10) begin
				 // Shift in data (11 bits total: start + 8 data + parity + stop)
				 shift_reg[bit_count] <= ps2_data; 
				 bit_count <= bit_count + 1;
			end 
			else begin
				 // Complete frame received
				 bit_count <= 0; // Reset bit count
				 // Extract 8-bit scan code and validate parity
				 scan_code <= shift_reg[8:1]; // Extract scan code
				 parity <= ~(^shift_reg[8:1]); // Calculate odd parity
				 // Scan codes that we want to accept as input for our game:
				 // 		  	MAKE CODE				  				BREAK CODE
				 // A - LEFT:  	 00011100	-> 1C		11110000 00011100	-> F0 1C
				 // D - RIGHT: 	 00100011	-> 23		11110000 00100011	-> F0 23
				 // W - UP:    	 00011101	-> 1D		11110000 00011101	-> F0 1D
				 // S - DOWN:  	 00011011	-> 1B		11110000 00011011	-> F0 1B
				 // SPACE - SHOOT: 00101001	-> 29		11110000 00101001	-> F0 29
				 // Any other key, we want to reject/not take it as input for the game.
				 if (scan_code == 8'h1C) begin // A - LEFT
					  keyboard_input <= 1;
				 end else if (scan_code == 8'h23) begin // D - RIGHT
					  keyboard_input <= 2;
				 end else if (scan_code == 8'h1D) begin // W - UP
				     keyboard_input <= 3;
				 end else if (scan_code == 8'h1B) begin // S - DOWN
				     keyboard_input <= 4;
				 end else if (scan_code == 8'h29) begin // SPACE - SHOOT
				     keyboard_input <= 5;
				 end else begin
					  keyboard_input <= 0;
				 end
			end
		end
	end
endmodule