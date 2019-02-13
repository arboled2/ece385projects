module Add_sub9( input[7:0] A, B,
					  input c_in,
					  input fn,
					  output [7:0] S,
					  output logic S8
					  );


	logic	c0, c1, c2, c3, c4, c5, c6, c7, c8; 
	logic A8, BB8;			//internal sign extension bits
	logic [7:0] Byeet;	//Holder to XOR with B to determine complement
	
	always_comb
	begin
	 A8 = A[7];
	 Byeet[0] = B[0]^fn;
	 Byeet[1] = B[1]^fn;
	 Byeet[2] = B[2]^fn;
	 Byeet[3] = B[3]^fn;
	 Byeet[4] = B[4]^fn;
	 Byeet[5] = B[5]^fn;
	 Byeet[6] = B[6]^fn;
	 Byeet[7] = B[7]^fn;
	 BB8 = B[7]^fn;				//sign extension bits, copied from sign-bits
	end
	
	full_adder FA0(.x(A[0]), .y(Byeet[0]), .cin(c_in), .s(S[0]), .cout(c0));
	full_adder FA1(.x(A[1]), .y(Byeet[1]), .cin(c0), .s(S[1]), .cout(c1));
	full_adder FA2(.x(A[2]), .y(Byeet[2]), .cin(c1), .s(S[2]), .cout(c2));
	full_adder FA3(.x(A[3]), .y(Byeet[3]), .cin(c2), .s(S[3]), .cout(c3));
	
	full_adder FA4(.x(A[4]), .y(Byeet[4]), .cin(c3), .s(S[4]), .cout(c4));
	full_adder FA5(.x(A[5]), .y(Byeet[5]), .cin(c4), .s(S[5]), .cout(c5));
	full_adder FA6(.x(A[6]), .y(Byeet[6]), .cin(c5), .s(S[6]), .cout(c6));
	full_adder FA7(.x(A[7]), .y(Byeet[7]), .cin(c6), .s(S[7]), .cout(c7));

full_adder FA8(.x(A8), .y(BB8), .cin(c7), .s(S8), .cout(c8));

endmodule

module full_adder(
						input x,
						input y,
						input cin,
						output logic s,
						output logic cout
						);
						
   assign s 	= x ^ y ^ cin;
	assign cout = (x&y) | (y&cin) | (cin&x);
						
endmodule
