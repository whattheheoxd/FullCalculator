`timescale 1ns / 1ps


module small_calc_CU( input CLK, Go,input [1:0] Op, output reg [3:0] CS, output reg Done,
output reg [1:0] s1, wa, raa, rab, c,
output reg  we, rea, reb, s2);
reg [3:0] NS;
parameter   S0=4'b0000,
            S1=4'b0001,
            S2=4'b0010,
            S3=4'b0011,
            S4=4'b0100,
            S5=4'b0101,
            S6=4'b0110,
            S7=4'b0111,
            S8=4'b1000;

initial begin
CS=S0;
end

always@(CS,Op,Go)
begin
    case(CS)
        S0: begin
            if(Go)NS<=S1;
            else NS<=S0;
           end
        S1: NS<=2;
        S2: NS<=3;
        S3: begin
            if(Op==3) NS<=S4;
            else if(Op==2) NS<=S5;
            else if(Op==1) NS<=S6;
            else if(Op==0) NS<=S7;
           end
        S4: NS<=S8;
        S5: NS<=S8;
        S6: NS<=S8;
        S7: NS<=S8;
        S8: NS<=S0;
        default: NS<=S0;
    endcase
end


always@(posedge CLK)
begin
    CS<=NS; 
end

always@(CS)
begin
case(CS)
    S0: begin
        s1=1; wa=0; we=0; raa=0; rea=0; rab=0; reb=0; c=0; s2=0; Done=0;
       end
    S1: begin
        s1=3; wa=1; we=1; raa=0; rea=0; rab=0; reb=0; c=0; s2=0; Done=0;
       end
    S2: begin
        s1=2; wa=2; we=1; raa=0; rea=0; rab=0; reb=0; c=0; s2=0; Done=0;
       end
    S3: begin
        s1=1; wa=0; we=0; raa=0; rea=0; rab=0; reb=0; c=0; s2=0; Done=0;
       end
    S4: begin
        s1=0; wa=3; we=1; raa=1; rea=1; rab=2; reb=1; c=0; s2=0; Done=0;
       end
    S5: begin
        s1=0; wa=3; we=1; raa=1; rea=1; rab=2; reb=1; c=1; s2=0; Done=0;
       end
    S6: begin
        s1=0; wa=3; we=1; raa=1; rea=1; rab=2; reb=1; c=2; s2=0; Done=0;
       end
    S7: begin
        s1=0; wa=3; we=1; raa=1; rea=1; rab=2; reb=1; c=3; s2=0; Done=0;
       end
    S8: begin
        s1=1; wa=0; we=0; raa=3; rea=1; rab=3; reb=1; c=2; s2=1; Done=1;
       end
    
    default: begin
               s1=1; wa=0; we=0; raa=0; rea=0; rab=0; reb=0; c=0; s2=0; Done=0;
              end
endcase
end


endmodule
