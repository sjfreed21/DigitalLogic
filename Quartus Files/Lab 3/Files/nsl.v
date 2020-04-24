module nsl(
    input en,
    input haz,
    input lrsel,
    input [2:0] CurrentS,
    output reg [2:0] NextS
);

always @(en, lrsel, haz, CurrentS)
    begin
        casex ({en, haz, lrsel, CurrentS})
            6'b00xxxx: NextS = lab3.Idle;
            6'bx1xxxx: NextS = CurrentS[0] ? lab3.Idle : lab3.Hazard;
				6'b100000: NextS = lab3.Left1;
            6'b100010: NextS = lab3.Left2;
            6'b100011: NextS = lab3.Left3;
            6'b100100: NextS = lab3.Idle;
				6'b101000: NextS = lab3.Right1;
            6'b101101: NextS = lab3.Right2;
            6'b101110: NextS = lab3.Right3;
            6'b101111: NextS = lab3.Idle;
            default: NextS = lab3.Idle;
        endcase
    end

endmodule