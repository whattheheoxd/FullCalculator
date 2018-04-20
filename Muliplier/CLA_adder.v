`timescale 1ns / 1ps

module CLA_adder(input CarryIn0, input [3:0]A, input [3:0]B, output carry_out, output [3:0] Sum);
reg c_o,c_i;  //carry out and in
reg i;//increment
wire [4:0] carry_in;
wire [3:0] g_cin;
wire [3:0] p_sum;

//always@(CarryIn0,A,B)//synthesis warning"Found timing loop
//begin   //if always, cannot use assign
   assign carry_in[0]=CarryIn0;
//    for(i=0; i<4; i=i+1)
//        begin
//        Sum[i]=(carry_in[i]^ p_sum[i]);
//        end//endfor
//    half_adder HA_1  (.a(A[0]), .b(B[0]), .g(carry_in[1]), .p(p_sum[0]) );
//    end//endalways

    half_adder HA_1  (.a(A[0]), .b(B[0]), .g(g_cin[0]), .p(p_sum[0]) );     //p_i=a_i XOR b_i //g_i=a_i AND b_i
    assign carry_in[1]=g_cin[0]+(carry_in[0]&p_sum[0]);                     //c_i+1=g_i + p_ic_i 
    assign Sum[0]=(carry_in[0]^ p_sum[0]);                                  //s_i= p_i XOR c_i
    
    half_adder HA_2  (.a(A[1]), .b(B[1]), .g(g_cin[1]), .p(p_sum[1]) );
    assign carry_in[2]=g_cin[1]+(carry_in[1]&p_sum[1]); 
    assign Sum[1]=(carry_in[1]^ p_sum[1]);
    
    half_adder HA_3  (.a(A[2]), .b(B[2]), .g(g_cin[2]), .p(p_sum[2]) );
    assign carry_in[3]=g_cin[2]+(carry_in[2]&p_sum[2]); 
    assign Sum[2]=(carry_in[2]^ p_sum[2]);
    
    half_adder HA_4  (.a(A[3]), .b(B[3]), .g(g_cin[3]), .p(p_sum[3]) );
    assign carry_in[4]=g_cin[3]+(carry_in[3]&p_sum[3]); 
    assign Sum[3]=(carry_in[3]^ p_sum[3]);
    
    assign carry_out=carry_in[4];

endmodule

//{carry_out,Sum} = A+CarryIn0; //testing hardware
// c_o=carry_out;
//if(c_o)  Sum = Sum+B;
//else  {carry_out,Sum} = Sum+B;

