`timescale 1ns/1ps
module testbench();

    reg BE,SLT,SLTU,ZERO;
    reg[2:0] BS;
    wire PCS;

    JumpCtr jumpctr(
        .BE(BE),
        .SLT(SLT),
        .ZERO(ZERO),
        .SLTU(SLTU),
        .BS(BS),
        .PCS(PCS)
    );

    initial begin
        BE=0;
        SLT=0;
        SLTU=0;
        ZERO=0;
        BS=3'b000;
        #10;
        BE=1;
        BS=3'b000;
        ZERO=1;
        SLT=1;
        SLTU=1;
        #10;
        BE=1;
        BS=3'b000;
        ZERO=0;
        SLT=1;
        SLTU=1;
        #10;
        BE=1;
        BS=3'b001;
        ZERO=1;
        SLT=1;
        SLTU=1;
        #10;
        BE=1;
        BS=3'b001;
        ZERO=0;
        SLT=1;
        SLTU=1;
        #10;
        BE=1;
        BS=3'b010;
        ZERO=0;
        SLT=0;
        SLTU=1;
        #10;
        BE=1;
        BS=3'b010;
        ZERO=0;
        SLT=1;
        SLTU=1;
        #10;
        BE=1;
        BS=3'b011;
        ZERO=0;
        SLT=1;
        SLTU=1;
        #10;
        BE=1;
        BS=3'b011;
        ZERO=0;
        SLT=0;
        SLTU=1;
        #10;
        BE=1;
        BS=3'b110;
        ZERO=0;
        SLT=0;
        SLTU=0;
        #10;
        BE=1;
        BS=3'b110;
        ZERO=0;
        SLT=0;
        SLTU=1;
        #10;
        BE=1;
        BS=3'b111;
        ZERO=0;
        SLT=0;
        SLTU=1;
        #10;
        BE=1;
        BS=3'b111;
        ZERO=0;
        SLT=0;
        SLTU=0;
        #10;
        BE=1;
        BS=3'b100;
        ZERO=0;
        SLT=0;
        SLTU=0;
        #10;
        BE=0;
        #10;

    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0,testbench);
    end

endmodule