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
module decoder_top (A,Y);
parameter SIZE=0;
parameter Cin=0;
parameter Cout=0;
parameter N=0;
parameter B=0;
parameter F=0;
parameter G=0;
parameter mod=0;

localparam SIZE_out=2**SIZE; //Número de salidas
localparam SIZE_wire=(2**SIZE)-4; //Número de cables que ocupo para hacer interconecciones

input wire [SIZE-1:0] A;
output wire [SIZE_out-1:0] Y;

wire [SIZE_out+SIZE_wire-1:0] C; //WIRE para hacer las interconecciones

if(mod) begin //IMPAR ==> BASE_NAND;
    genvar e;
    for(e=1;e<SIZE;e=e+1) begin
        if(e==1)begin
            Base_NAND inst_base_nand(.A(A[1:0]),.Q(C[3:0]));
        end
        else begin
            if(e%2) begin //IMPAR ==> NNANDS / NANDS
                genvar a;
                for(a=1;a <= 2**(e-1);a=a+1) begin
                    if(a <= (2**(e-1))/2)begin //NNANDS
                        NNANDS inst_nnands(.A(A[e]),.B(C[((2**e)-1)+(a-1)*4:((2**e)-1)+(a-1)*4-3]),.Q(C[((2**(e+1))-1)+(a-1)*4:((2**(e+1))-1)+(a-1)*4-3]));
                    end
                    else begin //NANDS
                        NANDS inst_nands(.A(A[e]),.B(C[((2**e)-1)+((a-(2**(e-1))/2)-1)*4:((2**e)-1)+((a-(2**(e-1))/2)-1)*4-3]),.Q(C[((2**(e+1))-1)+(a-1)*4:((2**(e+1))-1)+(a-1)*4-3]));
                    end
                end
            end
            else begin //PAR ==> NORS / NNORS
                genvar b;
                for(b=1;b <= 2**(e-1);b=b+1) begin
                    if(b <= (2**(e-1))/2)begin //NORS
                        NORS inst_nors(.A(A[e]),.B(C[((2**e)-1)+(b-1)*4:((2**e)-1)+(b-1)*4-3]),.Q(C[((2**(e+1))-1)+(b-1)*4:((2**(e+1))-1)+(b-1)*4-3]));
                    end
                    else begin //NNORS
                        NNORS inst_nnors(.A(A[e]),.B(C[((2**e)-1)+((b-(2**(e-1))/2)-1)*4:((2**e)-1)+((b-(2**(e-1))/2)-1)*4-3]),.Q(C[((2**(e+1))-1)+(b-1)*4:((2**(e+1))-1)+(b-1)*4-3]));
                    end
                end
            end
        end
    end
end
////////////////////////////////////////////////////////////////////////////////////
else begin //PAR ==> BASE_NOR
    genvar e;
    for(e=1;e<SIZE;e=e+1) begin
        if(e==1)begin
            Base_NOR inst_base_nor(.A(A[1:0]),.Q(C[3:0]));
        end
        else begin
            if(e%2) begin //IMPAR ==> NORS / NNORS
                genvar a;
                for(a=1;a <= 2**(e-1);a=a+1) begin
                    if(a <= (2**(e-1))/2)begin //NORS
                        NORS inst_nors(.A(A[e]),.B(C[((2**e)-1)+(a-1)*4:((2**e)-1)+(a-1)*4-3]),.Q(C[((2**(e+1))-1)+(a-1)*4:((2**(e+1))-1)+(a-1)*4-3]));
                    end
                    else begin //NNORS
                        NNORS inst_nnors(.A(A[e]),.B(C[((2**e)-1)+((a-(2**(e-1))/2)-1)*4:((2**e)-1)+((a-(2**(e-1))/2)-1)*4-3]),.Q(C[((2**(e+1))-1)+(a-1)*4:((2**(e+1))-1)+(a-1)*4-3]));
                    end
                end
            end
            else begin //PAR ==> NNANDS / NANDS
                genvar b;
                for(b=1;b <= 2**(e-1);b=b+1) begin
                    if(b <= (2**(e-1))/2)begin //NNANDS
                        NNANDS inst_nnands(.A(A[e]),.B(C[((2**e)-1)+(b-1)*4:((2**e)-1)+(b-1)*4-3]),.Q(C[((2**(e+1))-1)+(b-1)*4:((2**(e+1))-1)+(b-1)*4-3]));
                    end
                    else begin //NANDS
                        NANDS inst_nands(.A(A[e]),.B(C[((2**e)-1)+((b-(2**(e-1))/2)-1)*4:((2**e)-1)+((b-(2**(e-1))/2)-1)*4-3]),.Q(C[((2**(e+1))-1)+(b-1)*4:((2**(e+1))-1)+(b-1)*4-3]));
                    end
                end
            end
        end
    end
end
assign Y[SIZE_out-1:0]=C[SIZE_wire+SIZE_out-1:SIZE_wire];
endmodule