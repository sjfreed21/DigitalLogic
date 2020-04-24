module fadder(
    input a,
    input b,
	 input mode,
    input cin,
    output wire sum,
    output wire cout
);

wire or1;
wire xor1;
wire and1;
wire and2;

xor(xor1,mode,b);
or(or1,a,xor1);
xor(sum,a,xor1,cin);
and(and1,a,xor1);
and(and2,cin,or1);
or(cout,and1,and2);

endmodule