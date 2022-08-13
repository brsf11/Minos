module EXWM(input wire CLK,rst_n,
            input wire[31:0] BJumpRSIMM,RRS1,RRS2,DIN,DEPC,
            input wire[19:0] uimm,
            input wire[11:0] imm,
            input wire[4:0] rs2,rd,DEShamt,
            input wire[2:0] DERegMuxS,DEBS,
            input wire[1:0] DEShCtr,DELogicS,DEWWHBS,DERWHBS,
            input wire DERWE,DEMWE,DEBE,DEShMuxS,DEALUS,DEALUMuxSB,DEALUIMMMuxSB,DEALUMuxSA,DEALUIMMMuxSA,DELS,
            output reg[31:0] EXWMBJumpRSIMM,
            output reg[19:0] EXWMuimm,
            output reg[4:0] EXWMrd,EXWMrs2,
            output reg[2:0] EXWMRegMuxS,EXWMBS,
            output reg[1:0] EXWMWWHBS,
            output reg EXWMRWE,EXWMMWE,EXWMBE,
            output wire[31:0] ShiftRes,ALURes,LogicRes,DOUT,
            output wire SLT,ZERO,SLTU);

    reg[31:0] EXWMRRS1,EXWMPC;
    reg[11:0] EXWMimm;
    reg[4:0] EXWMShamt;
    reg[1:0] EXWMShCtr,EXWMLogicS,EXWMRWHBS;
    reg EXWMShMuxS,EXWMALUS,EXWMALUMuxSB,EXWMALUIMMMuxSB,EXWMALUMuxSA,EXWMALUIMMMuxSA,EXWMLS;

    wire[31:0] immSignExt,EXWMALUMuxB0,EXWMALUMuxB1,EXWMALUMuxB,EXWMALUMuxA;
    wire[4:0] shamt;

    always @(posedge CLK or negedge rst_n) begin
        if(!rst_n) begin
            EXWMRWE<=1'b0;
            EXWMMWE<=1'b0;
            EXWMBE<=1'b0;
        end
        else begin
            EXWMBE<=DEBE;
            EXWMRWE<=DERWE;
            EXWMMWE<=DEMWE;
            EXWMRegMuxS<=DERegMuxS;
            EXWMShamt<=DEShamt;
            EXWMShMuxS<=DEShMuxS;
            EXWMShCtr<=DEShCtr;
            EXWMRRS1<=RRS1;
            EXWMPC<=DEPC;
            EXWMALUS<=DEALUS;
            EXWMALUMuxSB<=DEALUMuxSB;
            EXWMALUIMMMuxSB<=DEALUIMMMuxSB;
            EXWMALUMuxSA<=DEALUMuxSA;
            EXWMALUIMMMuxSA<=DEALUIMMMuxSA;
            EXWMLogicS<=DELogicS;
            EXWMrs2<=rs2;
            EXWMimm<=imm;
            EXWMuimm<=uimm;
            EXWMrd<=rd;
            EXWMBS<=DEBS;
            EXWMWWHBS<=DEWWHBS;
            EXWMLS<=DELS;
            EXWMRWHBS<=DERWHBS;
            EXWMBJumpRSIMM<=BJumpRSIMM;
        end
    end

    //shift

    assign shamt=EXWMShMuxS?RRS2[4:0]:EXWMShamt;

    SU su(
        .ShCtr(EXWMShCtr),
        .shamt(shamt),
        .x(EXWMRRS1),
        .ShiftRes(ShiftRes)
    );

    //ALU

    assign EXWMALUMuxB1=EXWMALUIMMMuxSB?RRS2:immSignExt;
    assign EXWMALUMuxB0=EXWMALUIMMMuxSA?32'd4:{EXWMuimm,12'b0};
    assign EXWMALUMuxB=EXWMALUMuxSB?EXWMALUMuxB1:EXWMALUMuxB0;
    assign EXWMALUMuxA=EXWMALUMuxSA?EXWMRRS1:EXWMPC;

    SigExt #(.width(12)) signext(
        .x(EXWMimm),
        .y(immSignExt)
    );

    ALU alu(
        .ALUS(EXWMALUS),
        .a(EXWMALUMuxA),
        .b(EXWMALUMuxB),
        .ALURes(ALURes),
        .SLT(SLT),
        .ZERO(ZERO),
        .SLTU(SLTU)
    );

    //LCU

    LCU lcu(
        .LogicS(EXWMLogicS),
        .a(EXWMRRS1),
        .b(EXWMALUMuxB),
        .LogicRes(LogicRes)
    );

    //DOUT

    wire[31:0] DOUTB,DOUTH;

    assign DOUTB={{24{EXWMLS&DIN[7]}},DIN[7:0]};
    assign DOUTH={{16{EXWMLS&DIN[15]}},DIN[15:0]};
    assign DOUT=EXWMRWHBS[1]?DIN:(EXWMRWHBS[0]?DOUTH:DOUTB);


endmodule