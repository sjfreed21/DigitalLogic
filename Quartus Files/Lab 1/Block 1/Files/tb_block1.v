`timescale 1 ns/ 100 ps

module tb();

reg  [1:0] KEY;
reg  [7:0] SW;
wire [9:0] LEDR;
wire [7:0] HEX5;

block1 DUT
(
    .KEY(KEY),
    .LEDR(LEDR),
    .SW(SW),
    .HEX5(HEX5)
);

initial
begin
    $dumpfile("out.vcd");
    $dumpvars;
    $display($time, " << Starting Simulation >>");
    KEY[0] = 1'b1;
    KEY[1] = 1'b1;
    SW[0] = 1'b0;
    #10 $display($time, " << Switch 0 switched >>");
    #10 SW[0] = 1'b1;
    #10 SW[0] = 1'b0;
    #10 $display($time, " << Key 0 pressed >>");
    #10 KEY[0] = 1'b0;
    #10 KEY[0] = 1'b1;
    #10 $display($time, " << Key 1 pressed >>");
    #10 KEY[1] = 1'b0;
    #10 KEY[1] = 1'b1;
    #10 $display($time, " << Simulation Complete >>");
end

initial
begin                              
    $monitor($time, " KEY0 = %b, KEY1 = %b, SW0 = %b, LED0 = %b, HEX5 = %b", KEY[0], KEY[1], SW[0], LEDR[0], HEX5[6:0]);
end

endmodule