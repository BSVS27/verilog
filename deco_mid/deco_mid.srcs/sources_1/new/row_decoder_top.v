`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2019 03:30:22 PM
// Design Name: 
// Module Name: row_decoder_top
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


module row_decoder_top(EN,Y_dec,Y_blo,Y);
parameter SIZE=0;
input wire EN;
input wire [63:0]Y_dec;
input wire [SIZE-1:0]Y_blo; //Esto va a variar entre 2 o 4 entradas
output wire [SIZE*64-1:0]Y;

genvar i;
for(i=0;i<SIZE;i=i+1)begin
    row_decoder inst_row_decoder(.EN(EN),.Y_dec(Y_dec),.Y_blo(Y_blo[i]),.Y(Y[64*(i+1)-1:64*i]));
end

endmodule











