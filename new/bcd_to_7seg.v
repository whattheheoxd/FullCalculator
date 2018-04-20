module bcd_to_7seg (input [3:0] BCD, output reg [7:0] s_1s);

always @ (BCD)
begin
      
    case (BCD)
    0: s_1s = 8'b10001000; //active low outputs
    1: s_1s = 8'b11101101; //s6 s5 s4 ... s0
    2: s_1s = 8'b10100010;
    3: s_1s = 8'b10100100; //display 3 on 7-seg
    4: s_1s = 8'b11000101; //display 4 on 7-seg
    5: s_1s = 8'b10010100; //display 5 on 7-seg
    6: s_1s = 8'b10010000; //and so on...
    7: s_1s = 8'b10101101;
    8: s_1s = 8'b10000000;
    9: s_1s = 8'b10000100;
    default: s_1s = 8'b01111111;
    endcase
    
end
endmodule
