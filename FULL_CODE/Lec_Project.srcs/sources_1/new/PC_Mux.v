`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2022 08:01:23 PM
// Design Name: 
// Module Name: PC_Mux
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PC_Mux(PC_Source_Selector,ALU_Result,ALU_reg_Out,Inst_Jump,To_PC);
    input [31:0] ALU_Result,ALU_reg_Out,Inst_Jump;
    input [1:0] PC_Source_Selector;
    output reg [31:0] To_PC;
    
    always @(*)
    begin
        if(PC_Source_Selector == 0)
             To_PC <= ALU_Result;
    
        else if(PC_Source_Selector == 1)
             To_PC <= ALU_reg_Out;
    
        else
             To_PC <= Inst_Jump;
    end
    endmodule

