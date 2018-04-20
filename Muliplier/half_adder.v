`timescale 1ns / 1ps

module half_adder(a, b, g, p);
input  a, b;
output reg g,p;//c_out, sum;
always@(a,b)
begin
p = a ^ b;    //p_i     // This part can be coded as
g = a & b;  //g_i     // assign {c_out, sum} = a + b;
end
endmodule
