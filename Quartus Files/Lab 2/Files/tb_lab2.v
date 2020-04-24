// DID YOU CHANGE clkdiv.v line 9? IF NOT, THIS WILL TAKE A LONG TIME TO RUN!

`timescale 1 ns / 100 ps

module tb();

reg [1:0] KEY;
reg [9:0] SW;
reg clock = 0;
wire [7:0] HEX0;
wire [7:0] HEX1;
wire [7:0] HEX2;
wire [7:0] HEX4;
wire [7:0] HEX5;


always
    #1 clock = ~clock;

lab2 DUT
(
    .SW(SW),
    .KEY(KEY),
    .ADC_CLK_10(clock),
    .HEX5(HEX5),
    .HEX4(HEX4),
    .HEX2(HEX2),
    .HEX1(HEX1),
    .HEX0(HEX0)
);

initial
begin
    $dumpfile("out.vcd");
    $dumpvars;
    $display($time, " << Starting Simulation >>");
    $display($time, " << Reset Active >>");
    SW[9] = 0;
    KEY[0] = 1;
    KEY[1] = 1;
    #5 $display($time, " << Reset Inactive >>");
    KEY[0] = 0;
    #1 KEY[0] = 1;
    #2400;
    $display($time, " << Reset Active >>");
    KEY[0] = 0;
    #1 KEY[0] = 1;
    #5 $display($time, " << Reset Inactive, Leap Year >>");
    KEY[0] = 0;
    #1 KEY[0] = 1;
    SW[9] = 1;
    #2400;
    $display($time, " << Reset Active >>");
    KEY[0] = 0;
    SW[9] = 0;
    #1 KEY[0] = 1;
    #5 $display($time, " << Reset Inactive, Fast Clock >>");
    KEY[0] = 0;
    KEY[1] = 0;
    #1 KEY[0] = 1;
    KEY[1] = 1;
    #800;
    $display($time, " << Simulation Complete >>");
    $finish;
end

initial
begin
    $monitor($time, " Clock = %b, Reset Key = %b, Value = %b_%b, Month = %b, Day = %b_%b", clock, KEY[0], HEX5, HEX4, HEX2, HEX1, HEX0);
end

endmodule