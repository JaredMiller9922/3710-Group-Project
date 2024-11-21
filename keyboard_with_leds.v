module keyboard_with_leds(
    input wire clk,
    input wire ps2_clk,
    input wire ps2_data,
    output reg [7:0] leds
);

    wire [7:0] scan_code;
    wire new_data;

    // Instantiate the PS/2 keyboard module
    ps2_keyboard keyboard (
        .clk(clk),
        .ps2_clk(ps2_clk),
        .ps2_data(ps2_data),
        .scan_code(scan_code),
        .new_data(new_data)
    );

    // Update LEDs only when new data is available
    always @(posedge clk) begin
        if (new_data) begin
            leds <= scan_code; // Display scan code on LEDs
        end
    end
endmodule
