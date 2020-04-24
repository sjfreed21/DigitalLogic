module mystery(clock,reset_n, mystery0, mystery1);
 
input clock;
input reset_n;
output mystery0, mystery1;
 
reg [1:0] mystery0_count, pos1_count, neg1_count;
// wire [1:0] r_nxt;
 
always @(posedge clock)
  if (~reset_n)
      mystery0_count = 0;
  else
    if (mystery0_count == 2)
      mystery0_count <= 0;
    else
      mystery0_count <= mystery0_count + 1;

assign mystery0 = (mystery0_count == 1) ? 1'b0 : 1'b1;

//////////////////////////////////////////////////////

always @(posedge clock)
  if (~reset_n)
    pos1_count <= 0;
  else 
    if (pos1_count == 2) 
      pos1_count <= 0;
    else 
      pos1_count <= pos1_count +1;
 
always @(negedge clock)
  if (~reset_n)
    neg1_count <= 0;
  else  
    if (neg1_count == 2) 
      neg1_count <= 0;
    else 
      neg1_count<= neg1_count +1;
 
assign mystery1 = ((pos1_count == 2) | (neg1_count == 2));
endmodule