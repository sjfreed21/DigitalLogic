/* Goal is to build a complex counter to use for testbench work.
   Counter will count up, has an asynch reset, and
	also a load function.
	
	Key0 will be use for asynch reset with highest priority.
	Key 1 will be used to load the value of the SWs into the counter.
	
	Counter will run at 5 MHz.
*/

module CounterSim(
	input 		          		MAX10_CLK1_50,
	input 		     [1:0]		KEY,
	output		     [9:0]		LEDR,
	input 		     [9:0]		SW
);

parameter clock_div = 5;
parameter clock_div_width = 3;

reg [9:0] count;
reg [clock_div_width-1:0] div_counter;
reg clock_2500000hz;
wire slow_clock;

// create 1 Hz clock

always @(negedge KEY[0], posedge MAX10_CLK1_50)
  if (KEY[0] == 0)
    begin
      div_counter <= 0;
		clock_2500000hz <= 0;
	 end
	 
  else if (MAX10_CLK1_50 == 1)
    begin
      if (div_counter == clock_div)
		  begin
		    div_counter <= 0;
		    clock_2500000hz <= ~clock_2500000hz;
		  end
	   else
		  div_counter <= div_counter + 1;
    end
	
	 
// create counter
always @(negedge KEY[0], posedge clock_2500000hz, negedge KEY[1])
  if (KEY[0] == 0)
    count <= 0;
  else if (KEY[1] == 0)
    count[9:0] <= SW[9:0];
  else
    count <= count + 1;
	 
assign LEDR[9:0] = count[9:0];

endmodule


