module lab3(
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

parameter Idle = 3'b000;
parameter Hazard = 3'b001;
parameter Left1 = 3'b010;
parameter Left2 = 3'b011;
parameter Left3 = 3'b100;
parameter Right1 = 3'b101;
parameter Right2 = 3'b110;
parameter Right3 = 3'b111;

////////////// Divide Clock //////////////

wire slowclk;
slowclk D1 ( .clockin(ADC_CLK_10), .SW(SW[9]), .clockout(slowclk));

////////////// Counter //////////////

wire [1:0] addr;
counter C1( .clock(slowclk), .count(addr));

////////////// Instantiate Memory //////////////

wire [7:0] data;
wire SW1, SW0, K1, K0;
ctlmem S1 ( .address(addr), .clock(ADC_CLK_10), .q(data));

assign SW1 = SW[9] ? data[3] : SW[1];
assign SW0 = SW[9] ? data[2] : SW[0];
assign K1 = SW[9] ? data[1] : KEY[1];
assign K0 = SW[9] ? data[0] : KEY[0];

////////////// Input to Machine //////////////

mach M1 ( .SW({SW[9], 7'b0000000, SW1, SW0}), .KEY({K1, K0}), .ADC_CLK_10(ADC_CLK_10), .HEX5(HEX5), .HEX4(HEX4), .HEX3(HEX3), .HEX2(HEX2), .HEX1(HEX1), .HEX0(HEX0), .LEDR(LEDR));

endmodule

/* Table for Memory:
 * Address | SW[1] | SW[0] | KEY[1] | KEY[0] | Resulting State
 *    0    |   0   |   0   |   1    |   0    | Idle (2)
 *    1    |   0   |   1   |   1    |   1    | Hazards (7)
 *    2    |   1   |   0   |   1    |   1    | Left (11)
 *    3    |   1   |   0   |   0    |   1    | Right (9)
 */