`timescale 1ns / 1ps


module Full_Calc_fpga(input clk100MHz, rst, Debouncer_button,
        input [3:0]A,B, [2:0] Op,
        input Go,  output Done, div_Err,
        output [7:0] LEDSEL, [7:0] LEDOUT);

supply1 [7:0] vcc;
    wire DONT_USE, clk_5KHz;
    wire Debouncer_out;
    wire [3:0] H_Out, L_Out;
    wire [3:0] CS;
    wire [2:0]F_Q;
//     reg [4:0] H_Out1,H_Out10,  L_Out1, L_Out10;
reg [4:0] CS1,CS10;
//    wire [7:0] seg_H_ones,seg_H_tens,seg_L_ones,seg_L_tens;
wire [7:0] seg_CS_ones,seg_CS_tens;
wire [7:0] seg3,seg2,seg1,seg0;
     

   always@(CS)
    begin
    CS1=CS%10;
    CS10=CS/10;
    end     
   
//   always@(CS,H_Out,L_Out)
//    begin
//    H_Out1=H_Out%10;
//    H_Out10=H_Out/10;
//    L_Out1=L_Out%10;
//    L_Out10=L_Out/10;
//    CS1=CS%10;
//    CS10=CS/10;
//    end        

BCDto7seg_overall BCD_overall(CS, F_Q, H_Out, L_Out, seg3,seg2,seg1,seg0    );
         
    FullCalc DUT_calc(Debouncer_out, rst, Go, A, B, Op,
                        H_Out, L_Out,
                        Done, div_Err,
                        CS,F_Q);
                        
clk_gen autoClock(.clk100MHz( clk100MHz ), .rst( rst ), .clk_4sec( DONT_USE ), .clk_5KHz( clk_5KHz ));
                            button_debouncer #8 Debouncer(.clk( clk_5KHz),                
                                                 .button( Debouncer_button ),              /* Input button from constraints */
                                                 .debounced_button( Debouncer_out ) );
     
             
//    bcd_to_7seg BCD_Q1s (H_Out1, seg_H_ones);
//    bcd_to_7seg BCD_Q10s (H_Out10, seg_H_tens);
//    bcd_to_7seg BCD_R1s (L_Out1, seg_L_ones);
//    bcd_to_7seg BCD_R10s (L_Out10, seg_L_tens);
    bcd_to_7seg BCD_CS1s (CS1, seg_CS_ones);
    bcd_to_7seg BCD_CS10s (CS10, seg_CS_tens);
    
            
//     led_mux LED_mux (clk_5KHz, rst,
//                  seg_CS_tens,seg_CS_ones,  vcc, vcc, seg_H_tens, seg_H_ones, seg_L_tens, seg_L_ones, //activelow so vcc
//                  LEDSEL, LEDOUT);  
          led_mux LED_mux (clk_5KHz, rst,
            seg_CS_tens,seg_CS_ones,  vcc, vcc, seg3, seg2, seg1, seg0, //activelow so vcc
            LEDSEL, LEDOUT);  
                           
endmodule
