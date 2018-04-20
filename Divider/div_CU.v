`timescale 1ns / 1ps

module divider_CU(input CLK, rst, Go, R_lt_Y, DivZero, cnt_zero, output reg Done, Err, reg [2:0]CS,
output reg R_inmux_ctrl, R_LD, R_SL, R_SR, X_LD, X_SL, X_SR, Y_LD,output reg [2:0] n, output reg cnt_CE, cnt_LD, cnt_UD, R_outmux_ctrl, X_outmux_ctrl, X_RightIn);
    reg [2:0]NS;
    parameter   S0=3'b000,
                S1=3'b001,
                S2=3'b010,
                S3=3'b011,
                S4=3'b100,
                S5=3'b101,
                S6=3'b110,
                S7=3'b111;
 initial begin
 CS=S0;
 end
 
 //always@(CS,Go,cnt_out)
 always@(CS,Go,cnt_zero,DivZero,R_lt_Y)//<= to = 120 to 120 errors
 begin
     case(CS)
        S0: begin
            if(Go) NS<=S1;
            else NS<=S0;
            end
        S1: begin
        if(DivZero) NS<=S0;
        else NS<=S2;
        end
        S2: NS<=S3;
        S3:begin
            if(R_lt_Y) NS<=S5;
            else NS<=S4;
            end
        S4: begin
            //if(cnt_out==0) NS<=S6;
			if(cnt_zero) NS<=S6;
            else NS<=S3;
            end
        S5:begin
            //if(cnt_out==0) NS<=S6;
			if(cnt_zero) NS<=S6;
            else NS<=S3;
            end
        S6: NS<=S7;
        S7: NS<=S0;
     endcase
 end 
               
always@(posedge CLK,posedge rst)
 begin
     if(rst) CS<=S0;
     else  CS<=NS; 
 end
 
always@(CS,DivZero,R_lt_Y)
begin
case(CS)
    S0:begin
     X_RightIn=0; Err=0;
        {R_inmux_ctrl, R_LD, R_SL, R_SR, X_LD, X_SL, X_SR, Y_LD, n, cnt_CE, cnt_LD, cnt_UD, R_outmux_ctrl, X_outmux_ctrl, Done}           
         =17'b0_0_0_0_0_0_0_0_000_0_0_0_0_0_0;
        end
    S1:begin
        if(DivZero) begin
         X_RightIn=0;Err=1;
            {R_inmux_ctrl, R_LD, R_SL, R_SR, X_LD, X_SL, X_SR, Y_LD, n, cnt_CE, cnt_LD, cnt_UD, R_outmux_ctrl, X_outmux_ctrl, Done}           
             =17'b0_0_0_0_0_0_0_0_000_0_0_0_0_0_1;
             Err=1;
            end
            else
            begin
        X_RightIn=0;Err=0;
        {R_inmux_ctrl, R_LD, R_SL, R_SR, X_LD, X_SL, X_SR, Y_LD, n, cnt_CE, cnt_LD, cnt_UD, R_outmux_ctrl, X_outmux_ctrl, Done}           
         <=17'b0_1_0_0_1_0_0_1_100_1_1_0_0_0_0;
        end
        end
        
    S2:begin   
     X_RightIn=0; Err=0;
        {R_inmux_ctrl, R_LD, R_SL, R_SR, X_LD, X_SL, X_SR, Y_LD, n, cnt_CE, cnt_LD, cnt_UD, R_outmux_ctrl, X_outmux_ctrl, Done}           
         =17'b0_0_1_0_0_1_0_0_000_0_0_0_0_0_0;
        end
    S3:
    begin
    if(R_lt_Y) begin
    {R_inmux_ctrl, R_LD, R_SL, R_SR, X_LD, X_SL, X_SR, Y_LD, n, cnt_CE, cnt_LD, cnt_UD, R_outmux_ctrl, X_outmux_ctrl, Done}           
                 =17'b0_0_0_0_0_0_0_0_000_1_0_0_0_0_0;
    Err=0; X_RightIn=0;
    end
    else begin
      {R_inmux_ctrl, R_LD, R_SL, R_SR, X_LD, X_SL, X_SR, Y_LD, n, cnt_CE, cnt_LD, cnt_UD, R_outmux_ctrl, X_outmux_ctrl, Done}           
               =17'b1_1_0_0_0_0_0_0_000_1_0_0_0_0_0;
    Err=0; X_RightIn=0;
    end
    end
//    begin
//     X_RightIn=0; Err=0;
//    if(!R_lt_Y)
//        {R_inmux_ctrl, R_LD, R_SL, R_SR, X_LD, X_SL, X_SR, Y_LD, n, cnt_CE, cnt_LD, cnt_UD, R_outmux_ctrl, X_outmux_ctrl, Done}           
//             =17'b1_1_0_0_0_0_0_0_000_1_0_0_0_0_0;
//    else
//        {R_inmux_ctrl, R_LD, R_SL, R_SR, X_LD, X_SL, X_SR, Y_LD, n, cnt_CE, cnt_LD, cnt_UD, R_outmux_ctrl, X_outmux_ctrl, Done}           
//             =17'b0_0_0_0_0_0_0_0_000_1_0_0_0_0_0;
//        end
    S4: begin
        {R_inmux_ctrl, R_LD, R_SL, R_SR, X_LD, X_SL, X_SR, Y_LD, n, cnt_CE, cnt_LD, cnt_UD, R_outmux_ctrl, X_outmux_ctrl, Done}           
          =17'b0_0_1_0_0_1_0_0_000_0_0_0_0_0_0;
        X_RightIn=1;Err=0;
        end
    S5:begin
        {R_inmux_ctrl, R_LD, R_SL, R_SR, X_LD, X_SL, X_SR, Y_LD, n, cnt_CE, cnt_LD, cnt_UD, R_outmux_ctrl, X_outmux_ctrl, Done}          
             =17'b0_0_1_0_0_1_0_0_000_0_0_0_0_0_0;
        X_RightIn=0;Err=0;
        end
    S6:begin
        {R_inmux_ctrl, R_LD, R_SL, R_SR, X_LD, X_SL, X_SR, Y_LD, n, cnt_CE, cnt_LD, cnt_UD, R_outmux_ctrl, X_outmux_ctrl, Done}           
            =17'b0_0_0_1_0_0_0_0_000_0_0_0_0_0_0;
         X_RightIn=0;Err=0;
        end
    S7:begin
        {R_inmux_ctrl, R_LD, R_SL, R_SR, X_LD, X_SL, X_SR, Y_LD, n, cnt_CE, cnt_LD, cnt_UD, R_outmux_ctrl, X_outmux_ctrl, Done}           
             =17'b0_0_0_0_0_0_0_0_000_0_0_0_1_1_1;
         X_RightIn=0;Err=0;
        end   
endcase   
end
       
endmodule
