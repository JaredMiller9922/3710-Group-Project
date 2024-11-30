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
		
	 
	 
	 
        if (~bright)
            rgb = 8'b00000000;   // Black if not in bright area
        else
				rgb = 8'b00000000;   // Black
				for (jj=0; jj<6; jj = jj + 1) begin
					for (ii=0; ii<5; ii = ii + 1) begin
						
						if (vCount > (jj*64)+64 && vCount < ((jj+1)*64)+64 && hCount > (ii*64)+128 && hCount < ((ii+1)*64)+128) begin
							// Decide Color based on value
							//Glyph 0
							
							if (jj == 0) begin
								rgb = glyphs[jj+(ii)*6][4:0];   // Teal
							end
							else if (jj == 1) begin
								rgb = glyphs[jj+(ii)*6][4:0];   // Yellow
							end
							else if (jj == 2) begin
								rgb = glyphs[jj+(ii)*6][4:0];   // Teal
							end
							else if (jj == 3) begin
								rgb = glyphs[jj+(ii)*6][4:0];   // Yellow
							end
							else if (jj == 4) begin
								rgb = glyphs[jj+(ii)*6][4:0];   // Teal
							end
							else if (jj == 5) begin
								rgb = glyphs[jj+(ii)*6][4:0];   // Yellow
							end
							else if (jj == 6) begin
								rgb = 8'b00000011;   // Teal
							end
							else if (glyphs[jj+(ii)*6][4:0] == 5'b00001) begin
								if (vCount[5:3] == 3'b000) begin
									
									if (jj == 0) begin
										rgb = 8'b00000111;   // White
										if (ii == 0) begin
										rgb = 8'b00000101;   // Purple
									end
									end
									else if (hCount[5:3] == 3'b000) begin
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
								else if (vCount[5:3] == 3'b001) begin
									
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
								else if (vCount[5:3] == 3'b010) begin
									
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
								else if (vCount[5:3] == 3'b011) begin
									
									if (hCount[5:3] == 3'b000) begin
										rgb = 8'b00000111;   // White
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
										rgb = 8'b00000111;   // White
									end
									
								end
								else if (vCount[5:3] == 3'b100) begin
									
									if (hCount[5:3] == 3'b000) begin
										rgb = 8'b00000111;   // White
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
										rgb = 8'b00000111;   // White
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
								else if (vCount[5:3] == 3'b110) begin
									
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
							else if (glyphs[jj+(ii)*6][4:0] == 5'b00010) begin
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
								
							end
						end
					end
				end
    end
endmodule
