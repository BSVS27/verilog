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
module TOP #(SIZE=3, Cout=108) (clk,A,EN,Y);
localparam Cin=13;
localparam N=SIZE+2; //Etapas para dimensionar
localparam B=2**(N-3); //Esfuerzo de ramificación
localparam mod = SIZE % 2; //Para saber si es par o impar el número de entradas

input wire clk,EN;
input wire [SIZE-1:0]A;
output wire [(2**SIZE)-1:0]Y;

wire [(2**SIZE)-1:0]Y0;
wire [SIZE-1:0]A0;
if(mod)begin
    localparam G=((SIZE+1)/2)*(4/3)+((SIZE-1)/2)*(5/3);
    localparam F=(G)*(Cout/Cin)*(B);     
    //Flip_Flop de entrada
    FF_top #(.SIZE(SIZE)) inst_FF_top(.clk(clk),.A(A),.Y(A0));
            
    //Decoder_Optimizado
    decoder_top #(.SIZE(SIZE),.Cin(Cin),.Cout(Cout),.N(N),.B(B),.F(F),.G(G)) inst_decoder_top(.A(A0),.Y(Y0));
            
    //Enable de salida
    Enable_2 #(.SIZE(SIZE)) inst_Enable_2(.A(Y0),.EN(EN),.Y(Y));
    
end else begin
    localparam G=(SIZE/2)*((5/3)+(4/3));
    localparam F=(G)*(Cout/Cin)*(B); 
    //Flip_Flop de entrada
    FF_top #(.SIZE(SIZE)) inst_FF_top(.clk(clk),.A(A),.Y(A0));
            
    //Decoder_Optimizado
    decoder_top #(.SIZE(SIZE),.Cin(Cin),.Cout(Cout),.N(N),.B(B),.F(F),.G(G)) inst_decoder_top(.A(A0),.Y(Y0));
            
    //Enable de salida
    Enable_2 #(.SIZE(SIZE)) inst_Enable_2(.A(Y0),.EN(EN),.Y(Y));  
    
end
endmodule
