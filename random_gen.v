module random_gen (
    input clk,           // Clock signal
    input reset,         // Active low reset signal
    input [7:0] min,     // Minimum value of range
    input [7:0] max,     // Maximum value of range
    output reg [7:0] random_number // Random number in range [min, max]
);

    reg [7:0] lfsr;      // 8-bit LFSR
    wire feedback;       // Feedback wire
    reg [7:0] scaled_random; // Random value scaled to the range [min, max]

    // Feedback logic for LFSR (x^8 + x^6 + x^5 + x^4 + 1)
    assign feedback = lfsr[7] ^ lfsr[5] ^ lfsr[4] ^ lfsr[3];

    // LFSR logic
    always @(posedge clk or negedge reset) begin
        if (~reset)
            lfsr <= 8'b00000001; // Initialize to a non-zero seed
        else
            lfsr <= {lfsr[6:0], feedback}; // Shift and insert feedback
    end

    // Scale the LFSR output to the range [min, max]
    always @(*) begin
        if (max >= min)
            scaled_random = (lfsr % (max - min + 1)) + min;
        else
            scaled_random = min; // Default to min if range is invalid
    end

    // Update the random number
    always @(posedge clk or negedge reset) begin
        if (~reset)
            random_number <= min; // Reset to min value
        else
            random_number <= scaled_random;
    end

endmodule
