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


module FF #(parameter m=5)(CLK,A,Y);
input wire CLK;
input wire [m-1:0] A;
output reg [m-1:0] Y;

always @(posedge CLK) begin
    Y <= A;
end
endmodule
