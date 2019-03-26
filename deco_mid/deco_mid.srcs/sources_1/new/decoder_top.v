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


module decoder_top (CLK,A,EN,Y);
parameter SIZE=5;
parameter Cin=13;
parameter Cout=108;

localparam SIZE_out=2**SIZE; //Número de salidas
localparam SIZE_wire=(2**SIZE)-4; //Número de cables que ocupo para hacer interconecciones
localparam mod = SIZE % 2; //Para saber si es par o impar el número de entradas
localparam N=SIZE+2; //Etapas para dimensionar
localparam B=2**(N-3); //Esfuerzo de ramificación
if(mod)begin
    localparam G=((SIZE+1)/2)*(4/3)+((SIZE-1)/2)*(5/3);
    localparam F=(G)*(Cout/Cin)*(B);
end else begin
    localparam G=(SIZE/2)*((5/3)+(4/3));
    localparam F=(G)*(Cout/Cin)*(B);
end

input wire CLK,EN;
input wire [SIZE-1:0] A;
output wire [SIZE_out-1:0] Y;

wire [SIZE_out+SIZE_wire-1:0] C; //WIRE para hacer las interconecciones
wire [SIZE-1:0] A1; //Salidas de los FFs iniciales
wire [SIZE_out-1:0] nand_inv; //Salidas de la NAND al Inversor



//Flip-flop_Entrada
genvar t;
for(t=0;t<SIZE;t=t+1)begin
    FF inst_ff(.CLK(CLK),.A(A[t]),.Y(A1[t]));
end

if(mod) begin //IMPAR ==> BASE_NAND;
    genvar e;
    for(e=1;e<SIZE;e=e+1) begin
        if(e==1)begin
            Base_NAND inst_base_nand(.A(A1[1:0]),.Q(C[3:0]));
        end
        else begin
            if(e%2) begin //IMPAR ==> NNANDS / NANDS
                genvar a;
                for(a=1;a <= 2**(e-1);a=a+1) begin
                    if(a <= (2**(e-1))/2)begin //NNANDS
                        NNANDS inst_nnands(.A(A1[e]),.B(C[((2**e)-1)+(a-1)*4:((2**e)-1)+(a-1)*4-3]),.Q(C[((2**(e+1))-1)+(a-1)*4:((2**(e+1))-1)+(a-1)*4-3]));
                    end
                    else begin //NANDS
                        NANDS inst_nands(.A(A1[e]),.B(C[((2**e)-1)+((a-(2**(e-1))/2)-1)*4:((2**e)-1)+((a-(2**(e-1))/2)-1)*4-3]),.Q(C[((2**(e+1))-1)+(a-1)*4:((2**(e+1))-1)+(a-1)*4-3]));
                    end
                end
            end
            else begin //PAR ==> NORS / NNORS
                genvar b;
                for(b=1;b <= 2**(e-1);b=b+1) begin
                    if(b <= (2**(e-1))/2)begin //NORS
                        NORS inst_nors(.A(A1[e]),.B(C[((2**e)-1)+(b-1)*4:((2**e)-1)+(b-1)*4-3]),.Q(C[((2**(e+1))-1)+(b-1)*4:((2**(e+1))-1)+(b-1)*4-3]));
                    end
                    else begin //NNORS
                        NNORS inst_nnors(.A(A1[e]),.B(C[((2**e)-1)+((b-(2**(e-1))/2)-1)*4:((2**e)-1)+((b-(2**(e-1))/2)-1)*4-3]),.Q(C[((2**(e+1))-1)+(b-1)*4:((2**(e+1))-1)+(b-1)*4-3]));
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
            Base_NOR inst_base_nor(.A(A1[1:0]),.Q(C[3:0]));
        end
        else begin
            if(e%2) begin //IMPAR ==> NORS / NNORS
                genvar a;
                for(a=1;a <= 2**(e-1);a=a+1) begin
                    if(a <= (2**(e-1))/2)begin //NORS
                        NORS inst_nors(.A(A1[e]),.B(C[((2**e)-1)+(a-1)*4:((2**e)-1)+(a-1)*4-3]),.Q(C[((2**(e+1))-1)+(a-1)*4:((2**(e+1))-1)+(a-1)*4-3]));
                    end
                    else begin //NNORS
                        NNORS inst_nnors(.A(A1[e]),.B(C[((2**e)-1)+((a-(2**(e-1))/2)-1)*4:((2**e)-1)+((a-(2**(e-1))/2)-1)*4-3]),.Q(C[((2**(e+1))-1)+(a-1)*4:((2**(e+1))-1)+(a-1)*4-3]));
                    end
                end
            end
            else begin //PAR ==> NNANDS / NANDS
                genvar b;
                for(b=1;b <= 2**(e-1);b=b+1) begin
                    if(b <= (2**(e-1))/2)begin //NNANDS
                        NNANDS inst_nnands(.A(A1[e]),.B(C[((2**e)-1)+(b-1)*4:((2**e)-1)+(b-1)*4-3]),.Q(C[((2**(e+1))-1)+(b-1)*4:((2**(e+1))-1)+(b-1)*4-3]));
                    end
                    else begin //NANDS
                        NANDS inst_nands(.A(A1[e]),.B(C[((2**e)-1)+((b-(2**(e-1))/2)-1)*4:((2**e)-1)+((b-(2**(e-1))/2)-1)*4-3]),.Q(C[((2**(e+1))-1)+(b-1)*4:((2**(e+1))-1)+(b-1)*4-3]));
                    end
                end
            end
        end
    end
end
//PARTE DEL ENABLE
genvar j;
for(j=0;j<2**SIZE;j=j+1)begin
    NAND inst_nand(.A(C[SIZE_wire+j]),.B(EN),.Q(nand_inv[j]));
    INV inst_inv(.A(nand_inv[j]),.Q(Y[j]));
end
endmodule