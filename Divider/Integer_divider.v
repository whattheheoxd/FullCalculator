`timescale 1ns / 1ps
//Cindy Yee
//Nov 12, 2017

module Integer_divider(CLK, RST, Go, Done, Err, CS,
                    Dividend, Divisor, Quotient, Remainder
    );
    input wire CLK, RST;
    input wire Go;
    output wire [2:0] CS;
    input wire [3:0] Dividend, Divisor;
    output wire [3:0]Quotient, Remainder;
    output wire Done, Err;
    wire R_SR, X_SR, R_SL, X_SL;
    wire R_LD, X_LD, Y_LD;
    wire X_RightIn;
    wire R_lt_Y;    //flag
    wire [2:0]n;
    wire [2:0] cnt_out;    //Counter in/out
    wire cnt_zero;
    wire cnt_LD, cnt_UD, cnt_CE; //Counter ctrl
    wire R_inmux_ctrl, R_outmux_ctrl, X_outmux_ctrl;
    wire DivZero;
       
    divider_DP DPDiv(Dividend, Divisor, Quotient, Remainder,
                CLK, RST, R_SR, X_SR, R_SL, X_SL,
                R_LD, X_LD, Y_LD,   X_RightIn,
                R_lt_Y, cnt_zero,
                n, cnt_LD, cnt_UD, cnt_CE,
                R_inmux_ctrl, R_outmux_ctrl, X_outmux_ctrl, DivZero
                );
    
      divider_CU CU_div(CLK, RST, Go, R_lt_Y, DivZero, cnt_zero, Done, Err, CS,
                R_inmux_ctrl, R_LD, R_SL, R_SR, X_LD, X_SL, X_SR, Y_LD, 
                n, cnt_CE, cnt_LD, cnt_UD, R_outmux_ctrl, X_outmux_ctrl, X_RightIn);
                    
endmodule
