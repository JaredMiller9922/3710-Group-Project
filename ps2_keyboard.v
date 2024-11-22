module ps2_keyboard(
    input wire clk,          		// System clock
    input wire ps2_clk,       	// PS/2 clock line
    input wire ps2_data,      	// PS/2 data line
	 input wire reset,				// reset
    output reg [7:0] scan_code 	// Received scan code
);

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
			end
		end
    end
endmodule