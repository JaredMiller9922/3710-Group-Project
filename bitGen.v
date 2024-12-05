module bitGen #(parameter WIDTH = 16, POSNUM = 30) (
	 input clk,
    input bright,               // Active when in the display area
    input [9:0] hCount,         // Current horizontal pixel position
    input [9:0] vCount,         // Current vertical pixel position
	 //input [WIDTH-1:0] glyphs [POSNUM-1:0],
	 input [15:0] pos0, pos1, pos2, pos3, pos4, pos5, pos6, pos7, pos8, pos9,
	 input [15:0] pos10, pos11, pos12, pos13, pos14, pos15, pos16, pos17, pos18, pos19,
	 input [15:0] pos20, pos21, pos22, pos23, pos24, pos25, pos26, pos27, pos28, pos29,
    output reg [2:0] rgb        // RGB output
);
	
	reg [WIDTH-1:0] glyphs [POSNUM-1:0];
	reg [WIDTH-1:0] currentGlyph;
	
	
	
	integer ii = 0;
	integer jj = 0;
	
    always @(posedge clk) 
	 begin
	 
		glyphs[0] = pos0;
		glyphs[1] = pos1;
		glyphs[2] = pos2;
		glyphs[3] = pos3;
		glyphs[4] = pos4;
		glyphs[5] = pos5;
		glyphs[6] = pos6;
		glyphs[7] = pos7;
		glyphs[8] = pos8;
		glyphs[9] = pos9;
		glyphs[10] = pos10;
		glyphs[11] = pos11;
		glyphs[12] = pos12;
		glyphs[13] = pos13;
		glyphs[14] = pos14;
		glyphs[15] = pos15;
		glyphs[16] = pos16;
		glyphs[17] = pos17;
		glyphs[18] = pos18;
		glyphs[19] = pos19;
		glyphs[20] = pos20;
		glyphs[21] = pos21;
		glyphs[22] = pos22;
		glyphs[23] = pos23;
		glyphs[24] = pos24;
		glyphs[25] = pos25;
		glyphs[26] = pos26;
		glyphs[27] = pos27;
		glyphs[28] = pos28;
		glyphs[29] = pos29;
		
		currentGlyph = 8'b00000000;
	 
	 
        if (~bright)
            rgb = 8'b00000000;   // Black if not in bright area
        else
				rgb = 8'b00000000;   // Black
				//vCount > (jj*64)+64 && vCount < ((jj+1)*64)+64 && hCount > (ii*64)+128 && hCount < ((ii+1)*64)+128
				if (vCount > 64 && vCount < 128) begin
					if (hCount > 128 && hCount < 192) begin
						currentGlyph = pos0;
					end
					else if (hCount > 192 && hCount < 256) begin
						currentGlyph = pos6;
					end
					else if (hCount > 256 && hCount < 320) begin
						currentGlyph = pos12;
					end
					else if (hCount > 320 && hCount < 384) begin
						currentGlyph = pos18;
					end
					else if (hCount > 384 && hCount < 448) begin
						currentGlyph = pos24;
					end
					
				end
				else if (vCount > 128 && vCount < 192) begin
					if (hCount > 128 && hCount < 192) begin
						currentGlyph = pos1;
					end
					else if (hCount > 192 && hCount < 256) begin
						currentGlyph = pos7;
					end
					else if (hCount > 256 && hCount < 320) begin
						currentGlyph = pos13;
					end
					else if (hCount > 320 && hCount < 384) begin
						currentGlyph = pos19;
					end
					else if (hCount > 384 && hCount < 448) begin
						currentGlyph = pos25;
					end
				end
				else if (vCount > 192 && vCount < 256) begin
					if (hCount > 128 && hCount < 192) begin
						currentGlyph = pos2;
					end
					else if (hCount > 192 && hCount < 256) begin
						currentGlyph = pos8;
					end
					else if (hCount > 256 && hCount < 320) begin
						currentGlyph = pos14;
					end
					else if (hCount > 320 && hCount < 384) begin
						currentGlyph = pos20;
					end
					else if (hCount > 384 && hCount < 448) begin
						currentGlyph = pos26;
					end
				end
				else if (vCount > 256 && vCount < 320) begin
					if (hCount > 128 && hCount < 192) begin
						currentGlyph = pos3;
					end
					else if (hCount > 192 && hCount < 256) begin
						currentGlyph = pos9;
					end
					else if (hCount > 256 && hCount < 320) begin
						currentGlyph = pos15;
					end
					else if (hCount > 320 && hCount < 384) begin
						currentGlyph = pos21;
					end
					else if (hCount > 384 && hCount < 448) begin
						currentGlyph = pos27;
					end
				end
				else if (vCount > 320 && vCount < 384) begin
					if (hCount > 128 && hCount < 192) begin
						currentGlyph = pos4;
					end
					else if (hCount > 192 && hCount < 256) begin
						currentGlyph = pos10;
					end
					else if (hCount > 256 && hCount < 320) begin
						currentGlyph = pos16;
					end
					else if (hCount > 320 && hCount < 384) begin
						currentGlyph = pos22;
					end
					else if (hCount > 384 && hCount < 448) begin
						currentGlyph = pos28;
					end
				end
				else if (vCount > 384 && vCount < 448) begin
					if (hCount > 128 && hCount < 192) begin
						currentGlyph = pos5;
					end
					else if (hCount > 192 && hCount < 256) begin
						currentGlyph = pos11;
					end
					else if (hCount > 256 && hCount < 320) begin
						currentGlyph = pos17;
					end
					else if (hCount > 320 && hCount < 384) begin
						currentGlyph = pos23;
					end
					else if (hCount > 384 && hCount < 448) begin
						currentGlyph = pos29;
					end
				end
		
		
		
				// Glyph 0
				if (currentGlyph[1:0] == 2'b01) begin
					if (vCount[5:3] == 3'b000) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					else if (vCount[5:3] == 3'b001) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					else if (vCount[5:3] == 3'b010) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000111;   // White
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000111;   // White
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					else if (vCount[5:3] == 3'b011) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000111;   // White
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000001;   // Blue
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000001;   // Blue
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000111;   // White
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					else if (vCount[5:3] == 3'b100) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000111;   // White
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000001;   // Blue
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000001;   // Blue
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000001;   // Blue
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000001;   // Blue
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000111;   // White
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					else if (vCount[5:3] == 3'b101) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000111;   // White
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000001;   // Blue
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000001;   // Blue
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000001;   // Blue
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000001;   // Blue
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000111;   // White
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					else if (vCount[5:3] == 3'b110) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000111;   // White
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000001;   // Blue
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000001;   // Blue
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000111;   // White
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					else if (vCount[5:3] == 3'b111) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000100;   // Red
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000100;   // Red
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					
				end
				// Glyph 1
				else if (currentGlyph[1:0] == 2'b10) begin
					if (vCount[5:3] == 3'b000) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000001;   // Blue
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000001;   // Blue
						end
						
					end
					else if (vCount[5:3] == 3'b001) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000001;   // Blue
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000001;   // Blue
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					else if (vCount[5:3] == 3'b010) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000001;   // Blue
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000001;   // Blue
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000001;   // Blue
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000001;   // Blue
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					else if (vCount[5:3] == 3'b011) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000001;   // Blue
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000001;   // Blue
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000001;   // Blue
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000001;   // Blue
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					else if (vCount[5:3] == 3'b100) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000001;   // Blue
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000001;   // Blue
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					else if (vCount[5:3] == 3'b101) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000100;   // Red
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000100;   // Red
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					else if (vCount[5:3] == 3'b110) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					else if (vCount[5:3] == 3'b111) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					
				end
				// Glyph 2
				else if (currentGlyph[1:0] == 2'b11) begin
					if (vCount[5:3] == 3'b000) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000110;   // Yellow
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000110;   // Yellow
						end
						
					end
					else if (vCount[5:3] == 3'b001) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000110;   // Yellow
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000110;   // Yellow
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					else if (vCount[5:3] == 3'b010) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000110;   // Yellow
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000110;   // Yellow
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000110;   // Yellow
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000110;   // Yellow
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					else if (vCount[5:3] == 3'b011) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000110;   // Yellow
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000110;   // Yellow
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					else if (vCount[5:3] == 3'b100) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000110;   // Yellow
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000100;   // Red
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000100;   // Red
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000110;   // Yellow
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					else if (vCount[5:3] == 3'b101) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000110;   // Yellow
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000100;   // Red
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000001;   // Blue
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000001;   // Blue
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000100;   // Red
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000110;   // Yellow
						end
						
					end
					else if (vCount[5:3] == 3'b110) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					else if (vCount[5:3] == 3'b111) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					
				end
				
				
				
				
				
				
				
				// Bullet 0
				if (currentGlyph[2] == 1'b1) begin
					if (vCount[5:3] == 3'b000) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000011;   // Cyan
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000011;   // Cyan
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					else if (vCount[5:3] == 3'b001) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000011;   // Cyan
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000011;   // Cyan
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					
				end
				
				
				
				
				
				// Bullet 1
				if (currentGlyph[3] == 1'b1) begin
					if (vCount[5:3] == 3'b110) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000100;   // Red
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000100;   // Red
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					else if (vCount[5:3] == 3'b111) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000100;   // Red
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000100;   // Red
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					
				end
				
				
				
				
				
				
				
				
				
				
				
				
				// Explosion
				else if ((currentGlyph[1:0] == 2'b10 && currentGlyph[2] == 1'b1) || (currentGlyph[0] == 1'b1 && currentGlyph[3] == 1'b1)) begin
					if (vCount[5:3] == 3'b000) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000110;   // Yellow
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000110;   // Yellow
						end
						
					end
					else if (vCount[5:3] == 3'b001) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000110;   // Yellow
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000110;   // Yellow
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					else if (vCount[5:3] == 3'b010) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000110;   // Yellow
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000110;   // Yellow
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000110;   // Yellow
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000110;   // Yellow
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					else if (vCount[5:3] == 3'b011) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000110;   // Yellow
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000110;   // Yellow
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					else if (vCount[5:3] == 3'b100) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000110;   // Yellow
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000111;   // White
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000111;   // White
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000110;   // Yellow
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					else if (vCount[5:3] == 3'b101) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000110;   // Yellow
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000111;   // White
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000111;   // White
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000110;   // Yellow
						end
						
					end
					else if (vCount[5:3] == 3'b110) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					else if (vCount[5:3] == 3'b111) begin
						
						if (hCount[5:3] == 3'b000) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b001) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b010) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b011) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b100) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b101) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b110) begin
							rgb = 8'b00000000;   // Black
						end
						else if (hCount[5:3] == 3'b111) begin
							rgb = 8'b00000000;   // Black
						end
						
					end
					
				end
				
    end
endmodule
