`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2019 10:11:59 PM
// Design Name: 
// Module Name: Block_decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Block_decoder(A,B,Y);
parameter SIZE=0; //1 / 2
parameter SIZE2=0; //0 / 1 / 2 .....
input wire [SIZE-1:0]A;
input wire B;
output wire [2*SIZE-1:0]Y;

if(SIZE2==0) begin
    decoder_uno inst_decoder_uno(.A(A),.Y(Y));
end 
else if(SIZE2==1) begin
    decoder_top #(.SIZE(2),.mod(0)) inst_decoder_top(.A(A),.Y(Y));
end 
else begin
    wire [3:0] C;
    decoder_top #(.SIZE(2),.mod(0)) inst_decoder_top(.A(A),.Y(C));
    Enable_2 #(.SIZE(2)) inst_Enable(.A(C),.EN(B),.Y(Y));
end
endmodule
