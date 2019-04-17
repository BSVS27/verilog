`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2019 10:42:08 PM
// Design Name: 
// Module Name: row_decoder
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


module row_decoder(EN,Y_dec,Y_blo,Y);
input wire [63:0] Y_dec;
input wire Y_blo,EN;
output wire [63:0] Y;

wire [63:0] nand_inv; //Salidas de la NAND al Inversor

genvar j;
for(j=0;j<64;j=j+1)begin
    NAND_3 inst_nand_3(.A(Y_dec[j]),.B(EN),.C(Y_blo),.Q(nand_inv[j]));
    INV inst_inv(.A(nand_inv[j]),.Q(Y[j]));
end
endmodule
