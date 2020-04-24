`timescale 1 ns/ 100 ps

module tb();

reg  [1:0] KEY;
reg  [7:0] SW;
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

block2 DUT
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
    $display($time, " << 6 + 1 = 7 >>");
    SW[7:0] = 8'b0110_0001;
    #10 $display($time, " << 6 + 2 = OF >>");
    SW[7:0] = 8'b0110_0010;
    #10 $display($time, " << 6 + (-8) = -2 >>" );
    SW[7:0] = 8'b0110_1000;
    #10 $display($time, " << 6 - 1 = 5 >>" );
    SW[7:0] = 8'b0110_0001;
    KEY[0] = 1'b0;
    #10 $display($time, " << Simulation Complete >>");
end

initial
begin                              
    $monitor($time, " SW[7:4] = %b, KEY[0] = %b, HEX5 = %b, HEX4 = %b, SW[3:0] = %b, HEX3 = %b, HEX2 = %b, HEX1 = %b, HEX0 = %b", SW[7:4], KEY[0], HEX5[7:0], HEX4[7:0], SW[3:0], HEX3[7:0], HEX2[7:0], HEX1[7:0], HEX0[7:0]);
end

endmodule