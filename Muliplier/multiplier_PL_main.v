`timescale 1ns / 1ps


module multiplier_PL_main(input clock, input rst, input enable, input [3:0]A, input[3:0]B, output [7:0]P);
wire [7:0] AB_in;
wire [7:0] PP23_d, PP01_d;
wire [7:0] PP23_q, PP01_q;
wire [7:0] Product_d;
wire [7:0] Product_q;
    
D_Reg Input_Reg( .clk( clock ), .reset( rst ), .en( enable ), .d ( {A,B} ), .q( AB_in )); 
multiplier_PL_sub1 And_Shift(.A( AB_in[7:4] ), .B( AB_in[3:0] ),
                .PP2plus3 ( PP23_d ), .PP0plus1( PP01_d ));
D_Reg Stage_Reg1( .clk( clock ), .reset( rst ), .en( enable ), .d ( PP01_d ), .q( PP01_q )); 
D_Reg Stage_Reg2( .clk( clock ), .reset( rst ), .en( enable ), .d ( PP23_d ), .q( PP23_q )); 
multiplier_PL_sub2 Add_all(.PP2plus3( PP23_q ), .PP0plus1( PP01_q ),
                    .P( Product_d ));
D_Reg Output_Reg(.clk( clock ), .reset( rst ), .en( enable ), .d ( Product_d ), .q( P )); 
    
endmodule
