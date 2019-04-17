`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2019 10:25:02 PM
// Design Name: 
// Module Name: Block_decoder_4
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


module Block_decoder_4(A,Y);
input wire [1:0] A;
output wire [3:0] Y;

Base_NOR inst_base_nor_block_decoder_4(.A(A[1:0]),.Q(Y[3:0]));

endmodule
