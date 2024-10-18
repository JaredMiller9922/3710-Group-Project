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
		  
		  // Test Regfile
		  begin
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
		  end
		  
		  
		  #50
		  
		  
		  // Test AND
		  begin
		  // Write all 1's to reg 0 and reg 1
		  begin
			  wa = 0;
			  regwrite = 1;
			  wd = 16'b1111111111111111;
			  
			  #20
			  
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b1111111111111111;
			  
			  #50
			  ra1 = 0;
			  ra2 = 1;
		  end
		  
		  
		  
		  //AND
		  aluop = 2'b11;
		  funct = 6'b000101;
		  #20
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("AND: %d", data);
		  end
		  
		  
		  #50
		  
		  // Test OR
		  begin
		  // Write all 1's to reg 0 and reg 1
		  begin
			  wa = 0;
			  regwrite = 1;
			  wd = 16'b1111110111011111;
			  
			  #20
			  
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b0101111110111101;
			  
			  #50
			  ra1 = 0;
			  ra2 = 1;
		  end
		  
		  
		  
		  //OR
		  aluop = 2'b11;
		  funct = 6'b000101;
		  #20
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("OR: %d", data);
		  end
		  
		  
		  #50
		  
		  // Test XOR
		  begin
		  // Write all 1's to reg 0 and reg 1
		  begin
			  wa = 0;
			  regwrite = 1;
			  wd = 16'b1111111111111111;
			  
			  #20
			  
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b1111111111111111;
			  
			  #50
			  ra1 = 0;
			  ra2 = 1;
		  end
		  
		  
		  
		  //XOR
		  aluop = 2'b11;
		  funct = 6'b000101;
		  #20
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("XOR: %d", data);
		  end
		  
		  
		  #50
		  
		  // Test Flags
		  
		  
		  // Carry Flag
		  begin
		  // Write all 1's to reg 0 and reg 1
		  begin
			  wa = 0;
			  regwrite = 1;
			  wd = 16'b1111111111111111;
			  
			  #20
			  
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b1111111111111111;
			  
			  #50
			  ra1 = 0;
			  ra2 = 1;
		  end
		  
		  
		  
		  //Add
		  aluop = 2'b00;
		  funct = 6'b000101;
		  #20
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("add: %d", data);
		  
		  // Check Carry Flag
		  //$display("carryFlag: %d", carryflag);
		  end
		  #50
		  
		  // Not Carry Flag
		  begin
		  // Write 1 to reg 0 and reg 1
		  begin
			  wa = 0;
			  regwrite = 1;
			  wd = 16'b0000000000000001;
			  
			  #50
			  
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b0000000000000001;
			  
			  #50
			  ra1 = 0;
			  ra2 = 1;
		  end
		  
		  //Add
		  aluop = 2'b00;
		  funct = 6'b000101;
		  #20
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("add: %d", data);
		  
		  // Check Carry Flag
		  //$display("carryFlag: %d", carryflag);
		  end
		  #50
		  
		  //Low Flag
		  begin
		  // Write all 1's to reg 0 and reg 1
		  begin
			  wa = 0;
			  regwrite = 1;
			  wd = 16'b0000000000000001;
			  
			  #20
			  
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b1111111111111111;
			  
			  #50
			  ra1 = 0;
			  ra2 = 1;
		  end
		  
		  
		  
		  //CMP
		  aluop = 2'b10;
		  funct = 6'b000101;
		  #20
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("cmp: %d", data);
		  
		  // Check Low Flag
		  //$display("Low Flag: %d", lowFlag);
		  end
		  #50
		  
		  // Not Low Flag
		  begin
		  // Write 1 to reg 0 and reg 1
		  begin
			  wa = 0;
			  regwrite = 1;
			  wd = 16'b1111111111111111;
			  
			  #50
			  
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b0000000000000001;
			  
			  #50
			  ra1 = 0;
			  ra2 = 1;
		  end
		  
		  //CMP
		  aluop = 2'b01;
		  funct = 6'b000101;
		  #20
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("CMP: %d", data);
		  
		  // Check Low Flag
		  //$display("lowFlag: %d", lowFlag);
		  end
		  
		  #50
		  
		  //Negative Flag
		  begin
		  // Write all 1's to reg 0 and reg 1
		  begin
			  wa = 0;
			  regwrite = 1;
			  wd = 16'b1111111111111111;
			  
			  #20
			  
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b0000000000000001;
			  
			  #50
			  ra1 = 0;
			  ra2 = 1;
		  end
		  
		  
		  
		  //CMP
		  aluop = 2'b10;
		  funct = 6'b000101;
		  #20
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("cmp: %d", data);
		  
		  // Check Negative Flag
		  //$display("Negative Flag: %d", negativeflag);
		  end
		  #50
		  
		  // Not Negative Flag
		  begin
		  // Write 1 to reg 0 and reg 1
		  begin
			  wa = 0;
			  regwrite = 1;
			  wd = 16'b0000000000000001;
			  
			  #50
			  
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b1111111111111111;
			  
			  #50
			  ra1 = 0;
			  ra2 = 1;
		  end
		  
		  //CMP
		  aluop = 2'b01;
		  funct = 6'b000101;
		  #20
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("CMP: %d", data);
		  
		  // Check Negative Flag
		  //$display("Negative Flag: %d", negativeflag);
		  end
		  
		  #50
		  
		  
		  //Zero Flag
		  begin
		  // Write equal value to reg 0 and reg 1
		  begin
			  wa = 0;
			  regwrite = 1;
			  wd = 16'b0000000000000001;
			  
			  #20
			  
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b0000000000000001;
			  
			  #50
			  ra1 = 0;
			  ra2 = 1;
		  end
		  
		  
		  
		  //CMP
		  aluop = 2'b10;
		  funct = 6'b000101;
		  #20
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("cmp: %d", data);
		  
		  // Check Zero Flag
		  //$display("Zero Flag: %d", zeroflag);
		  end
		  #50
		  
		  // Not Zero Flag
		  begin
		  // Write non equal value to reg 0 and reg 1
		  begin
			  wa = 0;
			  regwrite = 1;
			  wd = 16'b0000000000000001;
			  
			  #50
			  
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b1111111111111111;
			  
			  #50
			  ra1 = 0;
			  ra2 = 1;
		  end
		  
		  //CMP
		  aluop = 2'b01;
		  funct = 6'b000101;
		  #20
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("CMP: %d", data);
		  
		  // Check Zero Flag
		  //$display("Zero Flag: %d", zeroflag);
		  end
		  
		  #50
		  
		  
		  // F Flag
		  begin
		  // Write all 1's to reg 0 and reg 1
		  begin
			  wa = 0;
			  regwrite = 1;
			  wd = 16'b1111111111111111;
			  
			  #20
			  
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b1111111111111111;
			  
			  #50
			  ra1 = 0;
			  ra2 = 1;
		  end
		  
		  
		  
		  //Sub
		  aluop = 2'b10;
		  funct = 6'b000101;
		  #20
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("add: %d", data);
		  
		  // Check F Flag
		  //$display("F Flag: %d", fflag);
		  end
		  #50
		  
		  // Not F Flag
		  begin
		  // Write 1 to reg 0 and reg 1
		  begin
			  wa = 0;
			  regwrite = 1;
			  wd = 16'b0000000000000001;
			  
			  #50
			  
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b0000000000000001;
			  
			  #50
			  ra1 = 0;
			  ra2 = 1;
		  end
		  
		  //SUB
		  aluop = 2'b10;
		  funct = 6'b000101;
		  #20
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("add: %d", data);
		  
		  // Check F Flag
		  //$display("F Flag: %d", fflag);
		  end
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