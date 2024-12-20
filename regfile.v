// The register file - in this case it's 16 bits wide, and
// only 16 registers deep. It's dual-ported so there 
// are two read ports, but only one write port. 
//
// This will likely get compiled into a block RAM by 
// Quartus, so it can be initialized with a $readmemb function.
// In this case, all the values in the ram.dat file are 0
// to clear the registers to 0 on initialization
module regfile #(parameter WIDTH = 16, REGBITS = 4)
                (input                clk, 
                 input                regwrite, 
                 input  [REGBITS-1:0] ra1, ra2, wa, 
                 input  [WIDTH-1:0]   wd, 
                 output [WIDTH-1:0]   rd1, rd2);

   reg  [WIDTH-1:0] RAM [(2<<REGBITS-1)-1:0];
	
	initial begin
	$display("Loading register file");
	// you'll need to change the path to this file!
	$readmemb("C:/Users/Blake/Documents/CS3710/groupwork/3710-Group-Project/reg.dat", RAM);
	//$readmemb("C:/Users/Jesse/Documents/GitHub/ECE 3710/3710-Group-Project/reg.dat", RAM);
	//$readmemb("C:/Users/jared/Desktop/Fall 2024/3710-Group-Project/reg.dat", RAM);
	$display("done with RF load");
	end

   //   dual-ported register file
   //   read two ports combinationally
   //   write third port on rising edge of clock
   always @(posedge clk)
      if (regwrite) RAM[wa] <= wd;
	
   // register 0 is hardwired to 0
   assign rd1 = RAM[ra1];
   assign rd2 = RAM[ra2];
endmodule