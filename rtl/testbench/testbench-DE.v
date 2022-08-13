`timescale 1ns/1ps
module testbench();

    reg CLK,rst_n;
    reg[31:0] IFPC,INS,RRS1;
    wire[31:0] DEPC,BJumpRSIMM;
    wire[11:0] imm;
    wire[19:0] uimm;
    wire[4:0] RS1,shamt,rs2,rd;
    wire[2:0] DERegMuxS,DEBS;
    wire[1:0] DEShCtr,DELogicS,DEWWHBS,DERWHBS;
    wire DERWE,DEMWE,DEBE,DEShMuxS,DEALUS,DEALUMuxSB,DEALUIMMMuxSB,DEALUMuxSA,DEALUIMMMuxSA,DELS,DEBranchFlush;

    DE de(
        .CLK(CLK),
        .rst_n(rst_n),
        .IFPC(IFPC),
        .INS(INS),
        .RRS1(RRS1),
        .DEPC(DEPC),
        .BJumpRSIMM(BJumpRSIMM),
        .imm(imm),
        .uimm(uimm),
        .RS1(RS1),
        .shamt(shamt),
        .rs2(rs2),
        .rd(rd),
        .DERegMuxS(DERegMuxS),
        .DEBS(DEBS),
        .DEShCtr(DEShCtr),
        .DELogicS(DELogicS),
        .DEWWHBS(DEWWHBS),
        .DERWHBS(DERWHBS),
        .DERWE(DERWE),
        .DEMWE(DEMWE),
        .DEBE(DEBE),
        .DEShMuxS(DEShMuxS),
        .DEALUS(DEALUS),
        .DEALUMuxSB(DEALUMuxSB),
        .DEALUIMMMuxSB(DEALUIMMMuxSB),
        .DEALUMuxSA(DEALUMuxSA),
        .DEALUIMMMuxSA(DEALUIMMMuxSA),
        .DELS(DELS),
        .DEBranchFlush(DEBranchFlush)
    );

    initial begin
        CLK=0;
        rst_n=0;
        INS=0;
        IFPC=4;
        RRS1=32'h10;
        #10;
        rst_n=1;
        CLK=1;
        INS=32'hf6a508e3;
        #10;
        INS=32'hf6a516e3;
        #10;
        INS=32'hf6a544e3;
        #10;
        INS=32'hf6a552e3;
        #10;
        INS=32'hf6a560e3;
        #10;
        INS=32'hf4a57ee3;
        #10;
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0,testbench);    
    end

endmodule