module ALU (input logic [15:0] A, B,
				input logic [1:0] SelectBit,
				output logic [15:0] OUT);
				
				
		always_comb
		begin
			case(SelectBit)
				2'b00 :
					OUT = A + B;		//add operation
				2'b01 :
					OUT = A & B;		//and operation
				2'b10 :
					OUT = ~A; 			//not operation
				2'b11 :
					OUT = A;				//pass through operation
			endcase
		end

endmodule
