module RISCVCore(input wire CLK,rst_n,
                 input wire[31:0] ROMData,RAMData,
                 output wire[31:0] IFPC,RADDR,WADDR,WData,
                 output wire[1:0] RWHBS,WWHBS,
                 output wire WE,MRE);

    wire[31:0] RegData,RRS1,RRS2;
    wire[4:0] RS1,EXWMrs2,WRrd;
    wire WRRWE,DEBranchFlush,IFFlush,DEFlush;

    //Register File

    RegFile RegFile(
        .CLK(CLK),
        .WE(WRRWE),
        .RADDR1(RS1),
        .RADDR2(EXWMrs2),
        .WADDR(WRrd),
        .DIN(RegData),
        .DOUT1(RRS1),
        .DOUT2(RRS2)
    );

    //HCU

    wire[4:0] EXWMrd;
    wire DErs1MuxS,EXWMrs1MuxS,EXWMrs2MuxS,IFFlushBack,EXWMRWE;
    
    HCU HCU(
        .CLK(CLK),
        .rst_n(rst_n),
        .DEBranchFlush(DEBranchFlush),
        .EXWMRWE(EXWMRWE),
        .WRRWE(WRRWE),
        .DErs1(RS1),
        .EXWMrs2(EXWMrs2),
        .EXWMrd(EXWMrd),
        .WRrd(WRrd),
        .IFFlush(IFFlush),
        .DEFlush(DEFlush),
        .DErs1MuxS(DErs1MuxS),
        .EXWMrs1MuxS(EXWMrs1MuxS),
        .EXWMrs2MuxS(EXWMrs2MuxS),
        .IFFlushBack(IFFlushBack)
    );

    //IF

    wire[31:0] Jump;
    wire PCS;

    IF IF(
        .CLK(CLK),
        .rst_n(rst_n),
        .PCS(PCS),
        .Flush(IFFlush),
        .FlushBack(IFFlushBack),
        .JADDR(Jump),
        .IFPC(IFPC)
    );

    //DE

    wire[31:0] DEPC;
    wire[19:0] uimm;
    wire[11:0] imm;
    wire[4:0] shamt,rs2,rd;
    wire[2:0] DERegMuxS,DEBS;
    wire[1:0] DEShCtr,DELogicS,DEWWHBS;
    wire DERWE,DEMWE,DEBE,DEShMuxS,DEALUS,DEALUMuxSB,DEALUIMMMuxSB,DEALUMuxSA,DEALUIMMMuxSA,DELS;

    DE DE(
        .CLK(CLK),
        .rst_n(rst_n),
        .Flush(DEFlush),
        .IFPC(IFPC),
        .INS(ROMData),
        .RRS1(DErs1MuxS?RegData:RRS1),
        .DEPC(DEPC),
        .BJumpRSIMM(RADDR),
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
        .DERWHBS(RWHBS),
        .DERWE(DERWE),
        .DEMWE(DEMWE),
        .DEBE(DEBE),
        .DEMRE(MRE),
        .DEShMuxS(DEShMuxS),
        .DEALUS(DEALUS),
        .DEALUMuxSB(DEALUMuxSB),
        .DEALUIMMMuxSB(DEALUIMMMuxSB),
        .DEALUMuxSA(DEALUMuxSA),
        .DEALUIMMMuxSA(DEALUIMMMuxSA),
        .DELS(DELS),
        .DEBranchFlush(DEBranchFlush)
    );

    //EXWM

    wire[31:0] ShiftRes,ALURes,LogicRes,DOUT;
    wire[19:0] EXWMuimm;
    wire[2:0] EXWMRegMuxS,EXWMBS;
    wire EXWMBE,SLT,ZERO,SLTU;


    EXWM EXWM(
        .CLK(CLK),
        .rst_n(rst_n),
        .BJumpRSIMM(RADDR),
        .RRS1(DErs1MuxS?RegData:RRS1),
        .RRS2(EXWMrs2MuxS?RegData:RRS2),
        .DIN(RAMData),
        .DEPC(DEPC),
        .uimm(uimm),
        .imm(imm),
        .rs2(rs2),
        .rd(rd),
        .DEShamt(shamt),
        .DERegMuxS(DERegMuxS),
        .DEBS(DEBS),
        .DEShCtr(DEShCtr),
        .DELogicS(DELogicS),
        .DEWWHBS(DEWWHBS),
        .DERWHBS(RWHBS),
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
        .EXWMBJumpRSIMM(WADDR),
        .EXWMuimm(EXWMuimm),
        .EXWMrd(EXWMrd),
        .EXWMrs2(EXWMrs2),
        .EXWMRegMuxS(EXWMRegMuxS),
        .EXWMBS(EXWMBS),
        .EXWMWWHBS(WWHBS),
        .EXWMRWE(EXWMRWE),
        .EXWMMWE(WE),
        .EXWMBE(EXWMBE),
        .ShiftRes(ShiftRes),
        .ALURes(ALURes),
        .LogicRes(LogicRes),
        .DOUT(DOUT),
        .SLT(SLT),
        .ZERO(ZERO),
        .SLTU(SLTU)
    );

    //WR

    WR WR(
        .CLK(CLK),
        .rst_n(rst_n),
        .ShiftRes(ShiftRes),
        .ALURes(ALURes),
        .LogicRes(LogicRes),
        .DOUT(DOUT),
        .EXWMBJumpRSIMM(WADDR),
        .EXWMuimm(EXWMuimm),
        .EXWMrd(EXWMrd),
        .EXWMRegMuxS(EXWMRegMuxS),
        .EXWMBS(EXWMBS),
        .EXWMRWE(EXWMRWE),
        .EXWMBE(EXWMBE),
        .SLT(SLT),
        .ZERO(ZERO),
        .SLTU(SLTU),
        .Jump(Jump),
        .WRrd(WRrd),
        .WRRWE(WRRWE),
        .RegData(RegData),
        .PCS(PCS)
    );

    assign WData=EXWMrs2MuxS?RegData:RRS2;

endmodule