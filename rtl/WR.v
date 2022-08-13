module WR(input wire CLK,rst_n,
          input wire[31:0] ShiftRes,ALURes,LogicRes,DOUT,EXWMBJumpRSIMM,
          input wire[19:0] EXWMuimm,
          input wire[4:0] EXWMrd,
          input wire[2:0] EXWMRegMuxS,EXWMBS,
          input wire EXWMRWE,EXWMBE,SLT,ZERO,SLTU,
          output reg[31:0] Jump,
          output reg[4:0] WRrd,
          output reg WRRWE,
          output wire[31:0] RegData,
          output wire PCS);

    reg[31:0] WRShiftRes,WRALURes,WRLogicRes,WRDOUT;
    reg[19:0] WRuimm;
    reg[2:0] WRRegMuxS,WRBS;
    reg WRSLT,WRZERO,WRSLTU,WRBE;

    always @(posedge CLK or negedge rst_n) begin
        if(!rst_n) begin
            WRRWE<=1'b0;
            WRBE<=1'b0;
        end
        else begin
            WRBE<=EXWMBE;
            WRRWE<=EXWMRWE;
            WRRegMuxS<=EXWMRegMuxS;
            WRShiftRes<=ShiftRes;
            WRALURes<=ALURes;
            WRSLT<=SLT;
            WRZERO<=ZERO;
            WRSLTU<=SLTU;
            WRLogicRes<=LogicRes;
            WRrd<=EXWMrd;
            WRuimm<=EXWMuimm;
            WRBS<=EXWMBS;
            WRDOUT<=DOUT;
            Jump<=EXWMBJumpRSIMM;
        end
    end

    //RegData

    assign RegData=WRRegMuxS[2]?(WRRegMuxS[1]?WRDOUT:(WRRegMuxS[0]?{WRuimm,12'b0}:WRLogicRes)):(WRRegMuxS[1]?(WRRegMuxS[0]?{31'b0,WRSLTU}:{31'b0,WRSLT}):(WRRegMuxS[0]?WRALURes:WRShiftRes));

    //JumpCtr

    JumpCtr jumpctr(
        .BE(WRBE),
        .SLT(WRSLT),
        .ZERO(WRZERO),
        .SLTU(WRSLTU),
        .BS(WRBS),
        .PCS(PCS)
    );

endmodule