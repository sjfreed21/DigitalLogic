`timescale 1 ns/ 100 ps

module tb();

reg  [1:0] KEY;
reg  [9:0] SW;
reg [3:0] data;
wire [9:0] LEDR;
reg blank;
reg minus;
wire [7:0] HEX0;
wire [7:0] HEX1;
wire [7:0] HEX2;
wire [7:0] HEX3;
wire [7:0] HEX4;
wire [7:0] HEX5;

block3 DUT
(
    .KEY(KEY),
    .LEDR(LEDR),
    .SW(SW),
    .HEX0(HEX0),
    .HEX1(HEX1),
    .HEX2(HEX2),
    .HEX3(HEX3),
    .HEX4(HEX4),
    .HEX5(HEX5)
);

initial
begin
    $dumpfile("out.vcd");
    $dumpvars;
    $display($time, " << Starting Simulation >>");
    $display($time, " << Unsigned 1 < 8 >>");
    SW[9:0] = 10_0001_1000;
    #10 $display($time, " << Signed 7 > -1 >>");
    #10 SW[9:0] = 11_0111_1111;
    #10 $display($time, " << Simulation Complete >>");
end

initial
begin                              
    $monitor($time, " SW[9:8] = %b, SW[7:4] = %b, SW[3:0] = %b, LED0 = %b, LED1 = %b, LED2 = %b", SW[9:8], SW[7:4], SW[3:0], LEDR[0], LEDR[1], LEDR[2]);
end

endmodule