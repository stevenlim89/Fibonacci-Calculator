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
	
	reg [15:0] cur_regA = 16'd1;
	reg [15:0] cur_regB = 16'd0;
	reg [15:0] cur_num = 16'd0;
	
	reg [15:0] zero_reg = 16'd0;
	reg [15:0] one_reg = 16'd1;

	reg [4:0] counter = 5'b0;
	reg fibo_out, CURRENT_STATE, NEXT_STATE;
	
	parameter IDLE_STATE=0, CASE_ZERO=1, CASE_ONE=2, CALCULATE=3; //parameters used to declare states

always @ (CURRENT_STATE or begin_fibo)
	case(CURRENT_STATE)
		IDLE_STATE: begin
						$display("Printing from IDLE_STATE, CURRENT_STATE is: %d\n", CURRENT_STATE);
						if(begin_fibo == 1)	
							begin
							NEXT_STATE = CASE_ZERO;
							end
						else
							NEXT_STATE = IDLE_STATE;
						end
			 
		CASE_ZERO: 	begin
						$display("Printing from CASE_ZERO, CURRENT_STATE is: %d\n", CURRENT_STATE);
						if(input_s > 0)
							NEXT_STATE = CASE_ONE;
						else
							begin
							NEXT_STATE = IDLE_STATE;
							fibo_out = zero_reg;
							end
						end
			 
		CASE_ONE: 	begin
						$display("Printing from CASE_ONE, CURRENT_STATE is: %d\n", CURRENT_STATE);
						if(input_s > 1)
							NEXT_STATE = CALCULATE;
						else
							begin
							NEXT_STATE = IDLE_STATE;
							fibo_out = one_reg;
							end
						end
			
		CALCULATE: 	begin
						$display("Printing from CALCULATE, CURRENT STATE is: %d\n", CURRENT_STATE);
						counter = counter + 1;
						cur_regA = cur_regA + cur_regB;
						cur_regB = cur_regA - cur_regB;
						 
						 
						if(counter == input_s)
							begin
							NEXT_STATE = IDLE_STATE;
							next_reg_out = cur_regA;
							done = 1'b1;
							end
							
						end
	
	endcase
	
always @ (posedge clk or negedge reset_n)
begin

if(!reset_n)
	CURRENT_STATE <= IDLE_STATE;

else
	CURRENT_STATE <= NEXT_STATE;

end

//assign fibo_out = next_reg_out;

endmodule