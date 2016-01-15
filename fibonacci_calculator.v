module fibonacci_calculator (input_s, reset_n, begin_fibo, clk, done, fibo_out) ; 
	input  [4:0] input_s ; 
	input  reset_n ; 
	input  begin_fibo ; //Start calculation
	input  clk ; 
	output done ; 
	output [15:0] fibo_out ;
	
	reg done;
	reg [15:0] next_regA;
	reg [15:0] next_regB;
	reg [15:0] next_reg_out;
	
	reg [15:0] cur_regA = 16'd0;
	reg [15:0] cur_regB = 16'd1;
	reg [15:0] cur_num = 16'd0;

	reg Z, CURRENT_STATE, NEXT_STATE;
	
parameter s0=0, s1=1, s2=2, s3=3; //parameters used to declare states

always @ (*)
begin
	case(CURRENT_STATE)
		s0: begin
			 Z = 0;
			 if(begin_fibo == 1)			 
				NEXT_STATE = s1;
			 else
				NEXT_STATE = s0;
				
			 next_reg_out = cur_regA;
			 end
			 
		s1: begin
			 Z = 1;
			 if(begin_fibo == 1)
				NEXT_STATE = s2;
			 else
				 NEXT_STATE = s1;
				next_reg_out = cur_regB;
			 end
			 
		s2: begin
			 Z = 2;
			 if(begin_fibo == 1)
		 		 NEXT_STATE = s3;
			 else
				 NEXT_STATE = s2;
			 next_reg_out = cur_regA + cur_regB;
			 next_regA = cur_regB;
			 next_regB = next_reg_out;
			 end
			
		s3: begin
			 Z = 3;
			 if(begin_fibo == 1)
				 NEXT_STATE = s2;
			 else
				 NEXT_STATE = s3;
			 done = 1'b1;
			 next_reg_out = cur_num;
			 end
	
	endcase
end
	
always @ (posedge clk or negedge reset_n)
begin

if(!reset_n)
	CURRENT_STATE <= s0;

else
	CURRENT_STATE <= NEXT_STATE;

end

assign fibo_out = next_reg_out;

endmodule