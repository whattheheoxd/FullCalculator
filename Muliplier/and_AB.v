`timescale 1ns / 1ps

module and_AB( input [3:0] A, input B, output reg [3:0] and_Ab);
integer i;  
always@(A,B)
begin
    for(i=0; i<4; i=i+1)
        begin
        and_Ab[i]=A[i]&B;
        end
end//end initial
endmodule
