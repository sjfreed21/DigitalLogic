module csl(
    input clock,
    input reset_n,
    input [2:0] NextS,
    output reg [2:0] CurrentS
);

always @(posedge clock or negedge reset_n)
    if (reset_n == 0)
        CurrentS = lab3.Idle;
    else
        CurrentS = NextS;

endmodule