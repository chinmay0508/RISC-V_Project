module alu_32bit(
    input  [31:0] op_1_in,
    input  [31:0] op_2_in,
    input  [3:0]  aluCtrl,
    output reg [31:0] result_out
);

always @(*) 
begin
    case (aluCtrl)

        4'b0000: result_out = op_1_in & op_2_in;                 // AND
        4'b0001: result_out = op_1_in | op_2_in;                 // OR
        4'b0010: result_out = op_1_in + op_2_in;                 // ADD
        4'b0011: result_out = op_1_in << op_2_in[4:0];           // SLL
        4'b0100: result_out = op_1_in ^ op_2_in;                 // XOR
        4'b0101: result_out = op_1_in >> op_2_in[4:0];           // SRL
        4'b0110: result_out = op_1_in - op_2_in;                 // SUB
        4'b0111: result_out = ($signed(op_1_in) < $signed(op_2_in)) ? 32'b1 : 32'b0; // SLT
        4'b1001: result_out = (op_1_in < op_2_in) ? 32'b1 : 32'b0; // SLTU
        4'b1101: result_out = $signed(op_1_in) >>> op_2_in[4:0]; // SRA
        4'b1000: result_out = op_2_in;                           // LUI

        default: result_out = 32'b0;

    endcase
end

endmodule