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
	output logic[7:0] Aval, Bval,
	output logic[6:0] AhexU,
	output logic[6:0] AhexL,
	output logic[6:0] BhexU,
	output logic[6:0] BhexL
);

	//declare internal registers
	logic Shift, LdClrA, AddSub, fn, EverClear;
	logic[7:0] Sum;
	logic newX;
	
	/*module control (input  logic Clk, Reset, ClearA_LoadB, Run,
                output logic Shift_En, ClrA_LdB, Add_Sub9_En, fn_HiLow, clear); */
	
	
	control fsm(.Clk(Clk),
					.Reset(Reset),
					.ClearA_LoadB(ClearA_LoadB),
					.Run(Run),
					.Shift_En(Shift),
					.Add_Sub9_En(AddSub),
					.fn_HiLow(fn),
					.clear(EverClear)
					);
	
	
	
	always_ff @(posedge Clk) begin
	
		if (!Reset) begin
			// if reset is pressed, clear the adder's input registers
			X <= 1'b0;
			Aval <= 8'b0;
			Bval <= 8'b0;
			
		end
		else if(ClearA_LoadB == 0)
		begin
			X <= 1'b0;
			Aval <= 8'b0;
			Bval <= SW;
			
		end
		else if(EverClear == 1)
		begin
			Aval <= 8'b0;
			X <= 1'b0;
		end
		else if(AddSub == 1 && Bval[0] == 1)
		begin
			X <= newX;
			Aval <= Sum;
		end
		else if(Shift == 1)
		begin
			Bval <= {Aval[0], Bval[7:1]};
			Aval <= {X, Aval[7:1]};
		end
	end
	
	/*module Add_sub9( input[7:0] A, B,
					  input fn,
					  output [8:0] S   );*/
	
	Add_sub9 adder(.A(Aval),
						.B(SW),
						.c_in(fn),
						.fn(fn),
						.S(Sum),
						.S8(newX)
						);
			

	 HexDriver HexAL
    (
		  .In0(Aval[3:0]),
		  .Out0(AhexL)
    );
	 HexDriver HexAU
    (
        .In0(Aval[7:4]),
		  .Out0(AhexU)
    );
	  HexDriver HexBL
    (
        .In0(Bval[3:0]),
		  .Out0(BhexL)
    );
	 HexDriver HexBU
    (
        .In0(Bval[7:4]),
		  .Out0(BhexU)
    );
	
endmodule
