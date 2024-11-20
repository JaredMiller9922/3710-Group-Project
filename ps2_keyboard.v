module ps2_keyboard(
    input wire clk,          // System clock
    input wire ps2_clk,      // PS/2 clock line
    input wire ps2_data,     // PS/2 data line
    output reg [7:0] scan_code, // Received scan code
    output reg new_data       // New data flag
);

    reg [10:0] shift_reg;    // 11-bit shift register for PS/2 data
    reg [3:0] bit_count;     // Count bits received
    reg ps2_clk_prev;        // Previous clock state for edge detection
    reg parity;              // Parity check
    
    // Synchronization and edge detection
    always @(posedge clk) begin
        ps2_clk_prev <= ps2_clk;

        // Falling edge detection on PS/2 clock
        if (ps2_clk_prev && !ps2_clk) begin
            if (bit_count == 0) begin
                // Start bit detection
                if (!ps2_data) begin
                    bit_count <= 1;
                end
            end else if (bit_count < 11) begin
                // Shift in data
                shift_reg <= {ps2_data, shift_reg[10:1]};
                bit_count <= bit_count + 1;
            end else begin
                // Complete frame received
                bit_count <= 0;
                // Extract 8-bit data and validate parity
                scan_code <= shift_reg[8:1];
                parity <= ~(^shift_reg[8:1]); // Odd parity
                if (parity == shift_reg[9]) begin
                    new_data <= 1; // Valid data
                end
            end
        end

        // Clear new_data flag on read
        if (new_data) begin
            new_data <= 0;
        end
    end
endmodule
