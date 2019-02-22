module slc3_week_1 (input logic [15:0] IN,
						input logic	Clk, Reset, Run, Continue,
						output logic [11:0] LED,
						output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7
						);

	logic [19:0] ADDR;
	wire [15:0] Data;
   logic CE, UB, LB, OE, WE;

	//slc CPU directly connected to test memory
	slc3 comp (.*);
	
	//Test memory simualtion idk
	test_memory test_memory0(
	.Clk(Clk), .Reset(~Reset),
	.I_O(Data), .A(ADDR),
	.*
	);
	
endmodule