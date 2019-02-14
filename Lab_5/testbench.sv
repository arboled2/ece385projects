module testbench();

	timeunit 10ns;
	timeprecision 1ns;
	
	logic Clk = 0;
	logic Reset, ClearA_LoadB, Run;
	logic[7:0] SW;
	
	logic[7:0] Aval, Bval;
	logic[6:0] AhexU, AhexL, BhexU, BhexL;
	logic X;
	
	always begin : CLOCK_GENERATION
		#1 Clk = ~Clk;
	end
	
	initial begin: CLOCK_INITIALIZATION
		Clk = 0;
	end
	
	multiplier mult(.*);
	
	initial begin: TEST_VECTORS
		Reset = 0;
		ClearA_LoadB = 1;
		Run = 1;
		//SW = 8'h8C;
		//SW = 8'hAA;
		SW = 8'h02;
	
	
		#2 Reset = 1;
			ClearA_LoadB = 0;
	
		#20 ClearA_LoadB = 1;
			SW = 8'h04;
			Run = 0;
		
		#22 Run = 1;
	end

endmodule