module random_gen (
    input clk,           // Clock signal
    input reset,         // Active low reset signal
    input [3:0] min,     // Minimum value of range
    input [3:0] max,     // Maximum value of range
    output reg [3:0] random_number // Random number in range [min, max]
);

    reg [3:0] lfsr;      // 4-bit LFSR
    wire feedback;       // Feedback wire
    reg [3:0] scaled_random; // Random value scaled to the range [min, max]

    // Feedback logic for LFSR (x^4 + x^3 + 1)
    assign feedback = lfsr[3] ^ lfsr[2];

    // LFSR logic
    always @(posedge clk or negedge reset) begin
        if (~reset)
            lfsr <= 4'b0001; // Initialize to a non-zero seed
        else
            lfsr <= {lfsr[2:0], feedback}; // Shift and insert feedback
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

