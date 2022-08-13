`timescale 1ns/1ps
module testbench();

    reg[31:0] a,b;
    reg ALUS;
    wire[31:0] ALURes;
    wire SLT,ZERO,SLTU;

    ALU ALU(
        .ALUS(ALUS),
        .a(a),
        .b(b),
        .ALURes(ALURes),
        .SLT(SLT),
        .ZERO(ZERO),
        .SLTU(SLTU)
    );

    initial begin
        a=0;
        b=0;
        ALUS=0;
        #10;
        ALUS=1;
        a=5;
        b=7;
        #10;
        a=1127;
        b=56;
        #10;
        a=12323;
        b=12323;
        #10;
        a=-2147483647;
        b=1;
        #10;
        a=7;
        b=-5;
        #10;

    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0,testbench);
    end

endmodule