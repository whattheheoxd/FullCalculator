`timescale 1ns / 1ps

module FullCalc(input clk, rst, Go, [3:0]A, [3:0]B, [2:0]Op,
				output [3:0]H_Out, L_Out,
				output Done, div_Err,
				output [3:0]CS, output [2:0]F_Q );
                        
//    wire [2:0]F_Q;
    wire [3:0]X_Q, Y_Q;
    wire [1:0]Y_sel;
    wire [1:0]sm_calc_Op;
    wire div_Done,sm_calc_Done;
    wire F_en, X_en, Y_en;  
    wire div_Go, sm_calc_Go;
    wire [1:0] Sel_H, Sel_L;
    wire OutL_en, OutH_en;
    wire div_Err_en;
    
    D_Reg #3 F( .clk( clk ), .reset( rst ), .en( F_en ), .d ( Op ), .q( F_Q )); 

       full_calc_DP FC_DP(clk, rst,div_Go,sm_calc_Go,X_en, Y_en,A, B, sm_calc_Op, 
                         OutL_en, OutH_en, div_Err_en, Y_sel, Sel_H, Sel_L,
                        div_Done, sm_calc_Done, H_Out, L_Out, div_Err);
                                
    Full_calc_CU fullcal_CU(clk, rst, Go, div_Done,sm_calc_Done, F_Q, //Op, 
                        F_en, X_en, Y_en,  
                        Y_sel,
                        div_Go, sm_calc_Go,
                        sm_calc_Op, Sel_H, Sel_L,
                        OutH_en, OutL_en, div_Err_en, Done,
                        CS);
endmodule
