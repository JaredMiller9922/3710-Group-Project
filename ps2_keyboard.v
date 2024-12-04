module ps2_keyboard(
    input wire clk,                  // System clock
    input wire ps2_clk,           // PS/2 clock line
    input wire ps2_data,          // PS/2 data line
    input wire reset,                // Reset
    output reg [15:0] keyboard_input
);

    reg [7:0] scan_code;
    reg [10:0] shift_reg;        // 11-bit shift register for PS/2 data
    reg [3:0] bit_count;         // Count bits received
    reg is_break;                // Flag to indicate break code received

    always @(negedge ps2_clk or negedge reset) begin
        if (!reset) begin
            bit_count <= 0;
            shift_reg <= 0;
            is_break <= 0;
            keyboard_input <= 0;
        end else begin
            if (bit_count < 10) begin
                // Shift in data (11 bits total: start + 8 data + parity + stop)
                shift_reg[bit_count] <= ps2_data;
                bit_count <= bit_count + 1;
            end else begin
				// Complete frame received
                bit_count <= 0; // Reset bit count
                scan_code <= shift_reg[8:1]; // Extract scan code
                if (scan_code == 8'hF0) begin
                    // Break code detected
                    is_break <= 1;
                          keyboard_input <= 0;
                end else begin
                    if (!is_break) begin
                        case (scan_code)
                            8'h1C: keyboard_input <= 1; // A - LEFT
                            8'h23: keyboard_input <= 2; // D - RIGHT
                            8'h1D: keyboard_input <= 3; // W - UP
                            8'h1B: keyboard_input <= 4; // S - DOWN
                            8'h29: keyboard_input <= 5; // SPACE - SHOOT
                            default: keyboard_input <= 0; // Ignore other keys
                        endcase
                    end else begin
                        // Reset break flag after processing break code
                        is_break <= 0;
                        keyboard_input <= 0; // Reset output on key release
                    end
                end
            end
        end
    end
endmodule