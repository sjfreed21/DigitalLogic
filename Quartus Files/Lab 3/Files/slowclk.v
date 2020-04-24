module slowclk(
    input clockin,
	 input SW,
    output clockout
);

reg clock = 0;
reg [32:0] count = 0;
wire [32:0] div = 25_000_000;

wire reset = SW ? clockin : 0;

always @(posedge reset)
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