`timescale 1ns / 1ps

module Write_to_reg_Mux(Reg_Selector,Instr25_21,Instr15_11,out);

input [4:0] Instr25_21,Instr15_11;
input [1:0]	Reg_Selector;

output reg [4:0] out;

always @(*)
begin
	if(Reg_Selector == 2'b00)
		out <= Instr25_21;
		
	else if(Reg_Selector == 2'b10)
		out <= 5'b11111;
		
	else
		out <= Instr15_11;
end
endmodule
