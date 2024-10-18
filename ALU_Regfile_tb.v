module ALU_Regfile_tb;

    // Inputs
   reg clk50MHz;
	reg regwrite = 0;
	reg [3:0] aluop; 
	reg [3:0] opext;
	wire [2:0] alucont;
	wire [15:0] data;
	
	reg [3:0] ra1, ra2, wa;
	reg [15:0] wd;
	
	 
   // Outputs
   wire [15:0] rd1, rd2;

    // Instantiate the Unit Under Test (UUT)
	 
	alucontrol alucon (
		.opcode(aluop), 
		.opext(opext), 
		.alucont(alucont)
   );
	 
	alu alu (
		.Rsrc(rd1), .Rdes(rd2),
		.alucont(alucont), 
		.result(data)
   );
	
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
		  opext = 0;

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
		  ra2 = 2;
		  regwrite = 0;
		  
		  #50
		  $display("Testing Regfile: Test1");
		  if(rd1 != 16'b0000000000001010) begin
				$display("rd1 got: %b, should be: %b", rd1, 16'b0000000000001010);
		  end
		  else if(rd2 != 16'b0000000000001010) begin
				$display("rd2 got: %b, should be: %b", rd2, 16'b0000000000001010);
		  end
		  else begin
				$display("Horray!! The Regfile is working correctly!");
		  end
		  
		  end
		  
		  
		  #50
		  
		  // Test Regfile
		  begin
		  wa = 1;
		  regwrite = 1;
		  wd = 16'b0000011111111111;
		  
		  #50
		  
		  wa = 2;
		  regwrite = 1;
		  wd = 16'b0000001111111111;
		  
		  #50
		  
		  ra1 = 1;
		  ra2 = 2;
		  regwrite = 0;
		  
		  #50
		  
		  $display("Testing Regfile: Test2");
		  if(rd1 != 16'b0000011111111111) begin
				$display("rd1 got: %b, should be: %b", rd1, 16'b0000011111111111);
		  end
		  else if(rd2 != 16'b0000001111111111) begin
				$display("rd2 got: %b, should be: %b", rd2, 16'b0000001111111111);
		  end
		  else begin
				$display("Horray!! The Regfile is working correctly!");
		  end
		  
		  //$display("r[2] = %d, r[1] = %d", rd1, rd2);
		  end
		  
		  
		  #50
		  
		  
		  // Test AND
		  begin
		  // Write all 1's to reg 0 and reg 1
		  begin
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b1111111111111111;
			  
			  #50
			  
			  wa = 2;
			  regwrite = 1;
			  wd = 16'b1111111111111111;
			  
			  #50
			  regwrite = 0;
			  ra1 = 1;
			  ra2 = 2;
			  			  
			  
		  end
		  
		  #50
		  
		  
		  //AND
		  aluop = 4'b0001;
		  #20
		  $display("Testing ALU: AND");
		  if(data != 16'b1111111111111111) begin
				$display("ALU got: %b, should be: %b", data, 16'b1111111111111111);
		  end
		  else begin
				$display("Horray!! AND is working correctly!");
		  end
		  //$display("r1 = %d, r2 = %d", rd1, rd2);
		  //$display("AND: %d", data);
		  end
		  
		  
		  #50
		  
		  // Test OR
		  begin
		  // Write all 1's to reg 0 and reg 1
		  begin
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b1111110111011111;
			  
			  #20
			  
			  wa = 2;
			  regwrite = 1;
			  wd = 16'b0101111110111101;
			  
			  #50
			  ra1 = 1;
			  ra2 = 2;
		  end
		  
		  
		  
		  //OR
		  aluop = 4'b0010;
		  #20
		  $display("Testing ALU: OR");
		  if(data != 16'b1111111111111111) begin
				$display("ALU got: %b, should be: %b", data, 16'b1111111111111111);
		  end
		  else begin
				$display("Horray!! OR is working correctly!");
		  end
		  //$display("r1 = %d, r2 = %d", rd1, rd2);
		  //$display("OR: %d", data);
		  end
		  
		  
		  #50
		  
		  // Test XOR
		  begin
		  // Write all 1's to reg 0 and reg 1
		  begin
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b1111111111111111;
			  
			  #20
			  
			  wa = 2;
			  regwrite = 1;
			  wd = 16'b1111111111111111;
			  
			  #50
			  ra1 = 1;
			  ra2 = 2;
		  end
		  
		  
		  
		  //XOR
		  aluop = 4'b0011;
		  #20
		  $display("Testing ALU: XOR");
		  if(data != 16'b0000000000000000) begin
				$display("ALU got: %b, should be: %b", data, 16'b0000000000000000);
		  end
		  else begin
				$display("Horray!! XOR is working correctly!");
		  end
		  //$display("r1 = %d, r2 = %d", rd1, rd2);
		  //$display("XOR: %d", data);
		  end
		  
		  
		  #50
		  
		  // Test Flags
		  
		  
		  // Carry Flag
		  begin
		  // Write all 1's to reg 0 and reg 1
		  begin
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b1111111111111111;
			  
			  #20
			  
			  wa = 2;
			  regwrite = 1;
			  wd = 16'b1111111111111111;
			  
			  #50
			  ra1 = 1;
			  ra2 = 2;
		  end
		  
		  
		  
		  //Add
		  aluop = 4'b0101;
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
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b0000000000000001;
			  
			  #50
			  
			  wa = 2;
			  regwrite = 1;
			  wd = 16'b0000000000000001;
			  
			  #50
			  ra1 = 1;
			  ra2 = 2;
		  end
		  
		  //Add
		  aluop = 4'b0101;
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
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b0000000000000001;
			  
			  #20
			  
			  wa = 2;
			  regwrite = 1;
			  wd = 16'b1111111111111111;
			  
			  #50
			  ra1 = 1;
			  ra2 = 2;
		  end
		  
		  
		  
		  //CMP
		  aluop = 4'b0101;
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
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b1111111111111111;
			  
			  #50
			  
			  wa = 2;
			  regwrite = 1;
			  wd = 16'b0000000000000001;
			  
			  #50
			  ra1 = 1;
			  ra2 = 2;
		  end
		  
		  //CMP
		  aluop = 4'b1001;
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
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b1111111111111111;
			  
			  #20
			  
			  wa = 2;
			  regwrite = 1;
			  wd = 16'b0000000000000001;
			  
			  #50
			  ra1 = 1;
			  ra2 = 2;
		  end
		  
		  
		  
		  //CMP
		  aluop = 4'b1001;
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
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b0000000000000001;
			  
			  #50
			  
			  wa = 2;
			  regwrite = 1;
			  wd = 16'b1111111111111111;
			  
			  #50
			  ra1 = 1;
			  ra2 = 2;
		  end
		  
		  //CMP
		  aluop = 4'b1001;
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
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b0000000000000001;
			  
			  #20
			  
			  wa = 2;
			  regwrite = 1;
			  wd = 16'b0000000000000001;
			  
			  #50
			  ra1 = 1;
			  ra2 = 2;
		  end
		  
		  
		  
		  //CMP
		  aluop = 4'b1001;
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
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b0000000000000001;
			  
			  #50
			  
			  wa = 2;
			  regwrite = 1;
			  wd = 16'b1111111111111111;
			  
			  #50
			  ra1 = 1;
			  ra2 = 2;
		  end
		  
		  //CMP
		  aluop = 4'b1001;
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
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b1111111111111111;
			  
			  #20
			  
			  wa = 2;
			  regwrite = 1;
			  wd = 16'b1111111111111111;
			  
			  #50
			  ra1 = 1;
			  ra2 = 2;
		  end
		  
		  
		  
		  //Sub
		  aluop = 4'b1001;
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
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b0000000000000001;
			  
			  #50
			  
			  wa = 2;
			  regwrite = 1;
			  wd = 16'b0000000000000001;
			  
			  #50
			  ra1 = 1;
			  ra2 = 2;
		  end
		  
		  //SUB
		  aluop = 4'b1001;
		  #20
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("add: %d", data);
		  
		  // Check F Flag
		  //$display("F Flag: %d", fflag);
		  end
		  #50
		  ra1 = 1;
		  
		  
		  /*
		  aluop = 4'b0101;
		  
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("add: %d", data);
		  
		  #50
		  
		  aluop = 4'b1001;
		  
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("sub: %d", data);
		  
		  #50

		  
		  aluop = 4'b1001;
		  
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("cmp: %d  !!!Check Flags", data);
		  
		  #50
		  
		  
		  aluop = 4'b0001;
		  
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("and: %d", data);
		  
		  #50
		  
		  
		  aluop = 4'b0010;
		  
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("or: %d", data);
		  
		  #50
		  
		  
		  
		  aluop = 4'b0011;
		  
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("xor: %d", data);
		  
		  #50
		  
		  
		  aluop = 2'b00;
		  opext = 6'b001101;
		  
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("mov: %d", data);
		  
		  #50
		  
		  
		  aluop = 2'b00;
		  opext = 6'b000100;
		  
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("LSH: %d", data);
		  
		  #50
		  
		  
		  aluop = 2'b00;
		  opext = 6'b000001;
		  
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("and: %d", data);
		  
		  #50
		  
		  
		  //aluop = 2'b1111
		  aluop = 2'b00;
		  opext = 6'b000000;
		  
		  $display("r1 = %d, r2 = %d", rd1, rd2);
		  $display("LUI: %d", data);
		  
		  #50
		  */
		

        // Stop simulation
    end

    // Monitor signals
    initial begin
        //$monitor("hSync=%b, vSync=%b, bright=%b, hCount=%d, vCount=%d", hSync, vSync, bright, hCount, vCount);
    end
endmodule