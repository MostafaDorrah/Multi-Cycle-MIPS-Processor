`timescale 1ns / 1ps

module register_file( CLK,Read_Register_1,Read_Register_2,Write_Register,Write_Date,Read_Data_1,Read_Data_2,Control_RegWrite);
    input wire CLK,Control_RegWrite;
    input wire [4:0] Read_Register_1,Read_Register_2,Write_Register;
    input wire [31:0] Write_Date;
    output reg [31:0] Read_Data_1,Read_Data_2;
    reg [31:0] RF_writer [31:0];
    


always @(Read_Register_1,RF_writer[Read_Register_1]) 
begin
    if (Read_Register_1 == 0) 
        Read_Data_1 = 0;
    else 
        Read_Data_1 = RF_writer[Read_Register_1];    
end

always @(Read_Register_2,RF_writer[Read_Register_2]) 
begin
    if (Read_Register_2 == 0) 
        Read_Data_2 = 0;
    else
        Read_Data_2 = RF_writer[Read_Register_2];
end

always@ (posedge CLK) 
begin
    if(Control_RegWrite == 1'b1) 
            RF_writer[Write_Register]= Write_Date;//Right new values in either Read_Register_1 or Read_Register_2   
end

endmodule




