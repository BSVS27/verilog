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

wire [SIZE-1:0]A0;

localparam G=((SIZE+1)/2)*(4/3)+((SIZE-1)/2)*(5/3);
localparam F=(G)*(Cout/Cin)*(B); 

/* if(mod)begin    
    localparam G=((SIZE+1)/2)*(4/3)+((SIZE-1)/2)*(5/3);
    localparam F=(G)*(Cout/Cin)*(B);     
    
end else begin
    localparam G=(SIZE/2)*((5/3)+(4/3));
    localparam F=(G)*(Cout/Cin)*(B);  
end */

FF_top #(.SIZE(SIZE)) inst_FF_top(.clk(clk),.A(A),.Y(A0));

if(SIZE <= 6) begin
    wire [63:0]Y0;
    decoder_top #(.SIZE(SIZE),.Cin(Cin),.Cout(Cout),.N(N),.B(B),.F(F),.G(G),.mod(mod)) inst_decoder_top(.A(A0[5:0]),.Y(Y0));
    Enable_2 #(.SIZE(SIZE)) inst_Enable(.A(Y0),.EN(EN),.Y(Y));
end
else if(SIZE == 7) begin
    wire [63:0]Y0;
    wire [1:0]cable;
    decoder_top #(.SIZE(6),.Cin(Cin),.Cout(Cout),.N(N),.B(B),.F(F),.G(G),.mod(0)) inst_decoder_top(.A(A0[5:0]),.Y(Y0));
    Block_decoder #(.SIZE(1),.SIZE2(0)) inst_block_decoder(.A(A0[6]),.B(),.Y(cable));
    row_decoder_top #(.SIZE(2)) inst_row_decoder(.EN(EN),.Y_dec(Y0),.Y_blo(cable),.Y(Y));
end 
else if(SIZE == 8) begin
    wire [64*(SIZE-7)-1:0]Y0;
    wire [4*(SIZE-7)-1:0]cable;
    decoder_top #(.SIZE(6),.Cin(Cin),.Cout(Cout),.N(N),.B(B),.F(F),.G(G),.mod(0)) inst_decoder_top(.A(A0[5:0]),.Y(Y0));
    Block_decoder #(.SIZE(2),.SIZE2(1)) inst_block_decoder(.A(A0[7:6]),.B(),.Y(cable));
    row_decoder_top #(.SIZE(4)) inst_row_decoder_top(.EN(EN),.Y_dec(Y0),.Y_blo(cable),.Y(Y));
end
else if(SIZE==9) begin
    wire [64*(SIZE-7)-1:0]Y0;
    wire [4*(SIZE-7)-1:0]cable;
    wire [2**(SIZE-8)-1:0]Y1;
    decoder_uno inst_decoder_uno_TOP(.A(A0[8]),.Y(Y1));
    
    genvar i;
    for(i=0;i<(2**(SIZE-8));i=i+1) begin
        decoder_top #(.SIZE(6),.Cin(Cin),.Cout(Cout),.N(N),.B(B),.F(F),.G(G),.mod(0)) inst_decoder_top(.A(A0[5:0]),.Y(Y0[64*(i+1)-1:64*i]));
        Block_decoder #(.SIZE(2),.SIZE2(2)) inst_block_decoder(.A(A0[7:6]),.B(Y1[i]),.Y(cable[4*(i+1)-1:4*i]));
        row_decoder_top #(.SIZE(4)) inst_row_decoder_top(.EN(EN),.Y_dec(Y0[64*(i+1)-1:64*i]),.Y_blo(cable[4*(i+1)-1:4*i]),.Y(Y[64*(i+1)-1:64*i]));
    end
end else begin
    wire [64*(2**(SIZE-8))-1:0]Y0;
    wire [4*(2**(SIZE-8))-1:0]cable;
    wire [2**(SIZE-8)-1:0]Y1;
    localparam mod1=(SIZE-8)%2;
    decoder_top #(.SIZE(SIZE-8),.Cin(Cin),.Cout(Cout),.N(N),.B(B),.F(F),.G(G),.mod(mod1)) inst_decoder_top_TOP(.A(A0[SIZE-1:8]),.Y(Y1));
    
    genvar i;
    for(i=0;i<(2**(SIZE-8));i=i+1) begin
        decoder_top #(.SIZE(6),.Cin(Cin),.Cout(Cout),.N(N),.B(B),.F(F),.G(G),.mod(0)) inst_decoder_top(.A(A0[5:0]),.Y(Y0[64*(i+1)-1:64*i]));
        Block_decoder #(.SIZE(2),.SIZE2(2)) inst_block_decoder(.A(A0[7:6]),.B(Y1[i]),.Y(cable[4*(i+1)-1:4*i]));
        row_decoder_top #(.SIZE(4)) inst_row_decoder_top(.EN(EN),.Y_dec(Y0[64*(i+1)-1:64*i]),.Y_blo(cable[4*(i+1)-1:4*i]),.Y(Y[64*(i+1)-1:64*i]));
    end
end
endmodule
