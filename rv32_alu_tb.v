module msrv32_alu_tb;
    reg [31:0] op_1_in, op_2_in;
    reg [3:0]  opcode_in;
    wire [31:0] result_out;

    // Instantiate using named ports for clarity
    rv32_alu ALU (
        .op_1_in(op_1_in),
        .op_2_in(op_2_in),
        .opcode_in(opcode_in),
        .result_out(result_out)
    );

    task initialize;
        begin
            op_1_in = 32'd0;
            op_2_in = 32'd0;
            opcode_in = 4'd0;
        end
    endtask

    task stimulus(input [31:0] op1, input [31:0] op2, input [3:0] opcode);
        begin 
            #10;
            op_1_in = op1;
            op_2_in = op2; 
            opcode_in = opcode;
        end
    endtask

    initial begin
        initialize;
        stimulus(32'd20, 32'd40, 4'b0000); // ADD: 60
        stimulus(32'd20, 32'd40, 4'b1000); // SUB: -20
        stimulus(32'd60, 32'd50, 4'b0000); // ADD: 110
        #50 $finish;
    end

    initial begin
        $monitor("Time=%0t | Op1=%d | Op2=%d | Opcode=%b | Result=%d", 
                 $time, op_1_in, op_2_in, opcode_in, result_out);
    end
endmodule