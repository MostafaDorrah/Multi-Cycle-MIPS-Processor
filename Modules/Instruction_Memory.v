`timescale 1ns / 1ps
// ----------------------------------------------------
// IMPORTANT!
// Which test program to use:
// - PROGRAM_1: first simple example.
//
// - PROGRAM_2: test remaining instructions 
//              and corner cases.
// - PROGRAM_3: optional LW/SW program.
//
//
// Change the previous line to try a different program,
// when available.
// ----------------------------------------------------

module Instruction_Memory(PC,Instruction);

input [31:0] PC;

output [31:0] Instruction;
reg [31:0] Instruction;

always @(PC)
begin
case(PC)



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

	//
	// 1.2) Second part: store and load, should store $R3
	// (contains 1) into address 5.  Then load from 
	// address 5 into register $R1.  $R1 should then 
	// contain 1.
	//

	// SWI  $R3, [0x5]
	7: Instruction=  32'b111100_00011_00000_0000000000000101;
	// LWI  $R1, [0x5]
	8: Instruction=  32'b111011_00001_00000_0000000000000101;


	//
	// 1.3) Third part: simple loop tests, to check branch
	//     look at the PC and alu output to check
	//

	// LI	$R23, 0x0000
	9: Instruction=	 32'b111001_10111_00000_0000000000000000;
	// ADDI $R0, $R0, 0x0001
	10: Instruction=  32'b110010_00000_00000_0000000000000001;
	// SLT  $R31, $R0, $R1
	11: Instruction= 32'b010111_11111_00000_00001_00000000000;
	// BNE 	$R31, $R23, 0xFFFD
	12: Instruction= 32'b100001_11111_10111_1111111111111101;


	// LI	$R23, 0x0003
	13: Instruction=  32'b111001_10111_00000_0000000000000011;
	// ADDI $R24, $R24, 0x0001
	14: Instruction=  32'b110010_11000_11000_0000000000000001;
	// BLT 	$R24, $R23, 0xFFFE
	15: Instruction= 32'b100010_11000_10111_1111111111111110;

	
	// ADDI $R25, $R25, 0x0001
	16: Instruction= 32'b110010_11001_11001_0000000000000001;
	// BLE 	$R25, $R23, 0xFFFE
	17: Instruction= 32'b100011_11001_10111_1111111111111110;

	// J 22	/ should skip the two addi 5 and go to addi 7
	18: Instruction= 32'b000001_00000_00000_0000000000010101;
	// ADDI $R0, $R0, 0x0005
	19: Instruction= 32'b110010_00000_00000_0000000000000101;
	// ADDI $R0, $R0, 0x0005
	20: Instruction= 32'b110010_00000_00000_0000000000000101;
	// ADDI $R26, $R26, 0x0007
	21: Instruction= 32'b110010_11010_11010_0000000000000111;
	// NOOP
	22: Instruction= 32'b000000_00000_00000_0000000000000000;
	
	default: Instruction= 0; //NOOP
endcase
end

endmodule