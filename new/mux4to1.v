module MUX4to1(in1, in2, in3, in4, s1, m1out); 
parameter Data_width = 4;
input[Data_width-1:0] in1, in2, in3, in4;
input[1:0] s1;

output reg[Data_width-1:0] m1out;

always @(in1, in2, in3, in4, s1)
begin 
    case(s1) 
        2'b11: m1out = in1;
        2'b10: m1out = in2;
        2'b01: m1out = in3; 
        default:m1out = in4; // 2'b00 
    endcase 
end

endmodule//MUX4to1