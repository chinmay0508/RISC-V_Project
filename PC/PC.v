module PC(
    input [31:0] pc_in,
    input clk,
    input rst,
    output reg [31:0] pc_out
);
always @(posedge clk) 
begin
    if(rst)
        pc_out<=32'd0;
    else
        pc_out<=pc_in;
end
endmodule