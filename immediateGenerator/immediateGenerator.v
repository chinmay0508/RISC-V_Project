module immediateGenerator(
    input [31:0] instr_in,
    output reg [31:0] immediate_instr
);
always @ (*)
begin
    case(instr_in[6:0])
    7'b0110011 :begin                                            // R type(not needed as R type has no immediate value,
        immediate_instr = 32'b0 ;                                        //but still kept to avoid latch)
    end
    7'b0010011, 7'b1100111, 7'b0000011, 7'b1110011 :begin        // I type (jalr, ecall, ebreak + normal I)
        immediate_instr = {{20{instr_in[31]}}, instr_in[31:20]};
    end
    7'b0100011 :begin                                            // S type
        immediate_instr = {{20{instr_in[31]}}, instr_in[31:25],instr_in[11:7]};
    end
    7'b1101111 :begin                                            // J type  
        immediate_instr = {{11{instr_in[31]}}, instr_in[31],instr_in[19:12],instr_in[20],instr_in[30:21],1'b0};
    end
    7'b1100011 :begin                                            // B type
        immediate_instr = {{19{instr_in[31]}},instr_in[31], instr_in[7], instr_in[30:25],instr_in[11:8], 1'b0};
    end
    7'b0010111, 7'b0110111 :begin                                // U type (lui + auipc)   
        immediate_instr = {instr_in[31:12], 12'b0};   
    end
    default :begin
        immediate_instr = 32'b0; 
    end             
    endcase
end
endmodule