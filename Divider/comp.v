module comparator(A, B, lt);
parameter Data_width = 4;
input [Data_width - 1:0] A;
input [Data_width - 1:0] B;
output reg lt;

always @ (A or B)
begin
    lt <= 1'b0;
    if (A < B)
        lt <= 1'b1;
end
endmodule