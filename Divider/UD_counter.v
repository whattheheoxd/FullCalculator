`timescale 1ns / 1ps

module UD_counter (D, LD, UD, CE, CLK, RST, Q);

parameter Data_width = 4; // data size
parameter UP = 1, DOWN = 0;
input LD, UD, CE, CLK, RST;
input [Data_width-1:0] D;
output reg [Data_width-1:0] Q;

always @(posedge CLK)
begin
if (RST)
    Q = 0;
else if (CE)
begin
    if (LD)
        Q = D;
    else
    begin
        case(UD)
        DOWN: Q = Q - 1;
        UP: Q = Q + 1;
        endcase
    end
end
else
    Q = Q;
end

endmodule