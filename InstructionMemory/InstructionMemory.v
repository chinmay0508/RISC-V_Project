module InstructionMemory (
    input [31:0] address_read,
    output [31:0] instruction_out
);

reg [31:0] Memory [0:31]; // creating memory of 32 bits width and 32 registers

assign instruction_out = Memory[address_read >> 2]; 
// PC is byte-addressed; >>2 converts byte address to word index, it divides by address_read = address_read/2^n(n=2)

initial 
begin
    $readmemb("program.mem", Memory);
end
endmodule