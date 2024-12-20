module random_gen #(
    parameter WIDTH = 4 // Width of the random number
)
(
    input clk,           // Clock signal
    input reset,         // Synchronous reset
    input [WIDTH-1:0] min,  // Minimum range
    input [WIDTH-1:0] max,  // Maximum range
    output reg [WIDTH-1:0] random_out // Random output
);

    // LFSR register
    reg [WIDTH-1:0] lfsr;

    // Feedback tap for LFSR (example for 16-bit taps at positions 16, 14, 13, 11)
    wire feedback = lfsr[WIDTH-1] ^ lfsr[13] ^ lfsr[12] ^ lfsr[10];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Initialize LFSR with a non-zero value
            lfsr <= 16'hACE1; 
        end else begin
            // Shift LFSR and apply feedback
            lfsr <= {lfsr[WIDTH-2:0], feedback};
        end
    end

    // Scale LFSR value to the desired range
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            random_out <= 0;
        end else begin
            if (max > min) begin
                random_out <= min + (lfsr % (max - min + 1));
            end else begin
                random_out <= min; // Default to min if invalid range
            end
        end
    end

endmodule
