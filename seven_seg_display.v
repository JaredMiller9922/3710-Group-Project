module seven_seg_display (
    input [6:0] score,       // Input score in decimal (range 0-99)
    output reg [6:0] seg1,   // Seven-segment output for tens digit
    output reg [6:0] seg0    // Seven-segment output for ones digit
);

    // Internal signals for the tens and ones digits
    wire [3:0] tens;
    wire [3:0] ones;

    // Extract tens and ones digits
    assign tens = score / 10; // Integer division for tens place
    assign ones = score % 10; // Modulo for ones place

    // Seven-segment encoding
    always @(*) begin
        // Encoding for the tens digit
        case (tens)
            4'd0: seg1 = ~7'b0111111; // 0
            4'd1: seg1 = ~7'b0000110; // 1
            4'd2: seg1 = ~7'b1011011; // 2
            4'd3: seg1 = ~7'b1001111; // 3
            4'd4: seg1 = ~7'b1100110; // 4
            4'd5: seg1 = ~7'b1101101; // 5
            4'd6: seg1 = ~7'b1111101; // 6
            4'd7: seg1 = ~7'b0000111; // 7
            4'd8: seg1 = ~7'b1111111; // 8
            4'd9: seg1 = ~7'b1100111; // 9
            default: seg1 = ~7'b0000000; // Blank
        endcase

        // Encoding for the ones digit
        case (ones)
            4'd0: seg0 = ~7'b0111111; // 0
            4'd1: seg0 = ~7'b0000110; // 1
            4'd2: seg0 = ~7'b1011011; // 2
            4'd3: seg0 = ~7'b1001111; // 3
            4'd4: seg0 = ~7'b1100110; // 4
            4'd5: seg0 = ~7'b1101101; // 5
            4'd6: seg0 = ~7'b1111101; // 6
            4'd7: seg0 = ~7'b0000111; // 7
            4'd8: seg0 = ~7'b1111111; // 8
            4'd9: seg0 = ~7'b1100111; // 9
            default: seg0 = ~7'b0000000; // Blank
        endcase
    end
endmodule
