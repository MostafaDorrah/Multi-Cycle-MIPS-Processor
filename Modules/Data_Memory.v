`timescale 1ns / 1ps

module Data_Memory(Clk,Write_Data,Output_Data,Memory_Address,Memory_allow_Write);  

input Clk,Memory_allow_Write;   
input [31:0] Write_Data;
input [15:0] Memory_Address;
output [31:0] Output_Data;

reg [31:0] memo [15:0];

assign Output_Data = memo[Memory_Address];//returning from memory

always @(posedge Clk)
begin

	if(Memory_allow_Write==1'b1)begin
		memo[Memory_Address] <= Write_Data;end// Writing to memory
		
end
endmodule

