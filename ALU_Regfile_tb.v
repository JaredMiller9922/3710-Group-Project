module ALU_Regfile_tb;

    // Inputs
   reg clk50MHz;
	reg regwrite = 0;
	reg [1:0] aluop; 
	reg [5:0] funct;
	reg [2:0] alucont;
	reg [15:0] data;
	
	reg [3:0] ra1, ra2, wa;
	reg [15:0] wd;
	
	 
   // Outputs
   wire [15:0] rd1, rd2;

    // Instantiate the Unit Under Test (UUT)
	 /*
	alucontrol alucont (
		.aluop(aluop), 
		.funct(funct), 
		.alucont(alucont)
   );
	 
	alucontrol alu (
		.a(rd1), .b(rd2)
		.alucont(alucont), 
		.result(data)
   );
	*/
	 regfile registers (
		.clk(clk50MHz), 
		.regwrite(regwrite), 
		.ra1(ra1), .ra2(ra2), .wa(wa), 
		.wd(wd), 
		.rd1(rd1), .rd2(rd2)
    );

    // Clock generation
    initial begin
        clk50MHz = 0;
        forever #10 clk50MHz = ~clk50MHz; // 50MHz clock
    end
	 

    // Test sequence
    initial begin
        // Initialize Clear
		  regwrite = 0;

        // global reset
        #100;
		  
		  
		  wa = 3;
		  regwrite = 1;
		  wd = 16'b0000000000001010;
		  
		  #50
		  
		  wa = 2;
		  regwrite = 1;
		  wd = 16'b0000000000001010;
		  
		  #50
		  
		  ra1 = 3;
		  regwrite = 0;
		  
		  #50
		  
		  $display("r[3] = %d", rd1);
		  
		  
		  
		  
		  #50
		  
		  /*
		  aluop = 2'b00;
		  funct = 6'b000101;
		  
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("add: %d", data);
		  
		  #50
		  
		  aluop = 2'b00;
		  funct = 6'b001001;
		  
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("sub: %d", data);
		  
		  #50

		  
		  aluop = 2'b00;
		  funct = 6'b001011;
		  
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("cmp: %d  !!!Check Flags", data);
		  
		  #50
		  
		  
		  aluop = 2'b00;
		  funct = 6'b000001;
		  
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("and: %d", data);
		  
		  #50
		  
		  
		  aluop = 2'b00;
		  funct = 6'b000010;
		  
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("or: %d", data);
		  
		  #50
		  
		  
		  
		  aluop = 2'b00;
		  funct = 6'b000011;
		  
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("xor: %d", data);
		  
		  #50
		  
		  
		  aluop = 2'b00;
		  funct = 6'b001101;
		  
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("mov: %d", data);
		  
		  #50
		  
		  
		  aluop = 2'b00;
		  funct = 6'b000100;
		  
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("LSH: %d", data);
		  
		  #50
		  
		  
		  aluop = 2'b00;
		  funct = 6'b000001;
		  
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("and: %d", data);
		  
		  #50
		  
		  
		  //aluop = 2'b1111
		  aluop = 2'b00;
		  funct = 6'b000000;
		  
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("LUI: %d", data);
		  
		  #50
		  */
		

        // Stop simulation
        $stop;
    end

    // Monitor signals
    initial begin
        //$monitor("hSync=%b, vSync=%b, bright=%b, hCount=%d, vCount=%d", hSync, vSync, bright, hCount, vCount);
    end
endmodule