
`timescale 1ns / 1ps

module Sign_Extend(Zero_Sign,Instr15_0,Out);
input [15:0] Instr15_0;
input [1:0] Zero_Sign;
output reg [31:0] Out;

always @(*)
begin
    if(Zero_Sign == 0)begin
        if(Instr15_0[15] == 2'b00)//Increase without chagning the sign
            Out <= {16'b0000000000000000,Instr15_0};
        else
            Out <= {16'b1111111111111111,Instr15_0};end
	 
    else if(Zero_Sign == 2'b01)//Increase with chagning the sign according to Zero_Sign
        Out <= {16'b0000000000000000,Instr15_0};

    else if(Zero_Sign == 2'b10)
		Out <= {Instr15_0,16'b0000000000000000};

	 else
        Out <= {14'b00000000000000,Instr15_0,2'b00};
end
endmodule
