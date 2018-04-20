`timescale 1ns / 1ps

module sub(A, B, C);
parameter Data_width = 4;
input [Data_width - 1:0] A;
input [Data_width - 1:0] B;
output reg [Data_width - 1:0]C;

always @ (A or B)
begin
    C = A - B;
end
endmodule
