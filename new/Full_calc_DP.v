`timescale 1ns / 1ps


module full_calc_DP(input clk, rst,div_Go,sm_calc_Go,X_en, Y_en, [3:0]A, [3:0]B, [1:0]sm_calc_Op, 
                   input  OutL_en, OutH_en, div_Err_en,
                   input [1:0] Y_Sel, Sel_H, Sel_L,
                    output div_Done, sm_calc_Done,[3:0] H_Out, L_Out, output divby0_Err);
                       
    wire [3:0] Y_D;
     wire [3:0]X_Q, Y_Q;
        wire [3:0] sm_calc_Out, Quotient, Remainder;
    wire [7:0] Product;
    wire div_CS,sm_calc_CS;
    wire [3:0] muxL_out, muxH_out;
    wire div_Err;
    
    
    
    MUX4to1 #4 In_Y(.in1(A), .in2(B), .in3(4'b0001), .in4(4'b0000), .s1(Y_Sel), .m1out(Y_D));
    D_Reg #4 X( .clk( clk ), .reset( rst ), .en( X_en ), .d ( A ), .q( X_Q )); 
    D_Reg #4 Y( .clk( clk ), .reset( rst ), .en( Y_en ), .d ( Y_D ), .q( Y_Q )); 
    multiplier_PL_main Pipeline_Multiplication(.clock( clk ), .rst( rst ), .enable( 1'b1 ), .A( X_Q ), .B( Y_Q ), .P( Product ) );

    small_calculator Calc(.clk(clk), .In1(X_Q), .In2(Y_Q), .Out(sm_calc_Out), .Go(sm_calc_Go), 
                .Op(sm_calc_Op), .CS(sm_calc_CS), .Done(sm_calc_Done) );

    Integer_divider div_DUT(.CLK(clk), .RST(rst), .Go(div_Go), .Done(div_Done), .Err(div_Err), .CS(div_CS),
                        .Dividend(X_Q), .Divisor(Y_Q), .Quotient(Quotient), .Remainder(Remainder) );

    D_Reg #4 divzero( .clk( clk ), .reset( rst ), .en( div_Err_en ), .d ( div_Err ), .q( divby0_Err )); 
    
    MUX4to1 #4 Mux_L(.in1(sm_calc_Out), .in2(Product[3:0]), .in3(Quotient), .in4(4'b0000), .s1(Sel_L), .m1out(muxL_out));
    MUX4to1 #4 Mux_H(.in1(Product[7:4]), .in2(Remainder), .in3(4'b0000), .in4(4'b0000), .s1(Sel_H), .m1out(muxH_out));
    D_Reg #4 Out_L( .clk( clk ), .reset( rst ), .en( OutL_en ), .d ( muxL_out ), .q( L_Out )); 
    D_Reg #4 Out_H( .clk( clk ), .reset( rst ), .en( OutH_en ), .d ( muxH_out ), .q( H_Out )); 

endmodule
