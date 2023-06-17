`timescale 1ns / 1ps

module Control_Unit(CLK,
Reset,
Opcode,
ALU_Control,
ALU_Selector_A,
ALU_Selector_B,
BorN,
PC_Selector_Source,
Zero_Sign,
Reg_Selector,
PC_Write_And,
PC_Write_Or,
Reg_allow_Write,
Inst_Reg_Write,
Memo_allow_Write,
Memo_To_Reg_Selector,
Read_Reg_Selector);

input [5:0]Opcode;
input CLK,Reset;

 output	reg	[2:0] ALU_Control, ALU_Selector_A;
 output	reg	[1:0] PC_Selector_Source,ALU_Selector_B,BorN,Zero_Sign,Reg_Selector;
 output	reg	PC_Write_And,PC_Write_Or,Reg_allow_Write,Inst_Reg_Write,Memo_allow_Write,Memo_To_Reg_Selector,Read_Reg_Selector;
 reg [3:0]state, next_state;

//Defining The States
	parameter S0 = 4'b0000; 
	parameter S1 = 4'b0001; 
	parameter S2 = 4'b0010;
	parameter S3 = 4'b0011;
	parameter S4 = 4'b0100;
	parameter S5 = 4'b0101;
	parameter S6 = 4'b0110;
	parameter S7 = 4'b0111;
	parameter S8 = 4'b1000;
	parameter S9 = 4'b1001;  
	parameter S10 = 4'b1010; 
	parameter S11 = 4'b1011;
	parameter S12 = 4'b1100;
	parameter S13 = 4'b1101;
	parameter S14 = 4'b1110;



always @(posedge CLK)//Moving From state to the next
begin
	state <= next_state;
end


always @ (state or Reset)
begin

	if(Reset == 1'b1)//Reset back to Start
begin
	  next_state = S0;
	  PC_Selector_Source = 2'b00;
      ALU_Control = 3'b000;
      ALU_Selector_B = 2'b00;
      ALU_Selector_A = 3'b000;
      Reg_allow_Write = 1'b1;
      Reg_Selector = 1'b00;
      Inst_Reg_Write = 1'b0;
      Memo_To_Reg_Selector = 1'b0;
      Memo_allow_Write = 1'b0;
      PC_Write_Or = 1'b0;
      PC_Write_And = 1'b0;
	  BorN = 2'b00;
	  Read_Reg_Selector = 1'b0;
	  Zero_Sign = 2'b00;
end
	
else
 begin
		
	case(state)
	
		
		S0://First Step Fetching Instruction 
		begin 	
			ALU_Selector_A = 3'b000;
			Memo_allow_Write = 1'b0;
			Reg_allow_Write = 1'b0;
			PC_Write_Or = 1'b1;
			PC_Selector_Source = 2'b00;
			PC_Write_And = 1'b0;
			BorN = 2'b00;
			Inst_Reg_Write = 1'b1;
			ALU_Control = 3'b010;
			Memo_To_Reg_Selector = 1'b0;
			ALU_Selector_B = 2'b01;
			Reg_Selector = 1'b00;
			Read_Reg_Selector = 1'b0;
			Zero_Sign = 2'b00;
			next_state = S1;//Go To S1
		end
		
		
		S1://Instruction Decode: Defining Which State is next according to Its Type
		begin
			Inst_Reg_Write = 1'b0;
			PC_Write_Or = 1'b0;
			ALU_Selector_A = 3'b000;
			ALU_Selector_B = 2'b10;
			ALU_Control = 3'b010;
			Read_Reg_Selector = 1'b0;
			
			//J-Type: JUMP & JAL
			if(Opcode[5:4] == 2'b00)
				begin
					// jump-and-link instruction(JAL)
					if(Opcode [1:0] == 2'b11)
						begin
						ALU_Selector_B = 2'b01;
						next_state = S14;
						end
					//JUMP
					else
						next_state = S11;end
				
				
			//R-Type:MOV,NOT,ADD,SUB,OR,AND,XOR,SLT
			else if(Opcode[5:4] == 2'b01)
				begin
					Read_Reg_Selector = 1'b1;
					next_state = S6;
				end
			
			//Branch Type:BEQ,BNE,BLT,BLE
			else if(Opcode[5:4] == 2'b10)
				begin
					next_state = S10;
				end
			
			//I-Type:ADDI,SUBI,ORI,ANDI,XORI,SLTI,LI,LUI,LWI,SWI,LW,SW
			else if(Opcode[5:4] == 2'b11)
				begin
					//LWI,SWI,LI,LUI,SW,LW
					if(Opcode[3] == 1'b1)
					begin
						//SW
						if(Opcode [2:0] == 3'b110)
							next_state = S12;
						//LWI,SWI,LI,LUI,LW
						else
							next_state = S2;
					end
					
					//I-Type Logical or Arithmetic:ADDI,SUBI,ORI,ANDI,XORI,SLTI
					else
						next_state = S8;end
		end
		
///Now Begin Execution of States according to each Type
//I-type
		//Execution: LWI SWI LI LUI
		S2:
		begin
			//Load Immediate (LI)
			if(Opcode[2:0]	== 2'b001)
				begin
				ALU_Selector_A = 3'b010;
				ALU_Selector_B = 2'b10;
				ALU_Control = 3'b100;
				end
			//load word(LW)
			else if(Opcode[2:0] == 3'b101)
				begin
				ALU_Selector_A = 3'b011;
				ALU_Selector_B = 2'b00;
				ALU_Control = 3'b010;
				end
			//Load upper immediate(LUI)	
			else if(Opcode[1:0]	== 2'b10)
				begin
				ALU_Selector_A = 3'b001;
				ALU_Selector_B = 2'b10;
				ALU_Control = 3'b100;
				end
			//SWI & LWI
			else if(Opcode[1:0] == 2'b00 || Opcode[1:0] == 2'b11)
				begin
				ALU_Selector_A = 3'b010;
				ALU_Selector_B = 2'b10;
				ALU_Control = 3'b100;
				end
				
			if(Opcode[2:0]	== 3'b101)
				next_state = S3;
			
			//Next State for :LI,LUI,LWI,LW
			else if(Opcode[2] == 1'b0)
				next_state = S3;
				
			//Next State for: SWI
			else
				next_state = S5;
		end
		
//I-Type Continue 	
		//Execution: LWI/LI/LUI
		S3:
		begin
			if(Opcode [2:0]	== 3'b101)
				next_state = S4;
		
			//LI
			else if(Opcode[2:1] == 2'b00)
				begin
				Zero_Sign = 2'b01;
				next_state = S4;
				end
				
			//LWI/LUI	
			else
				begin
				Zero_Sign = 2'b10;
				next_state = S4;
				end
		end

//I-Type Continue 
		//LWI/LUI/LI 
		S4:
		begin
			if(Opcode [2:0] == 3'b101)
				begin
				Reg_Selector = 2'b00;
				Reg_allow_Write = 1'b1;
				Memo_To_Reg_Selector = 1'b1;
				next_state = S0;	
				end
		
			//LWI
			if(Opcode[1:0] == 2'b11)
				begin
				Reg_Selector = 2'b00;
				Reg_allow_Write = 1'b1;
				Memo_To_Reg_Selector = 1'b1;
				next_state = S0;
				end
			
			//LI/LUI
			else
				begin
				Reg_Selector = 2'b00;
				Reg_allow_Write = 1'b1;
				Memo_To_Reg_Selector = 1'b0;
				next_state = S0;
				end
		end
		
		//SWI
		S5:
		begin
			Memo_allow_Write = 1'b1;
			Zero_Sign = 2'b01;
			next_state = S0;
		end
			
			
//R-Type
		S6:
		begin    
			Read_Reg_Selector = 1'b0;
			ALU_Selector_A = 3'b001;
		    ALU_Selector_B = 2'b00;
		    next_state = S7;//R-Type Continue
			
			//MOV
			if(Opcode[2:0] == 3'b000)
				ALU_Control = 3'b000;
			
			//NOT
			else if(Opcode[2:0] == 3'b001)
				ALU_Control = 3'b001;
				
			//ADD	
			else if(Opcode[2:0] == 3'b010)
             ALU_Control = 3'b010;
			
			//SUB
			else if(Opcode[2:0] == 3'b011)
             ALU_Control = 3'b011;
			
			//OR
			else if(Opcode[2:0] == 3'b100)
             ALU_Control = 3'b100;
			
			//AND
			else if(Opcode[2:0] == 3'b101)
             ALU_Control = 3'b101;
			
			//XOR
			else if(Opcode[2:0] == 3'b110)
             ALU_Control = 3'b110;
			
			//SLT
			else if(Opcode[2:0] == 3'b111)
             ALU_Control = 3'b111;
		end
	

//R-Type Continue
		S7:
			begin
			Reg_Selector = 2'b00;
			Reg_allow_Write = 1'b1;
			Memo_To_Reg_Selector = 1'b0;
			next_state = S0;
			end
		
//I-Type Continue for Logical or Arithmetic
		S8:
		begin
			
			//ADDI
			if(Opcode[2:0] == 3'b010)
				begin
				ALU_Selector_A = 3'b100;
				ALU_Selector_B = 2'b10;
				ALU_Control = 3'b010;
				Zero_Sign = 2'b00;
				end
			
			//SUBI
			else if(Opcode[2:0] == 3'b011)
				begin
				ALU_Selector_A = 3'b011; //This Value is Wrong
				ALU_Selector_B = 2'b10;
				ALU_Control = 3'b100;
				Zero_Sign = 2'b00;
				end
			
			//ORI
			else if(Opcode[2:0] == 3'b100)
				begin
				ALU_Selector_A = 3'b011;
				ALU_Selector_B = 2'b10;
				ALU_Control = 3'b100;
				Zero_Sign = 2'b01;
				end
			
			//ANDI
			else if(Opcode[2:0] == 3'b101)
				begin
				ALU_Selector_A = 3'b100;
				ALU_Selector_B = 2'b10;
				ALU_Control = 3'b101;
				Zero_Sign = 2'b01;
				end
			
			//XORI
			else if(Opcode[2:0] == 3'b0110)
				begin
				ALU_Selector_A = 3'b100;
				ALU_Selector_B = 2'b10;
				ALU_Control = 3'b110;
				Zero_Sign = 2'b01;
				end
				
			//SLTI
			else if(Opcode[2:0] == 3'b111)
				begin
				ALU_Selector_A = 3'b100;
				ALU_Selector_B = 2'b10;
				ALU_Control = 3'b111;
				Zero_Sign = 2'b00;
				end
		next_state = S9;
		end

		//Finishing I-Type 
		S9:
		begin
			Reg_allow_Write = 1'b1;
			Reg_Selector = 2'b00;
			Memo_To_Reg_Selector = 1'b0;
			next_state = S0;
		end
	
		
		S10:
		begin
		//PC Write for Branch-Type
			PC_Selector_Source = 2'b01;
			PC_Write_And = 1'b1;
			ALU_Selector_A = 3'b001;
			ALU_Selector_B = 2'b00;
			Zero_Sign = 2'b00;
			next_state = S0;
			
			//BEQ
			if(Opcode[3:0] == 4'b0000)
				begin
				ALU_Control = 3'b011;
				BorN = 2'b00;
				end
				
			//BNE
			else if(Opcode[3:0] == 4'b0001)
				begin
				ALU_Control = 3'b011;
				BorN = 2'b01;
				end
			
			//branch if greater than(BLT)
			else if(Opcode[3:0] == 4'b0010)
				begin
				ALU_Control = 3'b111;
				BorN = 2'b10;
				end
			
			//Branch on Less than or Equal(BLE)
			else if(Opcode[3:0] == 4'b0011)
				begin
				ALU_Control = 3'b111;
				BorN = 2'b11;
				end
		end
			
			
		//JUMP & NOOP
		S11:
		begin
			
			//NOOP
			if(Opcode[3:0] == 0000)
				next_state = S0;
				
			//JUMP
			else
				begin
					PC_Selector_Source = 2'b10;
					PC_Write_Or = 1'b1;
					next_state = S0;
				end
		end
		
		
		S12://SW
		begin
			ALU_Selector_A = 3'b001;
			ALU_Selector_B = 2'b10;
			ALU_Control = 3'b010;
			Zero_Sign = 2'b00;
			next_state = S13;
		end
		
		S13://SW
		begin
			Memo_allow_Write = 1'b1;
			next_state = S0;
		end
		
		S14://JAL
		begin
			PC_Selector_Source = 2'b10;
			PC_Write_Or = 1'b1;
			Reg_Selector = 2'b10;
			Memo_To_Reg_Selector = 1'b0;
			Reg_allow_Write = 1'b1;
			next_state = S0;
		end
			
	endcase
	end
end


endmodule
 


