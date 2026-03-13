module mux2to1(a,b,y,sel);
input [31:0]a;
input [31:0]b;
input sel;
output reg [31:0]y;
always @(*)
begin
    case(sel)
    1'b0 :y = a;
    1'b1 :y = b;
    default:y=1'bx;
    endcase
end
endmodule