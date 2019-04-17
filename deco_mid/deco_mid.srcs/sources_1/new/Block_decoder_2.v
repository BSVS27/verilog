`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2019 10:15:07 PM
// Design Name: 
// Module Name: Block_decoder_2
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


module Block_decoder_2(A,Y);
input wire A;
output wire [1:0] Y;

wire [2:0] inv_inv;
//Y0
INV inst_inv_block_decoderY0_2_1(.A(A),.Q(inv_inv[0]));
INV inst_inv_block_decoderY0_2_2(.A(inv_inv[0]),.Q(inv_inv[1]));
INV inst_inv_block_decoderY0_2_3(.A(inv_inv[1]),.Q(Y[0]));
//Y1
INV inst_inv_block_decoderY1_2_1(.A(A),.Q(inv_inv[2]));
INV inst_inv_block_decoderY1_2_3(.A(inv_inv[2]),.Q(Y[1]));
endmodule
