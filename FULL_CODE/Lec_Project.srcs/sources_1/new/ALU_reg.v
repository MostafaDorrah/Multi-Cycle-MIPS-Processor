`timescale 1ns / 1ps

module ALU_reg(Clk,Reset,ALU_OUT,Reg_Out);
    input [31:0] ALU_OUT;
    input Clk,Reset;
    output reg [31:0] Reg_Out;
    
    always @ (posedge Clk)
    begin
        if(Reset)
            Reg_Out <= 32'b0;
    
        else
            Reg_Out <= ALU_OUT;
    end
endmodule
