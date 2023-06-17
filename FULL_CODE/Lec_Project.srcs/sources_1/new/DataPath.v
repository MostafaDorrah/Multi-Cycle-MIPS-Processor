`timescale 1ns / 1ps


module DataPath(CLK,Reset,Instruction,PC_Out,PCW,Memory,ALU_Reg_Out,Mem_Data_Reg_Out,Read_Data1,Read_Data2,Reg_A_Out,Reg_B_Out,RAMO,RBMO,SZSE_Out,Result,Write_Data,Instr15_0,Instr31_26,Instr25_21,Instr20_16,Write_Reg,ReadReg1,R1O3_Out,ALUOp,ALUSrcA,PC_Source,ALUSrcB,ZorS,RegDst,BorN,PCWrite,MemWrite,IRWrite,MemToReg,Zero,PCWriteCond,PCWriteEnable,BOC,RegWrite,Read1or3);

input CLK,Reset;
output wire [31:0] Instruction,PC_Out,PCW,Memory,ALU_Reg_Out,Mem_Data_Reg_Out,Read_Data1,Read_Data2,Reg_A_Out,Reg_B_Out,RAMO,RBMO;
output wire [31:0] SZSE_Out,Result,Write_Data;
output wire [15:0] Instr15_0;
output wire [5:0] Instr31_26;
output wire [4:0] Instr25_21,Instr20_16,Write_Reg,ReadReg1,R1O3_Out;
output wire [2:0] ALUOp,ALUSrcA;
output wire [1:0] PC_Source,ALUSrcB,ZorS,RegDst,BorN;
output wire PCWrite,MemWrite,IRWrite,MemToReg,Zero,PCWriteCond,PCWriteEnable,BOC,RegWrite,Read1or3;

assign PCWriteEnable = (PCWriteCond & Zero) | PCWrite;

PC PC_ (CLK,Reset,PCW,PC_Out,PCWriteEnable);
Instruction_Memory InstructionMemory (PC_Out,Instruction);

Data_Memory DataMemory (CLK,Reg_A_Out,Memory,ALU_Reg_Out,MemWrite);
Data_Memory_Reg DataMemoryReg (CLK,Reset,Mem_Data_Reg_Out,Memory);

Instruction_Register InstructionRegister (CLK,Reset,Instruction,IRWrite,Instr31_26,Instr25_21,Instr20_16,Instr15_0);

Control_Unit ControlUnit(CLK,Reset,Instr31_26,ALUOp,ALUSrcA,ALUSrcB,BorN,PC_Source,ZorS,RegDst,PCWriteCond,PCWrite,RegWrite,IRWrite,MemWrite,MemToReg,Read1or3);

Write_to_reg_Mux Write_to_regMux (RegDst,Instr25_21,Instr15_0[15:11],Write_Reg);
Read_1_OR_3_Mux Read_1_OR_3Mux (Read1or3,Instr25_21,Instr15_0[15:11],ReadReg1);
Write_to_reg_Mux Writeto_regMux (MemToReg,ALU_Reg_Out,Mem_Data_Reg_Out,Write_Data);

register_file registerfile (CLK,ReadReg1,Instr20_16,Write_Reg,Write_Data,Read_Data1,Read_Data2,RegWrite);

Reg_out_R RegA (CLK,Reset,Read_Data1,Reg_A_Out);
Reg_out_R RegB (CLK,Reset,Read_Data2,Reg_B_Out);
ALU_A_Mux ALU_AMux (ALUSrcA,PC_Out,Reg_A_Out,SZSE_Out,Reg_B_Out,RAMO);
ALU_B_Mux ALU_BMux (ALUSrcB,Reg_B_Out,SZSE_Out,RBMO);

ALU Alu (RAMO,RBMO,ALUOp,Reset,BorN,Zero,Result);
ALU_reg AluOut (CLK,Reset,Result,ALU_Reg_Out);

PC_Mux PCMux (PC_Source,Result,ALU_Reg_Out,{PC_Out[31:26],Instr25_21,Instr20_16,Instr15_0},PCW);
Sign_Extend SignExtend (ZorS,Instr15_0,SZSE_Out);

endmodule