module bcd1(
    input clock,
    input reset_n,
    output reg [3:0] mod10,
	output reg out
);

always @(posedge clock or negedge reset_n)
begin
	if (reset_n == 0)
	   begin
        mod10 <= 1;
		  out <= 0;
		end
   else if (mod10 != 9)
	   begin
        mod10 <= mod10 + 1;
		  out <= 0;
		end
   else
	   begin
        mod10 <= 0;
		  out <= 1;
		end
end


endmodule