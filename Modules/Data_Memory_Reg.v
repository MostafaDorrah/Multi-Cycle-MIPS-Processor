`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/28/2022 07:54:43 PM
// Design Name: 
// Module Name: Data_Memory_Reg
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


module Data_Memory_Reg(CLK,Reset,out,in);

input CLK,Reset;
input [31:0] in;

output reg [31:0] out;

always @ (posedge CLK)
begin
    if(Reset)
       out <= 0;
    else
        out <= in;
end
endmodule
