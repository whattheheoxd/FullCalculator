module divider_DP(Dividend, Divisor, Quotient, Remainder,
  CLK, RST, R_SR, X_SR, R_SL, X_SL,
 R_LD, X_LD, Y_LD,   X_RightIn,
 R_lt_Y, CNT_Zero,
 n, cnt_LD, cnt_UD, cnt_CE,
 R_inmux_ctrl, R_outmux_ctrl, X_outmux_ctrl, DivZero
);
input [3:0] Dividend, Divisor;
output wire [3:0]Quotient, Remainder;
input CLK, RST;
input wire R_SR, X_SR,R_SL, X_SL;
input wire R_LD, X_LD, Y_LD;
input  X_RightIn;
output wire R_lt_Y;    //flag
input wire [2:0]n;
input wire cnt_LD, cnt_UD, cnt_CE; //Counter ctrl
input wire R_inmux_ctrl, R_outmux_ctrl, X_outmux_ctrl;
output DivZero, CNT_Zero;
 wire [2:0] cnt_out;    
wire [4:0] R_D;
wire [3:0] X_D,Y_D;
wire [4:0] R_Q;
wire [3:0] X_Q, Y_Q;
wire [3:0]R_minus_Y;
wire X_Right_In;


NOR #4 Divisor0(.in(Divisor),.out(DivZero));
MUX2to1 #5 R_inmux(.in1({1'b0,R_minus_Y}), .in2(5'd0), .s2(R_inmux_ctrl), .m2out(R_D));
ShiftReg #5 R( .CLK(CLK), .RST(RST), .SR(R_SR), .SL(R_SL), .LD(R_LD),
    .LeftIn(1'b0), .RightIn(X_Q[3]), .D(R_D), .Q(R_Q));
ShiftReg #4 X ( .CLK(CLK), .RST(RST), .SR(X_SR), .SL(X_SL), .LD(X_LD),
    .LeftIn(0), .RightIn(X_Right_In), .D(Dividend), .Q(X_Q));
MUX2to1 #1 X_Rin(.in1(1'b1), .in2(1'b0), .s2(X_RightIn), .m2out(X_Right_In));
ShiftReg #4 Y ( .CLK(CLK), .RST(RST), .SR(0), .SL(0), .LD(Y_LD),
    .LeftIn(0), .RightIn(0), .D(Divisor), .Q(Y_Q));
comparator #4 comp(.A(R_Q[3:0]), .B(Y_Q), .lt(R_lt_Y));
sub #4 R_sub_Y(.A(R_Q[3:0]), .B(Y_Q), .C(R_minus_Y));
UD_counter #3 UD_cnt ( .D(n), .LD(cnt_LD), .UD(cnt_UD),
            .CE(cnt_CE), .CLK(CLK), .RST(RST), .Q(cnt_out));
NOR #3 CNT0(.in(cnt_out),.out(CNT_Zero));
MUX2to1 #4 R_outmux(.in1(R_Q[3:0]), .in2(4'd0), .s2(R_outmux_ctrl), .m2out(Remainder));
MUX2to1 #4 X_outmux(.in1(X_Q), .in2(4'd0), .s2(X_outmux_ctrl), .m2out(Quotient));
endmodule