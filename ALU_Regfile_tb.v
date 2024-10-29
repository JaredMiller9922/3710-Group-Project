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
	wire [4:0] PSR;
	
	 
   // Outputs
   wire [15:0] rd1, rd2;

    // Instantiate the alu and register file
	 
	alucontrol alucon (
		.opcode(aluop), 
		.opext(opext), 
		.alucont(alucont)
   );
	 
	alu alu (
		.Rsrc(rd1), .Rdest(rd2),
		.alucont(alucont), 
		.result(data),
		.PSR(PSR)
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
		  // write binary 1010 to register 3
		  wa = 3;
		  regwrite = 1;
		  wd = 16'b0000000000001010;
		  
		  #50
		  // write binary 1010 to register 2
		  wa = 2;
		  regwrite = 1;
		  wd = 16'b0000000000001010;
		  
		  #50
		  // Read register 2 and 3
		  ra1 = 3;
		  ra2 = 2;
		  regwrite = 0;
		  
		  #50
		  // Check values of register 3 and 2
		  $display("Testing Regfile: Test1");
		  if(rd1 != 16'b0000000000001010) begin
				$display("rd1 got: %b, should be: %b", rd1, 16'b0000000000001010);
		  end
		  else if(rd2 != 16'b0000000000001010) begin
				$display("rd2 got: %b, should be: %b", rd2, 16'b0000000000001010);
		  end
		  
		  end
		  
		  
		  #50
		  
		  // Test Regfile
		  begin
		  // Write binary 11111111111 to register 1
		  wa = 1;
		  regwrite = 1;
		  wd = 16'b0000011111111111;
		  
		  #50
		  // Write binary 11111111111 to register 2
		  wa = 2;
		  regwrite = 1;
		  wd = 16'b0000001111111111;
		  
		  #50
		  // Read register 1 and 2
		  ra1 = 1;
		  ra2 = 2;
		  regwrite = 0;
		  
		  #50
		  // Check values of register 1 and 2
		  $display("Testing Regfile: Test2");
		  if(rd1 != 16'b0000011111111111) begin
				$display("rd1 got: %b, should be: %b", rd1, 16'b0000011111111111);
		  end
		  else if(rd2 != 16'b0000001111111111) begin
				$display("rd2 got: %b, should be: %b", rd2, 16'b0000001111111111);
		  end
		  
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
			  regwrite = 0;
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
			  regwrite = 0;
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
		  end
		  
		  
		  #50
		  
		  
		  
		  // Test Flags
		  
		  
		  
		  
		  // Test Carry Flag
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
			  regwrite = 0;
			  ra1 = 1;
			  ra2 = 2;
		  end
		  
		  
		  
		  //Add
		  aluop = 4'b0101;
		  #50
		  // Check Carry Flag
		  $display("Testing Flags: Carry Flag 1");
		  if(PSR[0] != 1) begin
				$display("Carry Flag got: %b, should be: %b", PSR[0], 1);
		  end
		  
		  end
		  #50
		  
		  // Test Not Carry Flag
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
			  regwrite = 0;
			  ra1 = 1;
			  ra2 = 2;
		  end
		  
		  //Add
		  aluop = 4'b0101;
		  #50
		  // Check Carry Flag
		  $display("Testing Flags: Carry Flag 0");
		  if(PSR[0] != 0) begin
				$display("Carry Flag got: %b, should be: %b", PSR[0], 0);
		  end
		  end
		  #50
		  
		  // Test Low Flag
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
			  regwrite = 0;
			  ra1 = 1;
			  ra2 = 2;
		  end
		  
		  
		  
		  //SUB
		  aluop = 4'b1001;
		  #50
		  // Check Low Flag
		  $display("Testing Flags: Low Flag 1");
		  if(PSR[2] != 1) begin
				$display("Low Flag got: %b, should be: %b", PSR[2], 1);
		  end
		  end
		  #50
		  
		  // Test Not Low Flag
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
			  regwrite = 0;
			  ra1 = 1;
			  ra2 = 2;
		  end
		  
		  //CMP
		  aluop = 4'b1011;
		  #50
		  // Check Low Flag
		  $display("Testing Flags: Low Flag 0");
		  if(PSR[2] != 0) begin
				$display("Low Flag got: %b, should be: %b", PSR[2], 0);
		  end
		  end
		  
		  #50
		  
		  // Test Negative Flag
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
			  regwrite = 0;
			  ra1 = 1;
			  ra2 = 2;
		  end
		  
		  
		  
		  //CMP
		  aluop = 4'b1011;
		  #50
		  $display("Testing Flags: Negative Flag 1");
		  if(PSR[4] != 1) begin
				$display("Negative Flag got: %b, should be: %b", PSR[4], 1);
		  end
		  
		  end
		  #50
		  
		  // Test Not Negative Flag
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
			  regwrite = 0;
			  ra1 = 1;
			  ra2 = 2;
		  end
		  
		  //CMP
		  aluop = 4'b1011;
		  #50
		  $display("Testing Flags: Negative Flag 0");
		  if(PSR[4] != 0) begin
				$display("Negative Flag got: %b, should be: %b", PSR[4], 0);
		  end
		  end
		  
		  #50
		  
		  
		  // Test Zero Flag
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
			  regwrite = 0;
			  ra1 = 1;
			  ra2 = 2;
		  end
		  
		  
		  
		  //CMP
		  aluop = 4'b1011;
		  #50
		  $display("Testing Flags: Zero Flag 1");
		  if(PSR[3] != 1) begin
				$display("Zero Flag got: %b, should be: %b", PSR[3], 1);
		  end
		  
		  end
		  #50
		  
		  // Test Not Zero Flag
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
			  regwrite = 0;
			  ra1 = 1;
			  ra2 = 2;
		  end
		  
		  //CMP
		  aluop = 4'b1011;
		  #50
		  $display("Testing Flags: Zero Flag 0");
		  if(PSR[3] != 0) begin
				$display("Zero Flag got: %b, should be: %b", PSR[3], 0);
		  end

		  end
		  
		  #50
		  
		  
		  // Test F Flag ADD
		  begin
		  // Write all 1's to reg 0 and reg 1
		  begin
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b0111111111111111;
			  
			  #20
			  
			  wa = 2;
			  regwrite = 1;
			  wd = 16'b0000000000000100;
			  
			  #50
			  regwrite = 0;
			  ra1 = 1;
			  ra2 = 2;
		  end
		  
		  
		  
		  //Add
		  aluop = 4'b0101;
		  #50
		  $display("Testing Flags: F Flag ADD 1");
		  if(PSR[1] != 1) begin
				$display("F Flag got: %b, should be: %b", PSR[1], 1);
		  end

		  end
		  #50
		  
		  
		  // Test F Flag Sub
		  begin
		  // Write all 1's to reg 0 and reg 1
		  begin
			  wa = 1;
			  regwrite = 1;
			  wd = 16'b1111111111111111;
			  
			  #20
			  
			  wa = 2;
			  regwrite = 1;
			  wd = 16'b0000000000000010;
			  
			  #50
			  regwrite = 0;
			  ra1 = 1;
			  ra2 = 2;
		  end
		  
		  
		  
		  //SUB
		  aluop = 4'b1001;
		  #50
		  $display("Testing Flags: F Flag SUB 1");
		  if(PSR[1] != 1) begin
				$display("F Flag got: %b, should be: %b", PSR[1], 1);
		  end
		  
		  end
		  #50
		  
		  // Test Not F Flag
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
			  regwrite = 0;
			  ra1 = 1;
			  ra2 = 2;
		  end
		  
		  //SUB
		  aluop = 4'b1001;
		  #50
		  $display("Testing Flags: F Flag 0");
		  if(PSR[1] != 0) begin
				$display("F Flag got: %b, should be: %b", PSR[1], 0);
		  end

		  end
		  #50
		  ra1 = 1;
		  
		  

		

        // Stop simulation
    end

    // Monitor signals
    initial begin
        //$monitor("hSync=%b, vSync=%b, bright=%b, hCount=%d, vCount=%d", hSync, vSync, bright, hCount, vCount);
    end
endmodule