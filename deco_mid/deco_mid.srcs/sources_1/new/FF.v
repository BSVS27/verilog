`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2019 01:21:49 AM
// Design Name: 
// Module Name: FF
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


module FF (clk,A,Y);
input wire clk;
input wire A;
output reg Y;

always @(posedge clk) begin
    Y <= A;
end
endmodule
