`timescale 1ns / 1ps

module ShiftReg (CLK, RST, SL, SR, LD, LeftIn, RightIn, D, Q);
parameter Data_width = 4;
input CLK, RST, SL, SR, LD, LeftIn, RightIn;
input [Data_width-1:0] D;
output reg [Data_width-1:0] Q;

always @(posedge CLK)
begin
	if (RST)
		Q = 0;
	else if (LD)
		Q = D;
	else if (SL) // shift left
	begin
		Q [Data_width-1:1] = Q [Data_width-2:0];
		Q [0] = RightIn;
	end
	else if (SR) // shift right
	begin
		Q [Data_width-2:0] = Q [Data_width-1:1];
		Q [Data_width -1] = LeftIn;
	end
	else Q [Data_width-1:0] = Q [Data_width-1:0];
end
endmodule
