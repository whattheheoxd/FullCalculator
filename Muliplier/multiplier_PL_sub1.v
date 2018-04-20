`timescale 1ns / 1ps


module multiplier_PL_sub1(input [3:0]A, input [3:0]B,
 output [7:0]PP2plus3, output [7:0]PP0plus1);
wire [7:0] PP0, PP1, PP2, PP3;
wire [3:0] temp0,temp1,temp2,temp3;
wire [3:0] sum0_1, sum2_3; //can't be reg- concurrent assignment
wire co0_1,co2_3;

assign PP0= {4'b0000, temp0};
assign PP1= {3'b000, temp1 , 1'b0};
assign PP2= {2'b00, temp2 , 2'b00};
assign PP3= {1'b0, temp3 , 3'b000};

assign PP0plus1 = {2'b00, co0_1, sum0_1, PP0[0]};

assign PP2plus3 = {co2_3, sum2_3, PP2[2],2'b00};

//like [3:0]A*B[i] 
and_AB AB0(A,B[0], temp0);
and_AB AB1(A,B[1], temp1);
and_AB AB2(A,B[2], temp2);
and_AB AB3(A,B[3], temp3);

//add PP0+PP1 ----still need to concatenate
CLA_adder PP01(.CarryIn0(1'b0), .A(PP0[4:1]),.B(PP1[4:1]),.carry_out(co0_1), .Sum(sum0_1));

//add PP2+PP3 --still need to concatenate
CLA_adder PP23(.CarryIn0(1'b0), .A(PP2[6:3]),.B(PP3[6:3]),.carry_out(co2_3), .Sum(sum2_3));

endmodule