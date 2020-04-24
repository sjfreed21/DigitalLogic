module block2(
   input  [7:0] SW,
	input	 [1:0] KEY,
	output	 [7:0] HEX0,
	output	 [7:0] HEX1,
    output	 [7:0] HEX2,
    output	 [7:0] HEX3,
    output	 [7:0] HEX4,
    output	 [7:0] HEX5,
    output   [9:0] LEDR
);

wire [3:0] inputx;
wire [3:0] inputy;
wire [3:0] dispx;
wire [3:0] dispy;
wire negx;
wire negy;
wire [3:0] sum;
wire [3:0] carry;
wire over;

assign inputx = SW[7:4];
assign inputy = SW[3:0];

assign LEDR[7:0] = 0;
assign dispx[3:0] = SW[7] ? ~SW[7:4] + 1'b1 : SW[7:4];
assign negx = SW[7];
assign dispy[3:0] = SW[3] ? ~SW[3:0] + 1'b1 : SW[3:0];
assign negy = SW[3];

sevenseg U5 ( .data(dispx), .minus(negx), .blank(~negx), .HEX(HEX5));
sevenseg U4 ( .data(dispx), .minus(1'b0), .blank(1'b0), .HEX(HEX4));
sevenseg U3 ( .data(dispy), .minus(negy), .blank(~negy), .HEX(HEX3));
sevenseg U2 ( .data(dispy), .minus(1'b0), .blank(1'b0), .HEX(HEX2));

fadder A1( .a(inputx[0]), .b(inputy[0]), .mode(~KEY[0]), .cin(~KEY[0]), .sum(sum[0]), .cout(carry[0]));
fadder A2( .a(inputx[1]), .b(inputy[1]), .mode(~KEY[0]), .cin(carry[0]), .sum(sum[1]), .cout(carry[1]));
fadder A3( .a(inputx[2]), .b(inputy[2]), .mode(~KEY[0]), .cin(carry[1]), .sum(sum[2]), .cout(carry[2]));
fadder A4( .a(inputx[3]), .b(inputy[3]), .mode(~KEY[0]), .cin(carry[2]), .sum(sum[3]), .cout(carry[3]));

xor(over,carry[2],carry[3]);

reg neg;
reg blank;
reg [3:0] num;

always @(over, sum[3:0])
casex ({over, sum[3]})
	2'b1x: 
	begin
		neg = 1'b0;
		blank = 1'b0;
		num = 4'b1111;
	end
	2'b01: 
	begin
		neg = 1'b1;
		blank = 1'b0;
		num = ~sum[3:0] + 1;
	end
	2'b00:
	begin
		neg = 1'b0;
		blank = 1'b1;
		num = sum[3:0];
	end
endcasex

sevenseg U1 ( .data(4'b0000), .minus(neg), .blank(blank), .HEX(HEX1));
sevenseg U0 ( .data(num), .minus(1'b0), .blank(1'b0), .HEX(HEX0));

endmodule