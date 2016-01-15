/************************************************************************
* ECE 111
* Project: 1
* File: tb_fibonacci_calculator.v
* Author: Shalindra J. Fernando
* Input: ----------------> 1,  2,  3,  4,  5,  6,  7, etc...
* Expected Fib. Sequence:  1,  1,  2,  3,  5,  8, 13, etc...
* Description: 3 simple test cases that are run on inputs of 5, 9, & 12.
************************************************************************/

// Verilog tb for fibonacci_calculator
module tb_fibonacci_calculator;    
    
reg [4:0] input_s;
reg reset_n;
reg begin_fibo;
reg clk;
   
wire done;
wire [15:0] fibo_out;
   
integer i;
integer k; 

fibonacci_calculator uut 
(
	.input_s(input_s),                       
	.reset_n(reset_n),              
	.begin_fibo(begin_fibo),
	.clk(clk),        
	.done(done),
	.fibo_out(fibo_out)
);
   
// Clock Generator
always
begin
	#10; 
	clk = 1'b1; 
	#10
	clk = 1'b0; 
end

initial  
begin
	/* ------------- Input of 5 ------------- */
        // Reset         
	@(posedge clk) reset_n = 0; 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);
	reset_n = 1;
	begin_fibo = 1'b0; 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);
	
	// Inputs into module/ Assert begin_fibo
	input_s = 5; 
	begin_fibo = 1'b1; 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);
	begin_fibo = 1'b0; 
	
	// Wait until calculation is done	
	wait (done == 1); 

	// Idle cycles before next input 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);

	// Display 
	$display("\n---------------------\n"); 
	$display("Project 1 w/ Input: 5\n"); 

	if (fibo_out == 5)
	    $display("CORRECT RESULT: %d, GOOD JOB!\n", fibo_out);
	else
	    $display("INCORRECT RESULT: %d, SHOULD BE: 5\n", fibo_out);

	$display("---------------------\n");


	/* ------------- Input of 9 ------------- */
        // Reset         
	@(posedge clk) reset_n = 0; 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);
	reset_n = 1;
	begin_fibo = 1'b0; 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);
	
	// Inputs into module/ Assert begin_fibo
	input_s = 9; 
	begin_fibo = 1'b1; 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);
	begin_fibo = 1'b0; 
	
	// Wait until calculation is done	
	wait (done == 1); 

	// Idle cycles before next input 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);

	// Display 
	$display("\n---------------------\n"); 
	$display("Project 1 w/ Input: 9\n"); 

	if (fibo_out == 34)
	    $display("CORRECT RESULT: %d, GOOD JOB!\n", fibo_out);
	else
	    $display("INCORRECT RESULT: %d, SHOULD BE: 34\n", fibo_out);

	$display("---------------------\n");


 
	/* ------------- Input of 12 ------------- */
        // Reset         
	@(posedge clk) reset_n = 0; 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);
	reset_n = 1;
	begin_fibo = 1'b0; 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);
	
	// Inputs into module/ Assert begin_fibo
	input_s = 12; 
	begin_fibo = 1'b1; 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);
	begin_fibo = 1'b0; 
	
	// Wait until calculation is done	
	wait (done == 1); 

	// Idle cycles before next input 
	for (k = 0; k < 2; k = k + 1) @(posedge clk);

	// Display 
	$display("\n---------------------\n"); 
	$display("Project 1 w/ Input: 12\n"); 

	if (fibo_out == 144)
	    $display("CORRECT RESULT: %d, GOOD JOB!\n", fibo_out);
	else
	    $display("INCORRECT RESULT: %d, SHOULD BE: 144\n", fibo_out);

	$display("---------------------\n");

	$stop;
end 
endmodule


