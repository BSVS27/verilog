`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2019 10:44:13 PM
// Design Name: 
// Module Name: TOP
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
module TOP #(SIZE=8) (clk,A,EN,Y); //SIZE es el parámetro que define el número de entradas que se quiere que tenga el deco

localparam mod = SIZE % 2; //Para saber si es par o impar el número de entradas

input wire clk,EN;
input wire [SIZE-1:0]A;
output wire [(2**SIZE)-1:0]Y;

wire [SIZE-1:0]A0;

FF_top #(.SIZE(SIZE)) inst_FF_top(.clk(clk),.A(A),.Y(A0));

if(SIZE <= 6) begin //Para decodificadores de 6 o menos entradas

    wire [63:0]Y0;
    decoder_top #(.SIZE(SIZE),.mod(mod)) inst_decoder_top(.A(A0[5:0]),.Y(Y0)); //Decodificador optimizado
    Enable_2 #(.SIZE(SIZE)) inst_Enable(.A(Y0),.EN(EN),.Y(Y)); //Etapa de enable
    
end else begin //Para decodificadores de más de 6 entradas

    localparam mod1 = (SIZE-6) % 2; //Para saber si es par o impar el número de entradas

    wire [63:0]Y0; //Salidas del deco de 64 
    wire [(2**(SIZE-6))-1:0] Y1; //Salidas del otro deco
    
    decoder_top #(.SIZE(6),.mod(0)) inst_decoder_64(.A(A0[5:0]),.Y(Y0));//Deco 64
    decoder_top #(.SIZE(SIZE-6),.mod(mod1)) inst_decoder_top(.A(A0[SIZE-1:6]),.Y(Y1));//Otro deco
    
    genvar j;
    for(j=0;j<(2**(SIZE-6));j=j+1) begin
        row_decoder inst_row_decoder(.EN(EN),.Y_dec(Y0),.Y_blo(Y1[j]),.Y(Y[64*(j+1)-1:64*j])); //Deco de salida con enable
    end
    
end 
endmodule
