`timescale 1ns / 1ps

module ALU_A_Mux(ALU_A_Selector,PC,Reg_A_Out,Size_Out,Reg_B_Out,Out);

input [31:0] PC, Reg_A_Out,Size_Out,Reg_B_Out;
input [2:0]ALU_A_Selector;
output reg [31:0] Out;

always @(*)
begin
    if(ALU_A_Selector == 0)
        Out <= PC;

    else if(ALU_A_Selector == 1)
        Out <= Reg_A_Out;

	 else if(ALU_A_Selector == 2)
		Out <= 32'b0;
		
	 else if(ALU_A_Selector == 3)
		Out <= Size_Out;
		
	 else
		Out <= Reg_B_Out;
end
endmodule 
