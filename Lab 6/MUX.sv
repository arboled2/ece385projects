//bullshit muxes i don't know, man
module PC_MUX (input logic [15:0] IN0, IN1, IN2,
					input logic [1:0] SelectBit,
					output logic [15:0] OUT);
					
				always_comb
				begin
					case (SelectBit)
						2'b00 :
							OUT = IN0;	//select PC + 1
						2'b01 :
							OUT = IN1;	//select BUS
						2'b10 :
							OUT = IN2;	//select output of address adder
						2'b11 : 
							OUT = 16'h0;
					endcase
				end
endmodule

module DR_MUX (input logic [2:0] IN,
					input logic SelectBit,
					output logic [2:0] OUT);
				
				always_comb
				begin
					case (SelectBit)
						1'b0 :
							OUT = IN;
						1'b1 :
							OUT = 3'b111;
					endcase
				end
endmodule

module SR1_MUX (input logic [2:0] IN0, IN1,
					input logic SelectBit,
					output logic [2:0] OUT);
				
				always_comb
				begin
					case (SelectBit)
						1'b0 :
							OUT = IN0;
						1'b1 :
							OUT = IN1;
					endcase
				end
endmodule

module SR2_MUX (input logic [15:0] IN0, IN1,
					input logic SelectBit,
					output logic [15:0] OUT);
				
				always_comb
				begin
					case (SelectBit)
						1'b0 :
							OUT = IN0;
						1'b1 :
							OUT = IN1;
					endcase
				end
endmodule

module ADDR1_MUX (input logic [15:0] IN0, IN1,
						input logic SelectBit,
						output logic [15:0] OUT);
				always_comb
				begin
					case (SelectBit)
						1'b0 :
							OUT = IN0;
						1'b1 :
							OUT = IN1;
					endcase
				end
endmodule


module ADDR2_MUX (input logic [15:0] IN0, IN1, IN2, IN3,
						input logic [1:0] SelectBit,
						output logic [15:0] OUT);
						
				always_comb
				begin
					case (SelectBit)
						2'b00 :
							OUT = 16'h0;
						2'b01 :
							OUT = IN0;
						2'b10 :
							OUT = IN1;
						2'b11 :
							OUT = IN2;
					endcase
				end

endmodule

module GATE_MUX (input logic [15:0] IN0, IN1, IN2, IN3,
					 input logic [3:0] SelectBit,
					 output logic [15:0] OUT);
					 
				always_comb
				begin
					case (SelectBit)
						4'b1000 :
							OUT = IN0
						4'b0100 :
							OUT = IN1;
						4'b0010 :
							OUT = IN2;
						4'b0001 :
							OUT = IN3;
						default :
							OUT = 16'h0;
					endcase
				end
endmodule

module MDR_MUX (input logic [15:0] IN0, IN1, //input from either mem2io or bus
					 input logic SelectBit,
					 output logic [15:0] OUT);
				
				always_comb
				begin
					case (SelectBit)
						1'b0 :
							OUT = IN0;
						1'b1 :
							OUT = IN1;
					endcase
				end
					
endmodule

