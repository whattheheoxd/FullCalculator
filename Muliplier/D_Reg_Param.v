`timescale 1ns / 1ps

module D_Reg #(parameter WIDTH = 8) (input clk, reset,input en, input[WIDTH-1:0] d, output reg [WIDTH-1:0] q); 
//   asynchronous, active HIGH reset w. enable input
always@(posedge clk, posedge reset)
    if (reset) q <= 0;
    else if (en)    q <= d;
    else    q <= q; 
endmodule