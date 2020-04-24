`timescale 1 ns / 100 ps

module tb();

reg clock;
reg reset_n;

mystery DUT
(
    .clock(clock),
    .reset_n(reset_n)
);

always
    #10 clock = ~clock;

initial
begin
    $dumpfile("output.vcd");
    $dumpvars;
    $display($time, "<< Starting Simulation >>");
    clock = 1'b0;
    reset_n = 1'b0;
    #50 reset_n = 1'b1;
    #450 $display($time, "<< Simulation Complete >>");
    $finish;
end

endmodule