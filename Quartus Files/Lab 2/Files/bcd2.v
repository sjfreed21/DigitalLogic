module bcd2(
    input clock,
    input reset_n,
    output reg [3:0] mod10
);

always @(posedge clock or negedge reset_n)
begin
     if (reset_n == 0)
         mod10 <= 0;
     else if (mod10 != 9)
         mod10 <= mod10 + 1;
     else
         mod10 <= 0;
end

endmodule