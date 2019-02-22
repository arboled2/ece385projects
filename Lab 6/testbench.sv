
module testbench();

timeunit 10ns;

timeprecision 1ns;


logic Clk, Reset, Run, Continue;
logic CE, UB, LB, OE, WE;
logic LD_MAR;
logic [15:0] IN;
logic [15:0] PC, MAR, MDR, IR;
logic [11:0] LED;
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
logic [19:0] ADDR;
wire [15:0] Data;
logic [15:0] bus;
logic GatePC, GateMDR, GateALU, GateMARMUX;

lab6_toplevel CPU (.*);


always begin: CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
	Clk = 0;
end

always_comb begin: INTERNAL_MONITORING
PC = CPU.my_slc.PC_REG.OUT;
MDR = CPU.my_slc.MDR_REG.OUT;
MAR = CPU.my_slc.MAR_REG.OUT;
IR = CPU.my_slc.IR_REG.OUT;
bus = CPU.my_slc.bus;
LD_MAR = CPU.my_slc.LD_MAR;
GatePC = CPU.my_slc.GatePC;
GateMDR = CPU.my_slc.GateMDR;
GateALU = CPU.my_slc.GateALU;
GateMARMUX = CPU.my_slc.GateMARMUX;

end

initial begin: TEST_VECTORS
Reset = 0;
Run = 1;
Continue = 1;

#2 Reset = 1;		// stop reset
	
#2 Run = 0;				// run
#2 Run = 1;

#6 Continue = 0;
#2 Continue = 1;

#6 Continue = 0;
#2 Continue = 1;

#6 Continue = 0;
#2 Continue = 1;

#6 Continue = 0;
#2 Continue = 1;

#6 Continue = 0;
#2 Continue = 1;

#6 Continue = 0;
#2 Continue = 1;

#6 Continue = 0;
#2 Continue = 1;

#6 Continue = 0;
#2 Continue = 1;


#6 Continue = 0;
#2 Continue = 1;


#6 Continue = 0;
#2 Continue = 1;


#6 Continue = 0;
#2 Continue = 1;


end

endmodule

