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


module decoder_top #(parameter SIZE=3)(CLK,A,Y);
localparam SIZE_out=2**SIZE;
localparam SIZE_wire=(2**SIZE)-4;
input wire CLK;
input wire [SIZE-1:0] A;
output reg [SIZE_out-1:0] Y;

wire [SIZE_wire-1:0] C;
wire [SIZE-1:0] A1;
localparam mod = SIZE % 2; //Para saber si es par o impar el número de entradas

FF inst_ff(.CLK(CLK),.A(A),.Y(A1));

if(mod) begin //IMPAR ==> BASE_NAND
    genvar e;
    for(e=1;e<SIZE;e=e+1) begin
        if(e==1)begin
            Base_NAND inst_base_nand(.A(),.Q());
        end
        else begin
            if(e%2) begin //IMPAR ==> NNANDS / NANDS
                genvar a;
                for(a=1;a <= 2**(e-1);a=a+1) begin
                    if(a <= (2**(e-1))/2)begin //NNANDS
                        NNANDS inst_nnands(.A(),.B(),.Q());
                    end
                    else begin //NANDS
                        NANDS inst_nands(.A(),.B(),.Q());
                    end
                end
            end
            else begin //PAR ==> NORS / NNORS
                genvar b;
                for(b=1;b <= 2**(e-1);b=b+1) begin
                    if(b <= (2**(e-1))/2)begin //NORS
                        NORS inst_nors(.A(),.B(),.Q());
                    end
                    else begin //NNORS
                        NNORS inst_nnors(.A(),.B(),.Q());
                    end
                end
            end
        end
    end
end
else begin //PAR ==> BASE_NOR
    genvar e;
    for(e=1;e<SIZE;e=e+1) begin
        if(e==1)begin
            Base_NOR inst_base_nor(.A(),.Q());
        end
        else begin
            if(e%2) begin //IMPAR ==> NORS / NNORS
                genvar a;
                for(a=1;a <= 2**(e-1);a=a+1) begin
                    if(a <= (2**(e-1))/2)begin //NORS
                        NORS inst_nors(.A(),.B(),.Q());
                    end
                    else begin //NNORS
                        NNORS inst_nnors(.A(),.B(),.Q());
                    end
                end
            end
            else begin //PAR ==> NNANDS / NANDS
                genvar b;
                for(b=1;b <= 2**(e-1);b=b+1) begin
                    if(b <= (2**(e-1))/2)begin //NNANDS
                        NNANDS inst_nnands(.A(),.B(),.Q());
                    end
                    else begin //NANDS
                        NANDS inst_nands(.A(),.B(),.Q());
                    end
                end
            end
        end
    end
end
endmodule










