module clkdiv(
    input clockin,
    output clockout
);

reg clock = 0;
reg [24:0] count = 0;
wire [24:0] div = 2_500_000;            //changed to 0 for testbench

always @(posedge clockin)
begin
    if (count < div)
        count <= count + 1;
    else if (count == div)
    begin
        clock = ~clock;
        count = 0;
    end
    else
        count = 0;
end

assign clockout = clock;

endmodule