module translate(
    input clock,
    input reset_n,
    input [3:0] ones,
    input [3:0] tens,
	 input leap,
    output reg [3:0] month,
    output wire [3:0] day1,
    output wire [3:0] day2
);

reg [6:0] value;
reg [4:0] day;

always @(posedge clock or negedge reset_n)
begin
    if (reset_n == 0)
        value <= 1;
    else
        value <= (10*tens) + ({3'b0,ones});
end

always @(posedge clock)
begin
    if (value < 32)
    begin
        month = 1;
        day = value;
    end
    else if (value < (60 + leap))
    begin
        month = 2;
        day = (value - 31);
    end
    else if (value < (91 + leap))
    begin
        month = 3;
        day = (value - (59 + leap));
    end
    else if (value < (100 + leap))
    begin
        month = 4;
        day = (value - (90 + leap));
    end
    else
    begin
        month = 0;
        day = 0;
        end
end

assign day2 = (day / 10);
assign day1 = (day - (day2*10));

endmodule


