module lab2(
	 input [9:0] SW,
    input [1:0] KEY,
    input ADC_CLK_10,
    output [7:0] HEX5,
    output [7:0] HEX4,
    output [7:0] HEX3,
    output [7:0] HEX2,
    output [7:0] HEX1,
    output [7:0] HEX0,
    output [9:0] LEDR
);

assign LEDR[9] = SW[9];
assign LEDR[8:2] = 1'b0;

////////////// KEY0 Toggle //////////////

wire toggle;
toggle T1 ( .key(KEY[0]), .value(toggle));
assign LEDR[0] = ~toggle;

////////////// KEY1 Toggle //////////////

wire clktoggle;
toggle T2 ( .key(KEY[1]), .value(clktoggle));

////////////// Divide Clock //////////////

wire clock1;
clkdiv D1 ( .clockin(ADC_CLK_10), .key(~clktoggle), .clockout(clock1));
assign LEDR[1] = clock1;

////////////// Start BCDs & Display Output (1-99) //////////////

wire [3:0] value1;
wire [3:0] value2;
wire over;
reg blank = 1;

always @(posedge over or negedge KEY[0])
begin
	 if (KEY[0] == 0)
		  blank = 1;
	 else if (value2 == 9)
		  blank = 1;
	 else
		  blank = 0;
end

bcd1 B4 ( .clock(clock1), .reset_n(toggle), .mod10(value1), .out(over));
bcd2 B5 ( .clock(over), .reset_n(toggle), .mod10(value2));

sevenseg U5 ( .data(value2), .minus(1'b0), .blank(blank), .HEX(HEX5));
sevenseg U4 ( .data(value1), .minus(1'b0), .blank(1'b0), .HEX(HEX4));

////////////// Translate BCD Output & Display as Month (1-4) and Day (1-31) //////////////

wire [3:0] day1;
wire [3:0] day2;
wire [3:0] month;

translate R1 ( .clock(ADC_CLK_10), .reset_n(toggle), .ones(value1), .tens(value2), .leap(SW[9]), .month(month), .day1(day1), .day2(day2));

sevenseg U3 ( .data(), .minus(1'b0), .blank(1'b1), .HEX(HEX3));
sevenseg U2 ( .data(month), .minus(1'b0), .blank(1'b0), .HEX(HEX2));
sevenseg U1 ( .data(day2), .minus(1'b0), .blank(1'b0), .HEX(HEX1));
sevenseg U0 ( .data(day1), .minus(1'b0), .blank(1'b0), .HEX(HEX0));

endmodule