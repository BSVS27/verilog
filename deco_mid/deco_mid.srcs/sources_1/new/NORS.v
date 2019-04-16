`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2019 06:01:40 PM
// Design Name: 
// Module Name: NNANDS
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


module NORS(A,B,Q);
input wire A;
input wire [3:0] B;
output wire [3:0] Q;


assign Q[0] = !(B[0] | A);
assign Q[1] = !(B[1] | A);
assign Q[2] = !(B[2] | A);
assign Q[3] = !(B[3] | A);

endmodule