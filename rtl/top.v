module top(input wire CLK,rst_n);

    wire[31:0] RAMData,RADDR,WADDR,DIN,DOUT,IFPC;
    wire[1:0] RWHBS,WWHBS;
    wire WE,RUnalExc,WUnalExc,MRE;

    RISCVCore RISCVCore(
        .CLK(CLK),
        .rst_n(rst_n),
        .ROMData(DOUT),
        .RAMData(RAMData),
        .IFPC(IFPC),
        .RADDR(RADDR),
        .WADDR(WADDR),
        .WData(DIN),
        .RWHBS(RWHBS),
        .WWHBS(WWHBS),
        .WE(WE),
        .MRE(MRE)
    );

    Ram Ram(
        .CLK(CLK),
        .WE(WE),
        .RWHBS(RWHBS),
        .WWHBS(WWHBS),
        .RADDR(RADDR),
        .WADDR(WADDR),
        .DIN(DIN),
        .DOUT(RAMData),
        .RUnalExc(RUnalExc),
        .WUnalExc(WUnalExc)
    );

    Rom Rom(
        .CLK(CLK),
        .EN(rst_n),
        .ADDR(IFPC),
        .DOUT(DOUT)
    );

endmodule