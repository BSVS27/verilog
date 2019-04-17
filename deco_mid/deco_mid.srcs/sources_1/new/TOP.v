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
module TOP #(SIZE=8, SIZE_word=32) (clk,A,EN,Y);
localparam Cout=(3.22)*SIZE_word;
localparam Cin=13;
localparam N=SIZE+2; //Etapas para dimensionar
localparam B=2**(N-3); //Esfuerzo de ramificación
localparam mod = SIZE % 2; //Para saber si es par o impar el número de entradas

input wire clk,EN;
input wire [SIZE-1:0]A;
output wire [(2**SIZE)-1:0]Y;

//wire [(2**SIZE)-1:0]Y0;
wire [SIZE-1:0]A0;



localparam G=((SIZE+1)/2)*(4/3)+((SIZE-1)/2)*(5/3);
localparam F=(G)*(Cout/Cin)*(B);  
/*
if(mod)begin    
    localparam G=((SIZE+1)/2)*(4/3)+((SIZE-1)/2)*(5/3);
    localparam F=(G)*(Cout/Cin)*(B);     
    
    //Flip_Flop de entrada
    FF_top #(.SIZE(SIZE)) inst_FF_top(.clk(clk),.A(A),.Y(A0));
            
    //Decoder_Optimizado
    decoder_top #(.SIZE(SIZE),.Cin(Cin),.Cout(Cout),.N(N),.B(B),.F(F),.G(G),.mod(mod)) inst_decoder_top(.A(A0),.Y(Y0));
            
    //Enable de salida
    Enable_2 #(.SIZE(SIZE)) inst_Enable_2(.A(Y0),.EN(EN),.Y(Y));
    
end else begin
    localparam G=(SIZE/2)*((5/3)+(4/3));
    localparam F=(G)*(Cout/Cin)*(B); 
    
    //Flip_Flop de entrada
    FF_top #(.SIZE(SIZE)) inst_FF_top(.clk(clk),.A(A),.Y(A0));
            
    //Decoder_Optimizado
    decoder_top #(.SIZE(SIZE),.Cin(Cin),.Cout(Cout),.N(N),.B(B),.F(F),.G(G),.mod(mod)) inst_decoder_top(.A(A0),.Y(Y0));
            
    //Enable de salida
    Enable_2 #(.SIZE(SIZE)) inst_Enable_2(.A(Y0),.EN(EN),.Y(Y));  
    
end
*/
wire [63:0]Y0;

if(SIZE <= 6) begin
    FF_top #(.SIZE(SIZE)) inst_FF_top(.clk(clk),.A(A),.Y(A0));
    decoder_top #(.SIZE(SIZE),.Cin(Cin),.Cout(Cout),.N(N),.B(B),.F(F),.G(G),.mod(mod)) inst_decoder_top(.A(A0),.Y(Y0));
    Enable_2 #(.SIZE(SIZE)) inst_Enable_2(.A(Y0),.EN(EN),.Y(Y));
end
else if(SIZE == 7) begin
    wire [1:0]cable;
    FF_top #(.SIZE(SIZE)) inst_FF_top(.clk(clk),.A(A),.Y(A0));
    decoder_top #(.SIZE(SIZE-1),.Cin(Cin),.Cout(Cout),.N(N),.B(B),.F(F),.G(G),.mod(mod)) inst_decoder_top(.A(A0[5:0]),.Y(Y0));
    Block_decoder_2 inst_block_decoder_2(.A(A0[6]),.Y(cable));
    row_decoder inst_row_decoder_1(.EN(EN),.Y_dec(Y0),.Y_blo(cable[0]),.Y(Y[63:0]));
    row_decoder inst_row_decoder_2(.EN(EN),.Y_dec(Y0),.Y_blo(cable[1]),.Y(Y[127:64]));
end 
else if(SIZE == 8) begin
    wire [3:0]cable;
    FF_top #(.SIZE(SIZE)) inst_FF_top(.clk(clk),.A(A),.Y(A0));
    decoder_top #(.SIZE(SIZE-2),.Cin(Cin),.Cout(Cout),.N(N),.B(B),.F(F),.G(G),.mod(mod)) inst_decoder_top(.A(A0[5:0]),.Y(Y0));
    Block_decoder_4 inst_block_decoder_4(.A(A0[7:6]),.Y(cable));
    row_decoder inst_row_decoder_1(.EN(EN),.Y_dec(Y0),.Y_blo(cable[0]),.Y(Y[63:0]));
    row_decoder inst_row_decoder_2(.EN(EN),.Y_dec(Y0),.Y_blo(cable[1]),.Y(Y[127:64]));
    row_decoder inst_row_decoder_3(.EN(EN),.Y_dec(Y0),.Y_blo(cable[2]),.Y(Y[191:128]));
    row_decoder inst_row_decoder_4(.EN(EN),.Y_dec(Y0),.Y_blo(cable[3]),.Y(Y[255:192]));
end
endmodule
