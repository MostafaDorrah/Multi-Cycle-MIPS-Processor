`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2022 08:10:51 PM
// Design Name: 
// Module Name: Read_1_OR_3_Mux
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


module Read_1_OR_3_Mux(Selector,Instr25_21,Instr15_11,Out);

input [4:0] Instr25_21,Instr15_11;
input Selector;

output reg [4:0] Out;

always @(*)
begin
    if(Selector == 0)
        Out <= Instr25_21;
    else
        Out <= Instr15_11;
end
endmodule