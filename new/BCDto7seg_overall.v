`timescale 1ns / 1ps

module BCDto7seg_overall(input [3:0]CS, [2:0]F_Q, [3:0]H_Out, [3:0]L_Out, output reg [7:0] seg3,seg2,seg1,seg0    );
     reg [4:0] H_Out1,H_Out10,  L_Out1, L_Out10,CS1,CS10;
       wire [7:0] seg_H_ones,seg_H_tens,seg_L_ones,seg_L_tens, seg_CS_ones,seg_CS_tens;
       wire [7:0] seg_P_hundreds, seg_P_tens, seg_P_ones;
       reg [7:0] Product;
       reg [3:0]P_ones, P_tens, P_hundreds;
       supply1 vcc;
    always@(CS,H_Out,L_Out)
        begin
            if(F_Q[1:0]!=2'b10) //if not a multiplication
                begin
                H_Out1=H_Out%10;
                H_Out10=H_Out/10;
                L_Out1=L_Out%10;
                L_Out10=L_Out/10;
                
                seg3=seg_H_tens;
                seg2=seg_H_ones;
                seg1=seg_L_tens;
                seg0=seg_L_ones;
                end
            else
                begin
                    Product = {H_Out, L_Out};         
                  seg3=8'b10001000;
                    seg2=seg_P_hundreds;
                    seg1=seg_P_tens;
                    seg0=seg_P_ones;
                  
                end
        end       
        always@(Product)
        begin
        P_ones= Product%10;
       P_tens = (Product%100)/10;
       P_hundreds = Product/100;
        end
        
        bcd_to_7seg BCD_P1s (P_ones, seg_P_ones);
        bcd_to_7seg BCD_P10s (P_tens, seg_P_tens);
        bcd_to_7seg BCD_P100s (P_hundreds, seg_P_hundreds);
        
        
    bcd_to_7seg BCD_H1s (H_Out1, seg_H_ones);
    bcd_to_7seg BCD_H10s (H_Out10, seg_H_tens);
    bcd_to_7seg BCD_L1s (L_Out1, seg_L_ones);
    bcd_to_7seg BCD_L10s (L_Out10, seg_L_tens);
endmodule
