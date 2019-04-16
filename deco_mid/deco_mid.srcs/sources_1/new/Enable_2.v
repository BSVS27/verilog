`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2019 10:54:51 PM
// Design Name: 
// Module Name: Enable_2
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
module Enable_2 (A,EN,Y);
parameter SIZE=0;
input wire [(2**SIZE)-1:0] A;
input wire EN;
output wire [(2**SIZE)-1:0] Y;

wire [(2**SIZE)-1:0] nand_inv; //Salidas de la NAND al Inversor

genvar j;
for(j=0;j<2**SIZE;j=j+1)begin
    NAND inst_nand(.A(A[j]),.B(EN),.Q(nand_inv[j]));
    INV inst_inv(.A(nand_inv[j]),.Q(Y[j]));
end
endmodule
