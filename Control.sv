//Two-always example for state machine

module control (input  logic Clk, Reset, ClearA_LoadB, Run,
                output logic Shift_En, Add_Sub9_En, fn_HiLow, clear); //addsub output);

    // Declare signals curr_state, next_state of type enum
    
    enum logic [5:0] {A1, A2, A3, A4, A5, A6, A7, A8,
							 S1, S2, S3, S4, S5, S6, S7, S8,
							 Start, Prep, Load, Done}   curr_state, next_state; 
	 //had to change it a 5-bit to account for 18 total states

	
    always_ff @ (posedge Clk /*or posedge Reset*/)  
    begin
        if (!Reset) //synchronous. if or posedge is in, then asynchronus
            curr_state <= Start; //resetera is the reset state that goes to idle
        else 
            curr_state <= next_state;
    end

    // next state logic
	always_comb
    begin
        
		  next_state  = curr_state;
        unique case (curr_state) 
			Load : next_state = Start;
			
			Start :  
					if(!Run)
					begin
						next_state = Prep;
					end
					else if (!ClearA_LoadB)
					begin
						next_state = Load;
					end
			 Prep :	next_state = A1;
				A1 :	next_state = S1;
				A2 :	next_state = S2;
				A3 :	next_state = S3;
				A4 :	next_state = S4;
				A5 :	next_state = S5;
				A6 :	next_state = S6;
				A7 :	next_state = S7;
				A8 :	next_state = S8;
				
				S1 :	next_state = A2;
				S2 :	next_state = A3;
				S3 :	next_state = A4;
				S4 :	next_state = A5;
				S5 :	next_state = A6;
				S6 :	next_state = A7;
				S7 :	next_state = A8;
				S8 :	next_state = Done;
				
			 Done : if(Run) next_state = Start;
					  else if(!Run)
							next_state = Done; //does not move to idle until Run is unpressed.
							  
        endcase
    /*module control (input  logic Clk, Reset, ClearA_LoadB, Run, fn
                output logic Shift_En, ClrA_LdB, Add_Sub9_En, fn_HiLow, reset);*/
		  // Assign outputs based on ‘state’
        case (curr_state) 
				Start: begin				//our first state, hangs until run or load is pressed
					Shift_En = 1'b0;		//determines if we want to shift
					Add_Sub9_En = 1'b0;	// ||			 if we want to add/subtract
					fn_HiLow = 1'b0;		// ||			 add/subtract
					clear = 1'b0;			//determines when to clear (after start is pressed
				end							//										and during a Load)
				Load : begin				//loads B, clears A
					Shift_En = 1'b0;
					Add_Sub9_En = 1'b0;
					fn_HiLow = 1'b0;
					clear = 1'b1;
				end
				Prep : begin				//clears A after every press of Run
					Shift_En = 1'b0;
					Add_Sub9_En = 1'b0;
					fn_HiLow = 1'b0;
					clear = 1'b1;
				end
				A1, A2, A3, A4, A5, A6, A7: begin		//add states
					Shift_En = 1'b0;
					Add_Sub9_En = 1'b1;
					fn_HiLow = 1'b0;
					clear = 1'b0;
				end
				S1, S2, S3, S4, S5, S6, S7, S8: begin	//shift states
					Shift_En = 1'b1;
					Add_Sub9_En = 1'b0;
					fn_HiLow = 1'b0;
					clear = 1'b0;
				end
				A8: begin										//add state for catching negatives
					Shift_En = 1'b0;
					Add_Sub9_En = 1'b1;
					fn_HiLow = 1'b1;
					clear = 1'b0;
				end
				Done: begin										//hangs until run is let go
					Shift_En = 1'b0;							//ensures that run stops after it executes
					Add_Sub9_En = 1'b0;						
					fn_HiLow = 1'b0;
					clear = 1'b1;
				end
        endcase
    end

endmodule
