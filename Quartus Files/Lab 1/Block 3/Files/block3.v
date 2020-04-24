module block3(
   input  [9:0] SW,
	input	 [1:0] KEY,
	output	 [7:0] HEX0,
	output	 [7:0] HEX1,
    output	 [7:0] HEX2,
    output	 [7:0] HEX3,
    output	 [7:0] HEX4,
    output	 [7:0] HEX5,
    output reg  [9:0] LEDR
);

wire [3:0] inputx, inputy, dispx, dispy;
wire signed [3:0] inputxs, inputys;
wire negx, negy;

assign inputx = SW[7:4];
assign inputxs = SW[7:4];
assign inputy = SW[3:0];
assign inputys = SW[3:0];

assign dispx[3:0] = SW[7] ? ~SW[7:4] + 1'b1 : SW[7:4];
assign negx = SW[7];
assign dispy[3:0] = SW[3] ? ~SW[3:0] + 1'b1 : SW[3:0];
assign negy = SW[3];

always @(SW[9:8])
begin
  case(SW[8])
  1'b1:
    begin
    LEDR[2] = (inputxs == inputys);
    LEDR[1] = (inputxs > inputys);
    LEDR[0] = (inputxs < inputys);
	 LEDR[9:8] = SW[9:8];
    end
  1'b0:
    begin
    LEDR[2] = (inputx == inputy);
    LEDR[1] = (inputx > inputy);
    LEDR[0] = (inputx < inputy);
	 LEDR[9:8] = SW[9:8];
    end
  endcase

end

sevenseg U5 ( .data(dispx), .minus(negx), .blank(~negx), .HEX(HEX5));
sevenseg U4 ( .data(dispx), .minus(1'b0), .blank(1'b0), .HEX(HEX4));
sevenseg U3 ( .data(1'b0), .minus(1'b0), .blank(1'b1), .HEX(HEX3));
sevenseg U2 ( .data(1'b0), .minus(1'b0), .blank(1'b1), .HEX(HEX2));
sevenseg U1 ( .data(dispy), .minus(negy), .blank(~negy), .HEX(HEX1));
sevenseg U0 ( .data(dispy), .minus(1'b0), .blank(1'b0), .HEX(HEX0));
endmodule
