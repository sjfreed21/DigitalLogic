module ol(
    input [2:0] CurrentS,
    output reg [5:0] LEDval
);

always @(CurrentS)
    begin
       case (CurrentS)
           lab3.Idle: LEDval = 6'b000_000;
           lab3.Hazard: LEDval = 6'b111_111;
           lab3.Left1: LEDval = 6'b001_000;
           lab3.Left2: LEDval = 6'b011_000;
           lab3.Left3: LEDval = 6'b111_000;
           lab3.Right1: LEDval = 6'b000_100;
           lab3.Right2: LEDval = 6'b000_110;
           lab3.Right3: LEDval = 6'b000_111;
           default: LEDval = 6'b000_000;
       endcase 
    end
endmodule