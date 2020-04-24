module toggle(
    input key,
    output value
);
reg val = 0;

always @(posedge key)
begin
    val = ~val;
end

assign value = val;
endmodule
