`timescale 1ns / 1ps

module Reg_out_R(CLK,Reset,in,out);
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
