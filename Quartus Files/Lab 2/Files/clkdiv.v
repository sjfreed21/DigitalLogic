module clkdiv(
    input clockin,
	 input key,
    output clockout
);

reg clock = 0;
reg [24:0] count = 0;
wire [24:0] div = key ? 5_000_000 : 1_000_000; // 5 million and 1 million for 1 Hz and 5 Hz, testbench uses 5 and 1

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