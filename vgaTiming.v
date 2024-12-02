module vgaTiming (
    input clk50MHz,         // System clock 50MHz
    input clr,              // Clear signal
    output reg hSync,       // Horizontal sync signal
    output reg vSync,       // Vertical sync signal
    output reg bright,      // Bright signal for valid display area
    output reg [9:0] hCount, // Horizontal counter (X position)
    output reg [9:0] vCount  // Vertical counter (Y position)
);
    // VGA timing constants for 640x480 @ 60Hz with a 25MHz pixel clock
    parameter H_TOTAL = 800;
    parameter H_DISPLAY = 640;
    parameter H_SYNC_PULSE = 96;
    parameter H_FRONT_PORCH = 16;
    parameter H_BACK_PORCH = 48;

    parameter V_TOTAL = 521;
    parameter V_DISPLAY = 480;
    parameter V_SYNC_PULSE = 2;
    parameter V_FRONT_PORCH = 10;
    parameter V_BACK_PORCH = 29;

    reg [4:0] clkDiv;  // Clock divider to get 25MHz enable signal
    reg pixelEnable;   // Generate 25MHz pixel enable signal

    always @(posedge clk50MHz or negedge clr) 
    begin
        if (clr == 0)
            clkDiv = 0;
        else 
        begin
            if (clkDiv == 1) 
            begin
                pixelEnable = 1;
                clkDiv = 0;
            end
            else 
            begin
                clkDiv = clkDiv + 1;
                pixelEnable = 0;
            end
        end
    end

    // Horizontal and vertical counters
    always @(posedge clk50MHz or negedge clr) 
    begin
        if (clr == 0) 
        begin
            hCount <= 0;
            vCount <= 0;
        end 
        else if (pixelEnable) 
        begin
            if (hCount == H_TOTAL - 1) 
            begin
                hCount <= 0;
                if (vCount == V_TOTAL - 1)
                    vCount <= 0;
                else
                    vCount <= vCount + 1;
            end 
            else
                hCount <= hCount + 1;
        end
    end

    // Generate horizontal and vertical sync signals
    always @(posedge clk50MHz or negedge clr) 
    begin
        if (clr == 0) 
        begin
            hSync <= 1;
            vSync <= 1;
        end 
        else if (pixelEnable) 
        begin
            // Horizontal sync
            hSync <= (hCount >= H_DISPLAY + H_FRONT_PORCH && 
                      hCount < H_DISPLAY + H_FRONT_PORCH + H_SYNC_PULSE) ? 0 : 1;
            // Vertical sync
            vSync <= (vCount >= V_DISPLAY + V_FRONT_PORCH && 
                      vCount < V_DISPLAY + V_FRONT_PORCH + V_SYNC_PULSE) ? 0 : 1;
        end
    end

    // Bright signal for active video area
    always @(posedge clk50MHz or negedge clr) 
    begin
        if (clr == 0)
            bright <= 0;
        else if (pixelEnable)
            bright <= (hCount < H_DISPLAY && vCount < V_DISPLAY) ? 1 : 0;
    end
endmodule
