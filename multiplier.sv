//yeetum
module multiplier
(
	input logic Clk,					//internal
	input logic Reset, 				//push-button
	input logic ClearA_LoadB, 		//push-button
	input logic Run,					//push-button
	input logic[7:0] SW, 				//slider switches
	
	//outputs
	output logic X,
	output logic[7:0] Aval,
	output logic[7:0] Vval,
	output logic[6:0] AhexU,
	output logic[6:0] AhexL,
	output logic[6:0] BhexU,
	output logic[6:0] AhexL,
);

	//declare internal registers
	logic[7:0] A;
	logic[7:0] B;
	logic[7:0] New_A;
	logic A_Out, B_Out;
	logic[8:0] Sum
	
	
	
	always_ff @(posedge Clk) begin
	
		if (!Reset) begin
			// if reset is pressed, clear the adder's input registers
			A <= 8'h0000;
			B <= 8'h0000;
			Sum <= 
	end




	 HexDriver HexAL
    (
		  .Out0(AhexL)
    );
	 HexDriver HexAU
    (
        In0(A[7:4]),
		  .Out0(AhexU)
    ;
	  HexDriver HexBL
    (
        In0(B[3:0]),
		  .Out0(BhexL)
    );
	 HexDriver HexBU
    (
        In0(B[7:4]),
		  .Out0(BhexU)
    );
	
endmodule