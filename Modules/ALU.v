`timescale 1ns / 1ps

module ALU(A,B,ALUControl,Reset,BorN,Flag,ALU_Output);
input [31:0] A,B;
input [2:0] ALUControl;
input [1:0] BorN;
input Reset;
output reg Flag;
output reg [31:0] ALU_Output;
reg [31:0] SLT;

always @ (*)
begin
	if(Reset == 1)
		ALU_Output <= 32'b0;

	else
	begin	
		if(A >= B)
			SLT = 32'b1;
		else
			SLT = 32'b0;
			

		if(BorN == 2'b00)//BEQ
		begin if(A == B)
					Flag <= 1'b1;
			else
				Flag <= 1'b0; end
		
		if(BorN == 2'b01)//BNQ
		begin if(A != B)
					Flag <= 1'b1;					
			else
				Flag <= 1'b0; end
		
		if(BorN == 2'b10)begin //Branch if less than (BLT)
			if(A < B)
					Flag <= 1'b1;					
			else
				Flag <= 1'b0;end
		
		if(BorN == 2'b11)begin//Branch on Less than or Equal(BLE)
			if(A <= B)
					Flag <= 1'b1;
			else
				Flag <= 1'b0;end
        
		case (ALUControl)
			000: ALU_Output <= B; //MOV
			001: ALU_Output <= ~B;//NOT
			010: ALU_Output <= B + A;//ADD
			011: ALU_Output <= B - A;//SUB
			100: ALU_Output <= (A | B);//OR
			101: ALU_Output <= (A & B);//AND
			110: ALU_Output <= A ^ B;//XOR
			111: ALU_Output <= SLT;//Shift Left
		endcase
	end
end
endmodule

