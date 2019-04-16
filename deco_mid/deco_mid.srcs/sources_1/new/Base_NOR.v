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


module Base_NOR(A,Q);
input wire [1:0] A;
output wire [3:0] Q;

assign Q[0] = !(A[1] | A[0]);
assign Q[1] = !(A[1] | !A[0]);
assign Q[2] = !(!A[1] | A[0]);
assign Q[3] = !(!A[1] | !A[0]);

endmodule