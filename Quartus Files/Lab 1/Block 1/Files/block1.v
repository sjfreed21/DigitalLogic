module block1(
    input   [7:0] SW,
	 input	[1:0] KEY,
	 output  [7:0] HEX0,
	 output 	[7:0] HEX1,
    output 	[7:0] HEX2,
    output 	[7:0] HEX3,
    output 	[7:0] HEX4,
    output 	[7:0] HEX5,
    output 	[9:0] LEDR
);

wire [23:0] Bday1 = 24'h122199;
wire [23:0] Bday2 = 24'h040799;
wire [23:0] Bday;

assign LEDR[7:0] = KEY[0] ? SW : ~SW;
assign Bday = KEY[1] ? Bday1 : Bday2;

sevenseg U5 ( .data(Bday[23:20]), .minus(1'b0), .blank(1'b0), .HEX(HEX5));
sevenseg U4 ( .data(Bday[19:16]), .minus(1'b0), .blank(1'b0), .HEX(HEX4));
sevenseg U3 ( .data(Bday[15:12]), .minus(1'b0), .blank(1'b0), .HEX(HEX3));
sevenseg U2 ( .data(Bday[11:8]), .minus(1'b0), .blank(1'b0), .HEX(HEX2));
sevenseg U1 ( .data(Bday[7:4]), .minus(1'b0), .blank(1'b0), .HEX(HEX1));
sevenseg U0 ( .data(Bday[3:0]), .minus(1'b0), .blank(1'b0), .HEX(HEX0));

endmodule

	