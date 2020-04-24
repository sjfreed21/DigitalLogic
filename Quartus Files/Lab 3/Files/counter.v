module counter(
    input clock,
    output reg [3:0] count
);

always @(posedge clock)
begin
    if(count != 3)
        count = count + 1;
    else
        count = 0;    
end

endmodule
