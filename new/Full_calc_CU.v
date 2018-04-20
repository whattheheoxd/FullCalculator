`timescale 1ns / 1ps
//Andrea suggested to keep X,Y and sm_calc_Op the same
module Full_calc_CU(input CLK, rst, Go, div_Done,sm_calc_Done, [2:0]F_Q, 
                output reg F_en, X_en, Y_en,  
                output reg [1:0]Y_sel,
				output reg div_Go, sm_calc_Go,
				output reg [1:0]sm_calc_Op, Sel_H, Sel_L,
				output reg OutH_en, OutL_en, div_Err_en, Done,
				output reg [3:0]CS);
        parameter   S0=4'b0000,
                    S1=4'b0001,
                    S2=4'b0010,
                    S3=4'b0011,//small calculator go
                    S4=4'b0100,
                    S5=4'b0101,//pipeline Input reg
                    S6=4'b0110,//pipeline stage reg 1
                    S7=4'b0111,//pipeline stage reg 2
                    S8=4'b1000,//pipeline output reg
                    S9=4'b1001,//pipeline to full calc
                    S10=4'b1010,//divider go
                    S11=4'b1011,  
                    S_Done=4'b1100
                    ;
    
    reg [3:0]NS;
   
	
			

    
 reg [15:0]CS_Outputs,Sout_Zeros, S0_out, S1_out, S2_10x, S2_110, S2_0xx, S3_x00, S3_x01, S4_0, S4_1, S8_out, S9_out,S10_0, S10_1, Done_Out;   



 initial begin
 CS=S0; 
     
 end
 
 
 always@(CS,Go,F_Q,div_Done,sm_calc_Done)
 begin
     case(CS)
        S0: begin
            if(Go) NS<=S1;
            else NS<=S0;
            end
        S1: begin
         NS<=S2;
        end
        S2: begin
		if(F_Q[1]==1'b0) NS<=S3;
		else if(F_Q[1:0]==2'b10) NS<=S5;
		else if(F_Q[2:0]==3'b011) NS<=S10;
		else NS<=S_Done;
		end
        S3:begin
            NS<=S4;
            end
        S4: begin
            if(sm_calc_Done) NS<=S_Done;
            else NS<=S4;
            end
        S5: NS<=S6;
        S6: NS<=S7;
        S7: NS<=S8;
        S8:NS<=S9;
        S9: NS<=S_Done;
        S10:NS<=S11;
        S11:if(div_Done) NS<=S_Done;
        else NS<=S11;
        S_Done: NS<=S0;
        default:NS<=S0;
     endcase
 end 
               
always@(posedge CLK,posedge rst)
 begin
     if(rst) CS<=S0;
     else  CS<=NS; 
 end
 
always@(CS,F_Q[2:0],div_Done,sm_calc_Done)
begin
// CS_Outputs ={F_en, X_en, Y_en, Y_sel,div_Go, sm_calc_Go,sm_calc_Op, Sel_H, Sel_L,OutH_en, OutL_en, Done};			
// Sout_Zeros<=    16'b0_0_0_00_0_0_00_00_00_0_0_0;
//     S0_out<=    16'b0_0_0_00_0_0_00_00_00_0_0_0;
//     S1_out<=    16'b1_1_1_10_0_0_00_00_00_0_0_0;
//     S2_10x<=    16'b0_0_1_01_0_0_00_00_00_0_0_0;
//     S2_110<=    16'b0_0_1_11_0_0_00_00_00_0_0_0;
//     S2_0xx<=    16'b0_0_0_00_0_0_00_00_00_0_0_0; //WHY is Y_Sel=2'b11 when Op=7 at S2???
//     S3_x00<=    16'b0_0_0_00_0_1_11_00_00_0_0_0;
//     S3_x01<=    16'b0_0_0_00_0_1_10_00_00_0_0_0;
//     S4_0<=      16'b0_0_0_00_0_0_00_00_00_0_0_0;
//     S4_1<=      16'b0_0_0_00_0_0_00_00_11_0_1_0;
//     S8_out<=    16'b0_0_0_00_0_0_00_11_10_1_1_0;
//     S9_out<=    16'b0_0_0_00_1_0_00_00_00_0_0_0;
//     S10_0<=     16'b0_0_0_00_0_0_00_00_00_0_0_0;
//     S10_1<=     16'b0_0_0_00_0_0_00_10_01_1_1_0;
//     Done_Out<=  16'b0_0_0_00_0_0_00_00_00_1_1_1;
case(CS)
 
    S0:begin
    div_Err_en=1'b0;
		{F_en, X_en, Y_en,Y_sel,div_Go, sm_calc_Go,sm_calc_Op, Sel_H, Sel_L,OutH_en, OutL_en, Done}=16'b0_0_0_00_0_0_00_00_00_0_0_0;//Sout_Zeros;
        end
    S1:begin
    div_Err_en=1'b0;
        {F_en, X_en, Y_en,Y_sel,div_Go, sm_calc_Go,sm_calc_Op, Sel_H, Sel_L,OutH_en, OutL_en, Done}=16'b1_1_1_10_0_0_00_00_00_0_0_0;//S1_out;
        end
        
    S2:begin   
    div_Err_en=1'b0;
     if(F_Q[2:0]==3'b110) {F_en, X_en, Y_en,Y_sel,div_Go, sm_calc_Go,sm_calc_Op, Sel_H, Sel_L,OutH_en, OutL_en, Done}=16'b0_0_1_11_0_0_00_00_00_0_0_0;//S2_110;
//     else if((F_Q[2:0]==3'b100) ||(F_Q[2:0]==3'b101)) {F_en, X_en, Y_en,Y_sel,div_Go, sm_calc_Go,sm_calc_Op, Sel_H, Sel_L,OutH_en, OutL_en, Done}=16'b0_0_1_01_0_0_00_00_00_0_0_0;//S2_10x;
     else if((F_Q[2:1]==2'b10)) {F_en, X_en, Y_en,Y_sel,div_Go, sm_calc_Go,sm_calc_Op, Sel_H, Sel_L,OutH_en, OutL_en, Done}=16'b0_0_1_01_0_0_00_00_00_0_0_0;//S2_10x;
     else {F_en, X_en, Y_en,Y_sel,div_Go, sm_calc_Go,sm_calc_Op, Sel_H, Sel_L,OutH_en, OutL_en, Done}=16'b0_0_0_00_0_0_00_00_00_0_0_0;//Sout_Zeros;
        end
    S3:
    begin
    div_Err_en=1'b0;
    if(F_Q[1:0]==2'b00) {F_en, X_en, Y_en,Y_sel,div_Go, sm_calc_Go,sm_calc_Op, Sel_H, Sel_L,OutH_en, OutL_en, Done}=16'b0_0_0_00_0_1_11_00_00_0_0_0;//S3_x00;
        else if(F_Q[1:0]==2'b01) {F_en, X_en, Y_en,Y_sel,div_Go, sm_calc_Go,sm_calc_Op, Sel_H, Sel_L,OutH_en, OutL_en, Done}=16'b0_0_0_00_0_1_10_00_00_0_0_0;//S3_x01;
                end
    S4: begin //Keep sm_calc_Op from previous... DON'T overwrite
          div_Err_en=1'b0;
          if(!sm_calc_Done) begin
          if(F_Q[1:0]==2'b00) sm_calc_Op=2'b11;
            else if(F_Q[1:0]==2'b01) sm_calc_Op=2'b10;
          {F_en, X_en, Y_en,Y_sel,div_Go, sm_calc_Go, Sel_H, Sel_L,OutH_en, OutL_en, Done}=14'b0_0_0_00_0_0_00_00_0_0_0;//Sout_Zeros;
          end
          else {F_en, X_en, Y_en,Y_sel,div_Go, sm_calc_Go, sm_calc_Op, Sel_H, Sel_L,OutH_en, OutL_en, Done}=16'b0_0_0_00_0_0_00_00_11_0_1_0;//S4_1;
          end
    S5:begin
    div_Err_en=1'b0;
        {F_en, X_en, Y_en,Y_sel,div_Go, sm_calc_Go,sm_calc_Op, Sel_H, Sel_L,OutH_en, OutL_en, Done}=16'b0_0_0_00_0_0_00_00_00_0_0_0;//Sout_Zeros;
               end
    S6:begin
    div_Err_en=1'b0;
        {F_en, X_en, Y_en,Y_sel,div_Go, sm_calc_Go,sm_calc_Op, Sel_H, Sel_L,OutH_en, OutL_en, Done}=16'b0_0_0_00_0_0_00_00_00_0_0_0;//Sout_Zeros;
        end
    S7:begin
    div_Err_en=1'b0;
        {F_en, X_en, Y_en,Y_sel,div_Go, sm_calc_Go,sm_calc_Op, Sel_H, Sel_L,OutH_en, OutL_en, Done}=16'b0_0_0_00_0_0_00_00_00_0_0_0;//Sout_Zeros;
        end
    S8:begin
    div_Err_en=1'b0;
         {F_en, X_en, Y_en,Y_sel,div_Go, sm_calc_Go,sm_calc_Op, Sel_H, Sel_L,OutH_en, OutL_en, Done}=16'b0_0_0_00_0_0_00_00_00_0_0_0;//Sout_Zeros;
            end    
    S9:begin
    div_Err_en=1'b0;
        {F_en, X_en, Y_en,Y_sel,div_Go, sm_calc_Go,sm_calc_Op, Sel_H, Sel_L,OutH_en, OutL_en, Done}=16'b0_0_0_00_0_0_00_11_10_1_1_0;//S8_out;
        end  
    S10: begin
    div_Err_en=1'b0;
     {F_en, X_en, Y_en,Y_sel,div_Go, sm_calc_Go,sm_calc_Op, Sel_H, Sel_L,OutH_en, OutL_en, Done}=16'b0_0_0_00_1_0_00_00_00_0_0_0;//S9_out;
     end
    
     S11: begin
     if(!div_Done) {F_en, X_en, Y_en,Y_sel,div_Go, sm_calc_Go,sm_calc_Op, Sel_H, Sel_L,OutH_en, OutL_en, Done}=16'b0_0_0_00_0_0_00_00_00_0_0_0;//Sout_Zeros;
     else begin
     div_Err_en<=1'b1;
     {F_en, X_en, Y_en,Y_sel,div_Go, sm_calc_Go,sm_calc_Op, Sel_H, Sel_L,OutH_en, OutL_en, Done}=16'b0_0_0_00_0_0_00_10_01_1_1_0;//S10_1;
     end
     end
     S_Done:begin
     div_Err_en<=1'b1;
     {F_en, X_en, Y_en,Y_sel,div_Go, sm_calc_Go,sm_calc_Op, Sel_H, Sel_L,OutH_en, OutL_en, Done}=16'b0_0_0_00_0_0_00_00_00_1_1_1;//Done_Out;

     end
     default:
     begin
   {F_en, X_en, Y_en,Y_sel,div_Go, sm_calc_Go,sm_calc_Op, Sel_H, Sel_L,OutH_en, OutL_en, Done}=16'b0_0_0_00_0_0_00_00_00_0_0_0;//Sout_Zeros;
div_Err_en=1'b0;
end
endcase
end
       
endmodule
