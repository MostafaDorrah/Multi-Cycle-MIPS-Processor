`timescale 1ns / 1ps


module Instruction_Memory(PC,Instruction);

input [31:0] PC;
output [31:0] Instruction;
reg [31:0] Instruction;

always @(PC)
begin
case(PC)
//Program:
// $R0 = -1
// $R1 = 0
// $R2 = 2
// Add $R0 and $R2 and get an answer in $R3: 
// -1 + 2 = 1
	
	// LI   $R0, 0xFFFF 
	0: Instruction=  32'b111001_00000_00000_1111111111111111;
	// LUI  $R0, 0xFFFF
	1: Instruction=  32'b111010_00000_00000_1111111111111111;
	// LI   $R1, 0x0000
	2: Instruction=  32'b111001_00001_00000_0000000000000000;
	// LUI  $R1, 0x0000
	3: Instruction=  32'b111010_00001_00000_0000000000000000;
	// LI   $R2, 0x0002
	4: Instruction=  32'b111001_00010_00000_0000000000000010;
	// LUI  $R2, 0x0000
	5: Instruction=  32'b111010_00010_00000_0000000000000000;
	
	// ADD  $R3, $R0, $R2
	6: Instruction=  32'b010010_00011_00000_00010_00000000000; 

	// 1.2) now the we will store and load the value in $R3

	// SWI  $R3, [0x5]
	7: Instruction=  32'b111100_00011_00000_0000000000000101;
	// LWI  $R1, [0x5]
	8: Instruction=  32'b111011_00001_00000_0000000000000101;
endcase
end

endmodule