`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2019 05:44:43 PM
// Design Name: 
// Module Name: decoder_uno
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


module decoder_uno(A,Y);
input wire A;
output wire [1:0]Y;

wire inv_inv;
//Y0
INV inst_inv_block_decoderY0(.A(A),.Q(Y[0]));
//Y1
INV inst_inv_block_decoderY1_1(.A(A),.Q(inv_inv));
INV inst_inv_block_decoderY1_2(.A(inv_inv),.Q(Y[1]));
endmodule
