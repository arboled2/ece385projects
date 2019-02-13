//Two-always example for state machine

module control (input  logic Clk, Reset, ClearA_LoadB, Run, M,
                output logic Shift_En, ClrA_LdB, Add_Sub9_En, fn_HiLow, Reset); //addsub output);

    // Declare signals curr_state, next_state of type enum
    
    enum logic [4:0] {A1, A2, A3, A4, A5, A6, A7, A8,
							 S1, S2, S3, S4, S5, S6, S7, S8,
							 Start, Idle, resetera, Load, Done}   curr_state, next_state; 
	 //had to change it a 5-bit to account for 18 total states

	
    always_ff @ (posedge Clk /*or posedge Reset*/)  
    begin
        if (Reset) //synchronous. if or posedge is in, then asynchronus
            curr_state <= Start; //start is the reset/start state
        else 
            curr_state <= next_state;
    end

    // next state logic
	always_comb
    begin
        
		  next_state  = curr_state;
        unique case (curr_state) 
				resetera : next_state = Idle;
				Load : next_state = Idle;
				Idle : if (Run)
							next_state = Start;
						 else if(ClearA_LoadB)
							next_state = Load;
				Start :
							next_state = A1;
				A1 :	next_state = S1;
				S1 :	next_state = A2;
				A2 :	next_state = S2;
				
				S2 :	next_state = A3;
				A3 :	next_state = S3;
				S3 :	next_state = A4;
				A4 :	next_state = S4;
				
				S4 :	next_state = A5;
				A5 :	next_state = S5;
				S5 :	next_state = A6;
				A6 :	next_state = S6;
	
				S6 :	next_state = A7;
				A7 :	next_state = S7;
				S7 :	next_state = A8;
				A8 :	next_state = S8;
				
				S8 :	next_state = Done;
			Done : if(~Run) next_state = Idle;
							  
        endcase
    /*module control (input  logic Clk, Reset, ClearA_LoadB, Execute,
                output logic Shift_En, ClrA_LdB, Add_Sub9_En, fn_HiLow);*/
		  // Assign outputs based on ‘state’
        case (curr_state) 
				resetera: begin
					Reset = 1'b1;
				end
				Start: begin
					Shift_En = 1'b0
					ClrA_LdB = ClearA_LoadB;
					
				end
				A1, A2, A3, A4, A5, A6, A7: begin
					ClrA_LdB = 1'b0;
					Shift_En= 1'b0
				end
				S1, S2, S3, S4, S5, S6, S7, S8: begin
					ClrA_LdB = 1'b0;
					Shift_En = 1'b1
				end
				A8: begin
					ClrA_LdB = 1'b0;
					Shift_En= 1'b0
				end
				Idle: begin
					ClrA_LdB = 1'b0;
					Shift_En = 1'b0
				end
        endcase
    end

endmodule
