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
output reg [3:0] Q;

always @(*) begin
    Q[0] <= !(A[1] | A[0]);
    Q[1] <= !(A[1] | !A[0]);
    Q[2] <= !(!A[1] | A[0]);
    Q[3] <= !(!A[1] | !A[0]);
end
endmodule