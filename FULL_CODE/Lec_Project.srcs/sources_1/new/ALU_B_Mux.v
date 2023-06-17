`timescale 1ns / 1ps

module ALU_B_Mux(ALU_B_selector,Reg_B_Out,Size_Out,Out);

input [31:0] Reg_B_Out,Size_Out;
input [1:0] ALU_B_selector;
output reg [31:0] Out;

always @ (*)
begin
    if(ALU_B_selector == 0)
        Out <= Reg_B_Out;
		  
    else if(ALU_B_selector == 1)
        Out <= 1;

    else
        Out <= Size_Out;
end
endmodule

