`timescale 1ns / 1ps


module PC(CLK,Reset,PC_In,PC_Out,Control_PC_Write);

input Control_PC_Write,CLK,Reset;
input [31:0]PC_In;
output	reg	[31:0] PC_Out;

    initial 
    begin
    PC_Out = 0;//Initialize with 0
    end
    
    always @ (posedge CLK)
    begin
        if(Reset == 1'b1)
            PC_Out <= 0;
    
        if(Control_PC_Write == 1'b1)
            PC_Out <= PC_In;
    end
    endmodule
