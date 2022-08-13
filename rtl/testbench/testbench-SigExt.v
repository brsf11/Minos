`timescale 1ns/1ps
module testbench();

    reg[3:0] a;
    wire[31:0] y;

    SigExt #(.width(4)) SigExt(
        .x(a),
        .y(y)
    );

    initial begin
        a=4'b1100;
        #10;
        a=4'b0100;
        #10;
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0,testbench);
    end
endmodule