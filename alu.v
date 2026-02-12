module ALU_32bit(
input [31:0] A,
input [31:0] B,
input [2:0] sel,
input Clock,
output reg [31:0] Y,
output reg Zero,
output reg Cout,
output reg Borrow
);
reg [31:0] reg1, reg2,ans1;
reg [2:0] sel_in;
reg c_out,b_out,zero;
always @(*)
begin
    case (sel_in)
	    ans1 = 0;
   	    c_out = 0;
    	    b_out = 0;
    	    zero = 0;
        3'b000: begin
		{c_out,ans1}=reg1+reg2;
		b_out=0;
		end      				//Addition 000
        3'b001: begin
            ans1=reg1-reg2;
            c_out=0;                                  //Subtraction 001
            b_out= (reg1<reg2)?1:0;end 
        3'b010: begin ans1=reg1&reg2;c_out=0;b_out=0;end     //bitwise AND
        3'b011: begin ans1=reg1|reg2;c_out=0;b_out=0;end     //bitwise OR
        3'b100: begin ans1=reg1^reg2;c_out=0;b_out=0;end     //bitwise XOR
	3'b101: begin     				     // increment
    		{c_out, ans1} = reg1 + 1; 
    		b_out = 0; 
		end
	3'b110: begin 					      //decrement
    		ans1 = reg1 - 1; 
    		c_out = 0; 
   		b_out = (reg1 == 0) ? 1 : 0; 
		end
        default: begin ans1=0;c_out=0;b_out=0;end 
    endcase
    zero=(ans1==0)? 1'b1:1'b0;
end
always @(posedge Clock)
begin
	reg1<= A;
	reg2<= B;
	sel_in<=sel;
end
always @(posedge Clock)
begin
	Y<= ans1;
	Zero<= zero;
	Borrow<=b_out;
	Cout<= c_out;
end

endmodule
