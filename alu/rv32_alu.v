module rv32_alu(
    input [31:0] op_1_in,
    input [31:0] op_2_in,
    input [2:0]  funct3,  // RISC-V funct3
    input funct7_5,      //RISC-V funct7[5], 1=SUB or SRA
    output reg [31:0] result_out
);
    // Parameters for funct3
    parameter FUNCT3_ADD  = 3'b000;
    parameter FUNCT3_SLT  = 3'b010;
    parameter FUNCT3_SLTU = 3'b011;    
    parameter FUNCT3_AND  = 3'b111;    
    parameter FUNCT3_OR   = 3'b110;   
    parameter FUNCT3_XOR  = 3'b100;    
    parameter FUNCT3_SLL  = 3'b001;    
    parameter FUNCT3_SRL  = 3'b101;

    wire signed [31:0] signed_op1 = op_1_in;
    wire signed [31:0] signed_op2 = op_2_in;
    
    // Subtraction logic: if funct7[5]
    wire [31:0] sum_result = funct7_5 ? (op_1_in - op_2_in) : (op_1_in + op_2_in);
    
    // Shift logic
    wire [31:0] sra_result = signed_op1 >>> op_2_in[4:0];
    wire [31:0] srl_result = op_1_in >> op_2_in[4:0];
    wire [31:0] shr_result = funct7_5 ? sra_result : srl_result;

    // Set Less Than logic
    wire sltu_result = (op_1_in < op_2_in);
    wire slt_result  = (signed_op1 < signed_op2);

    // Selection of ALU operation
    always @(*) begin
        case (funct3)
            FUNCT3_ADD : result_out = sum_result;
            FUNCT3_SRL : result_out = shr_result;
            FUNCT3_OR  : result_out = op_1_in | op_2_in;
            FUNCT3_AND : result_out = op_1_in & op_2_in;
            FUNCT3_XOR : result_out = op_1_in ^ op_2_in;
            FUNCT3_SLT : result_out = {31'b0, slt_result};
            FUNCT3_SLTU: result_out = {31'b0, sltu_result};
            FUNCT3_SLL : result_out = op_1_in << op_2_in[4:0];
            default:     result_out = 32'b0;
        endcase
    end
endmodule