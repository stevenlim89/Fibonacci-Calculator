module fibonacci_calculator (input_s, reset_n, begin_fibo, clk, done, fibo_out) ; 
	input  [4:0] input_s ; 
	input  reset_n ; 
	input  begin_fibo ; //Start calculation
	input  clk ; 
	output done ; 
	output [15:0] fibo_out;
	
	reg done;
	
	reg [15:0] cur_regA = 16'd1;
	reg [15:0] cur_regB = 16'd0;
	reg [15:0] cur_sum = 16'd0;
	
	reg [15:0] zero_reg = 16'd0;
	reg [15:0] one_reg = 16'd1;

	reg [4:0] counter = 5'd1;
	reg [15:0] fibo_out;
	reg [1:0] CURRENT_STATE;
	reg [1:0] NEXT_STATE;
	reg [1:0] STATE;
	
	parameter IDLE_STATE=2'b00, CASE_ZERO=2'b01, CASE_ONE=2'b10, CALCULATE=2'b11; //parameters used to declare states

always @ (posedge clk or negedge reset_n) //(CURRENT_STATE)
	if (! reset_n)
		begin
		fibo_out <= 0;
		cur_regA <= 1;
		cur_regB <= 0;
		counter <= 1;
		done = 1'b0;
		STATE <= IDLE_STATE;
		end
	else
		begin

	case (STATE) //(CURRENT_STATE)
		IDLE_STATE: begin
						//$display("Printing from IDLE_STATE, CURRENT_STATE is: %b\n", CURRENT_STATE);
						if(begin_fibo == 1)	
							begin
							//NEXT_STATE = CASE_ZERO;
							STATE <= CASE_ZERO;
							done <= 1'b0;
							end
						else
							//fibo_out <= zero_reg;
							//NEXT_STATE = IDLE_STATE;
							STATE <= CASE_ZERO;
						end
			 
		CASE_ZERO: 	begin
						//$display("Printing from CASE_ZERO, CURRENT_STATE is: %b\n", CURRENT_STATE);
						//$display("CASE_ZERO, input_s: %d\n", input_s);
						if(input_s > 0)
							begin
							//fibo_out <= zero_reg;
							//NEXT_STATE = CASE_ONE;
							STATE <= CASE_ONE;
							end
						else
							begin
							//fibo_out <= zero_reg;
							//NEXT_STATE = IDLE_STATE;
							STATE <= IDLE_STATE;
							//$display("CASE_ZERO else, CURRENT_STATE is: %b\n", CURRENT_STATE);
							end
						end
			 
		CASE_ONE: 	begin
						//$display("Printing from CASE_ONE, CURRENT_STATE is: %b\n", CURRENT_STATE);
						if(input_s > 1)
							//NEXT_STATE = CALCULATE;
							STATE <= CALCULATE;
						else
							begin
							//fibo_out <= one_reg;
							//NEXT_STATE = IDLE_STATE;
							STATE = IDLE_STATE;
							end
						end
			
		CALCULATE: 	begin
						//$display("Printing from CALCULATE, CURRENT STATE is: %b\n", CURRENT_STATE);
						cur_regA <= cur_regA + cur_regB;
						cur_regB <= cur_regA;
						fibo_out <= cur_regA;
						counter <= counter + 1;
						 
						if(counter == input_s)
							begin
							//fibo_out <= cur_regA;
							done <= 1'b1;
							//NEXT_STATE = IDLE_STATE;
							STATE <= IDLE_STATE;
							end
					
						end
		//default: NEXT_STATE = IDLE_STATE;
	
	endcase
	end


endmodule