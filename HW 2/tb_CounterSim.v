`timescale 1 ns / 100 ps

module tb();

reg        MAX10_CLK1_50;
reg  [1:0] KEY;
wire [9:0] LEDR;
reg  [9:0] SW;

CounterSim DUT
(
  .MAX10_CLK1_50(MAX10_CLK1_50),
  .KEY(KEY),
  .LEDR(LEDR),
  .SW(SW)
);

always
  #10 MAX10_CLK1_50 = ~MAX10_CLK1_50;
  
initial
  begin
    $dumpfile("out.vcd");
	$dumpvars;
    $display($time, "<< Starting Simulation >>");
	MAX10_CLK1_50 = 1'b0;
	KEY[0] = 1'b0;
	KEY[1] = 1'b1;
	SW[9:0] = 10'b01_0101_0101;
	#20 $display($time, "<< counter = %d - Turning off reset... >>", LEDR);
	KEY[0] = 1'b1;
	#1000;
	$display($time, "<< counter = %d - Loading counter... >>", LEDR);
	load_count(SW);
	#1000 $display($time, "<< Samuel Freed >>");
	$finish;
  end
  
initial
  begin
    $monitor($time, "clock=%b, reset=%b, load = %b, load_value =%h, counter=%h",
	         MAX10_CLK1_50, KEY[0], KEY[1], SW[9:0], LEDR[9:0]);
  end

task load_count;
  input [9:0] load_value;
  begin
	$display($time, "<< Loading counter with %h >>", load_value);
    @(negedge MAX10_CLK1_50);
	KEY[1] = 1'b0;
    @(negedge MAX10_CLK1_50);
	KEY[1] = 1'b1;
  end
endtask

endmodule