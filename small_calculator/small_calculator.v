
//module small_calculator(input clk, input [2:0]In1, [2:0]In2, output [2:0]Out,
module small_calculator(input clk, input [3:0]In1, [3:0]In2, output [3:0]Out,
input Go, input [1:0] Op, output [3:0] CS, output Done
);
wire [1:0] s1, wa, raa, rab, c;
wire we, rea, reb, s2;
   
    small_calc_CU control_unit(  clk, Go, Op, CS, Done,
        s1, wa, raa, rab, c,
        we, rea, reb, s2  );
    small_calc_DP datapath(In1, In2, s1, clk, wa, we, raa, rea, rab, reb, c, s2, Out);
  
    
endmodule
