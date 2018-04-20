`timescale 1ns / 1ps

module NOR(in, out );
parameter Data_width=4;

input [Data_width-1:0] in;
output reg out; 

//initial begin
//assign out=~|in; //out=(in[0] NOR in[1] NOR in[2] NOR ... in[Data_width-1])
always@(in)
begin
out=~|in;
end
endmodule
