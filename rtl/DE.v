module DE(input wire CLK,rst_n,Flush,
          input wire[31:0] IFPC,INS,RRS1,
          output reg[31:0] DEPC,
          output wire[31:0] BJumpRSIMM,
          output wire[11:0] imm,
          output wire[19:0] uimm,
          output wire[4:0] RS1,shamt,rs2,rd,
          output wire[2:0] DERegMuxS,DEBS,
          output wire[1:0] DEShCtr,DELogicS,DEWWHBS,DERWHBS,
          output wire DERWE,DEMWE,DEBE,DEMRE,DEShMuxS,DEALUS,DEALUMuxSB,DEALUIMMMuxSB,DEALUMuxSA,DEALUIMMMuxSA,DELS,DEBranchFlush);

    wire DEJMuxS,DEFAMuxS,DESLMuxS,RWE,MWE,BE,MRE;
    wire[31:0] DEJ0,DEJ1,DEFAA0,DEFAA1,DESL0,DESL1,FAA,FAB;
    reg RST;

    always @(posedge CLK or negedge rst_n) begin
        if(!rst_n) begin
            DEPC<=32'b0;
            RST<=1'b0;
        end
        else begin
            DEPC<=IFPC;
            RST<=1'b1;
        end
        
    end

    assign shamt=INS[24:20];
    assign rs2=INS[24:20];
    assign imm=INS[31:20];
    assign uimm=INS[31:12];
    assign rd=INS[11:7];
    assign RS1=INS[19:15];

    assign DEFAA0=DESLMuxS?DESL1:DESL0;
    assign DEFAA1=DEJMuxS?DEJ1:DEJ0;
    assign FAA=DEFAMuxS?DEFAA1:DEFAA0;
    assign FAB=DEFAMuxS?DEPC:RRS1;
    assign BJumpRSIMM=FAA+FAB;
    assign DEBranchFlush=INS[6]&INS[5]&RST;

    assign DERWE=RWE&(~Flush)&RST;
    assign DEMWE=MWE&(~Flush)&RST;
    assign DEBE=BE&(~Flush)&RST;
    assign DEMRE=MRE&(~Flush)&RST;


    //Decode
    
    Decoder decoder(
        .funct7(INS[31:25]),
        .funct3(INS[14:12]),
        .opcode(INS[6:0]),
        .BS(DEBS),
        .RegMuxS(DERegMuxS),
        .ShCtr(DEShCtr),
        .LogicS(DELogicS),
        .WWHBS(DEWWHBS),
        .RWHBS(DERWHBS),
        .RWE(RWE),
        .MWE(MWE),
        .BE(BE),
        .MRE(MRE),
        .ShMuxS(DEShMuxS),
        .ALUS(DEALUS),
        .ALUMuxSB(DEALUMuxSB),
        .ALUIMMMuxSA(DEALUIMMMuxSA),
        .ALUMuxSA(DEALUMuxSA),
        .ALUIMMMuxSB(DEALUIMMMuxSB),
        .LS(DELS),
        .FAMuxS(DEFAMuxS),
        .JMuxS(DEJMuxS),
        .SLMuxS(DESLMuxS)
    );

    //SignExt

    SigExt #(.width(21)) DEJ1SigExt(
        .x({INS[31],INS[19:12],INS[20],INS[30:21],1'b0}),
        .y(DEJ1)
    );

    SigExt #(.width(13)) DEJ0SigExt(
        .x({INS[31],INS[7],INS[30:25],INS[11:8],1'b0}),
        .y(DEJ0)
    );

    SigExt #(.width(12)) DESL0SigExt(
        .x({INS[31:20]}),
        .y(DESL0)
    );

    SigExt #(.width(12)) DESL1SigExt(
        .x({INS[31:25],INS[11:7]}),
        .y(DESL1)
    );


endmodule