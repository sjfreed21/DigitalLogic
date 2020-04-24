module mach(
    input [9:0] SW,
    input [1:0] KEY,
    input ADC_CLK_10,
    output [7:0] HEX5,
    output [7:0] HEX4,
    output [7:0] HEX3,
    output [7:0] HEX2,
    output [7:0] HEX1,
    output [7:0] HEX0,
    output [9:0] LEDR
);

/* Left Turn 9-7, Right Turn 2-0
 * KEY[0] Reset
 * KEY[1] L/R Select (0/1)
 * SW[0] Hazards
 * SW[1] Turn Enable
 * SW[9] Eventually Auto Control M9K memory
 */
 
assign LEDR[6] = SW[9];
assign LEDR[5] = ~reset_n;
assign LEDR[4] = ~reset_n;
assign LEDR[3] = SW[9];

////////////// KEY0 Toggle //////////////

wire reset_n;
// toggle T1 ( .key(KEY[0]), .value(reset_n));  // comment out this line for hold
assign reset_n = KEY[0];  // comment out this line for latch

////////////// KEY1 Toggle //////////////

wire lrsel;
// toggle T2 ( .key(KEY[1]), .value(lrsel)); // comment out this line for hold
assign lrsel = ~KEY[1];  // comment out this line for latch 

////////////// Divide Clock //////////////

wire clk5hz;
clkdiv D1 ( .clockin(ADC_CLK_10), .clockout(clk5hz));

////////////// Current State Logic //////////////

wire [2:0] CurrentS, NextS;

csl C1 ( .clock(clk5hz), .reset_n(reset_n), .NextS(NextS), .CurrentS(CurrentS));

////////////// Next State Logic //////////////

nsl N1 ( .en(SW[1]), .haz(SW[0]), .lrsel(lrsel), .CurrentS(CurrentS), .NextS(NextS));

////////////// Output Logic //////////////

wire [5:0] LEDval;

ol O1 ( .CurrentS(CurrentS), .LEDval(LEDval));

assign LEDR[9:7] = LEDval[5:3];
assign LEDR[2:0] = LEDval[2:0];

sevenseg S5 (.blank(1'b1), .HEX(HEX5));
sevenseg S4 (.data({3'b000,SW[9]}), .HEX(HEX4));    // padded to avoid errors
sevenseg S3 (.blank(1'b1), .HEX(HEX3));
sevenseg S2 (.data({3'b000,lrsel}), .HEX(HEX2));    // padded to avoid errors
sevenseg S1 (.blank(1'b1), .HEX(HEX1));
sevenseg S0 (.data({1'b0,CurrentS}), .HEX(HEX0));   // padded to avoid errors

endmodule