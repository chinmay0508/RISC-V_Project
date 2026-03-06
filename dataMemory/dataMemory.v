module dataMemory(
    input clk,
    input rst,
    input memRead,
    input memWrite,
    input [31:0] Address,
    input [31:0] write_data,
    output [31:0] read_data
);

reg [31:0] Dmemory [0:31];

assign read_data = Dmemory[Address >> 2]; // Memory always outputs data; CPU control logic decides whether to use it
integer i;
always @ (posedge clk)
begin 
    if(rst)
    begin
        for(i = 0; i<32; i = i +1)
        begin
            Dmemory[i] <= 32'h0;
        end
    end
    else
    begin
        if(memWrite) Dmemory[Address >> 2] <= write_data;
    end
end
endmodule