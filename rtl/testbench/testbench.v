`timescale 1ns/1ps
module testbench();

    reg CLK,WE;
    reg[1:0] RWHBS,WWHBS;
    reg[31:0] RADDR,WADDR,DIN;
    wire[31:0] DOUT;
    wire RUnalExc,WUnalExc;

    Ram ram(CLK,WE,RWHBS,WWHBS,RADDR,WADDR,DIN,DOUT,RUnalExc,WUnalExc);


    initial begin
        WE=1'b1;
        RWHBS=2'b11;
        RADDR=32'd0;

        WWHBS=2'b11;
        WADDR=32'd0;
        DIN=32'h11111111;

        #10;
        WADDR=32'd4;
        WWHBS=2'b01;
        DIN=32'h22222222;
        #10;
        WADDR=32'd6;
        DIN=32'h33333333;
        #10;
        WADDR=32'd8;
        WWHBS=2'b00;
        DIN=32'h44444444;
        #10;
        WADDR=32'd9;
        DIN=32'h55555555;
        #10;
        WADDR=32'd10;
        DIN=32'h66666666;
        #10;
        WADDR=32'd11;
        DIN=32'h77777777;
        #10;
        RADDR=32'd4;
        RWHBS=2'b01;
        #10;
        RADDR=32'd5;
        #10;
        RADDR=32'd6;
        #10;
        RADDR=32'd8;
        #10;
        RADDR=32'd10;
        #10;
        RWHBS=2'b00;
        

    end

    initial begin
        CLK=0;
        #5;
        CLK=1;
        #5;
        CLK=0;
        #5;
        CLK=1;
        #5;
        CLK=0;
        #5;
        CLK=1;
        #5;
        CLK=0;
        #5;
        CLK=1;
        #5;
        CLK=0;
        #5;
        CLK=1;
        #5;
        CLK=0;
        #5;
        CLK=1;
        #5;
        CLK=0;
        #5;
        CLK=1;
        #5;
        CLK=0;
        #5;
        CLK=1;
        #5;
        CLK=0;
        #5;
        CLK=1;
        #5;
        CLK=0;
        #5;
        CLK=1;
        #5;
        CLK=0;
        #5;
        CLK=1;
        #5;
        CLK=0;
        #5;
        CLK=1;
        #5;
        CLK=0;
        #5;
        CLK=1;
        #5;
        CLK=0;
        #5;
        CLK=1;
        #5;
        CLK=0;
        #5;
        CLK=1;
        #5;
        CLK=0;
        #5;
        CLK=1;
        #5;
        CLK=0;
        #5;
        CLK=1;
        #5;
        CLK=0;
        #5;
        CLK=1;
        #5;
        CLK=0;
        #5;
        CLK=1;
        #5;
        CLK=0;
        #5;
        CLK=1;
        #5;
        CLK=0;
        #5;
        CLK=1;
        #5;
        CLK=0;
        #5;
        CLK=1;
        #5;
        CLK=0;
        #5;
        CLK=1;
        #5;
        CLK=0;
        #5;
        CLK=1;
        #5;
        CLK=0;
        #5;
        CLK=1;
        #5;
        CLK=0;
        #5;
        CLK=1;
        #5;
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0,testbench);
    end

endmodule