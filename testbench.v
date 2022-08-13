module testbench();

    reg[3:0] x;
    wire[31:0] y; 

    SigExt #4 sigext(x,y);

    initial begin
        x=4'b0011;
        #10;
        x=4'b1010;
        #10;
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0,testbench);    
    end

endmodule