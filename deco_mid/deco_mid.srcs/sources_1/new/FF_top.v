`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2019 12:15:22 AM
// Design Name: 
// Module Name: FF_top
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


module FF_top (clk,A,Y);
parameter SIZE=0;
input wire clk;
input wire [SIZE-1:0] A;
output wire [SIZE-1:0] Y;

genvar t;
for(t=0;t<SIZE;t=t+1)begin
    FF inst_ff(.clk(clk),.A(A[t]),.Y(Y[t]));
end
endmodule
