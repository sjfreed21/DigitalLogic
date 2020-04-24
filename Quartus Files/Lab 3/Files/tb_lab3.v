`timescale 1 ns / 100 ps

module tb();

reg [1:0] KEY;
reg [9:0] SW;
reg clock = 0;
wire [9:0] LEDR;

always 
    #1 clock = ~clock;

lab3 DUT
(
    .KEY(KEY),
    .SW(SW),
    .ADC_CLK_10(clock),
    .LEDR(LEDR)
);

initial
begin
    $dumpfile("out.vcd");
    $dumpvars;
    $display($time, " << Starting Simulation >>");
    $display($time, " << Reset Active >>");
    SW[1:0] = 2'b00;
    KEY[1:0] = 2'b00;
    #5 $display($time, " << Reset Inactive >>");
    KEY[0] = 0;
    #1 KEY[0] = 1;
    #4 $display($time, " << Hazards On >>");
    SW[0] = 1;
    #20 SW[0] = 0;
    $display($time, " << Enable Left Turn Signal >>");
    SW[1] = 1;
    #30 $display($time, " << Switch to Right Turn >>");
    KEY[1] = 0;
    #1 KEY[1] = 1;
    #29 $display($time, " << Assert Hazards >>");
    SW[0] = 1;
    #30 $display($time, " << Simulation Complete >>");
    $finish;
end

initial
begin
    $monitor($time, " Low Reset = %b, L/R Select = %b, Switches = %b,  Left LEDs = %b, Right LEDs = %b", KEY[0], KEY[1], SW[1:0], LEDR[9:7], LEDR[2:0]);
end

endmodule