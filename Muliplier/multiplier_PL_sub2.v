`timescale 1ns / 1ps



module multiplier_PL_sub2(input [7:0]PP2plus3, input [7:0]PP0plus1,
                    output [7:0]P);
wire ci_P, co_P;

//add all PPs together
CLA_adder P_03(.CarryIn0(1'b0), .A(PP0plus1[3:0]),.B(PP2plus3[3:0]),.carry_out(ci_P), .Sum(P[3:0]));
CLA_adder P_47(.CarryIn0(ci_P), .A(PP0plus1[7:4]),.B(PP2plus3[7:4]),.carry_out(co_P), .Sum(P[7:4]));                    

endmodule
