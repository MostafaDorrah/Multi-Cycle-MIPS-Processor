`timescale 1ns / 1ps


module Instruction_Register(Clk,Reset,Instruction,Inst_Reg_Write,Instr31_26,Instr25_21,Instr20_16,Instr15_0);

input Clk,Reset,Inst_Reg_Write;
input [31:0] Instruction;

output reg [5:0] Instr31_26;
output reg [4:0] Instr25_21,Instr20_16;
output reg [15:0] Instr15_0;

always @ (posedge Clk or posedge Reset)//Reset all back to 0
    if(Reset)
    begin
        Instr31_26 <= 0;
        Instr25_21 <= 0;
        Instr20_16 <= 0;
        Instr15_0 <= 0;
    end
    
    else if(Inst_Reg_Write==1'b1)//Split the fetched values
    begin
        Instr31_26 <= Instruction [31:26];
        Instr25_21 <= Instruction [25:21];
        Instr20_16 <= Instruction [20:16];
        Instr15_0 <= Instruction [15:0];
    end
    

endmodule



