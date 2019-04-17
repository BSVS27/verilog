`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2019 10:25:51 PM
// Design Name: 
// Module Name: Block_decoder_8
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


module Block_decoder_8(A,B,Y);
input wire [1:0] A;
input wire B;
output wire [3:0] Y;

wire [7:0] C;

Base_NOR inst_base_nor_block_decoder_4(.A(A[1:0]),.Q(C[3:0]));

NANDS inst_nands(.A(B),.B(C[3:0]),.Q(C[7:4]));

INV inst_inv_block_decoder_8_1(.A(C[4]),.Q(Y[0]));
INV inst_inv_block_decoder_8_2(.A(C[5]),.Q(Y[1]));
INV inst_inv_block_decoder_8_3(.A(C[6]),.Q(Y[2]));
INV inst_inv_block_decoder_8_4(.A(C[7]),.Q(Y[3]));

endmodule
