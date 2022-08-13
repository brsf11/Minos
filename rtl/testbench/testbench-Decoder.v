`timescale 1ns/1ps
module testbench();

    reg[31:0] ins;
    wire[2:0] BS,RegMuxS;
    wire[1:0] ShCtr,LogicS,WWHBS,RWHBS;
    wire RWE,MWE,BE,ShMuxS,ALUS,ALUMuxSB,ALUIMMMuxSA,ALUIMMMuxSB,ALUMuxSA,LS,FAMuxS,JMuxS,SLMuxS;
    
    Decoder decoder(
        .funct7(ins[31:25]),
        .funct3(ins[14:12]),
        .opcode(ins[6:0]),
        .BE(BE),
        .BS(BS),
        .RegMuxS(RegMuxS),
        .ShCtr(ShCtr),
        .LogicS(LogicS),
        .WWHBS(WWHBS),
        .RWHBS(RWHBS),
        .RWE(RWE),
        .MWE(MWE),
        .ShMuxS(ShMuxS),
        .ALUS(ALUS),
        .ALUMuxSB(ALUMuxSB),
        .ALUIMMMuxSA(ALUIMMMuxSA),
        .ALUMuxSA(ALUMuxSA),
        .ALUIMMMuxSB(ALUIMMMuxSB),
        .LS(LS),
        .FAMuxS(FAMuxS),
        .JMuxS(JMuxS),
        .SLMuxS(SLMuxS)
    );

    initial begin
        ins=32'h00010503;
        #10;
        ins=32'h00011503;
        #10;
        ins=32'h00014503;
        #10;
        ins=32'h00015503;
        #10;
        ins=32'h00012503;
        #10;
        ins=32'h00551513;
        #10;
        ins=32'h00555513;
        #10;
        ins=32'h40555513;
        #10;
        ins=32'h00550513;
        #10;
        ins=32'h00552513;
        #10;
        ins=32'h00553513;
        #10;
        ins=32'h00554513;
        #10;
        ins=32'h00556513;
        #10;
        ins=32'h00557513;
        #10;
        ins=32'h00005517;
        #10;
        ins=32'h00a10023;
        #10;
        ins=32'h00a11023;
        #10;
        ins=32'h00a12023;
        #10;
        ins=32'h00a51533;
        #10;
        ins=32'h00a55533;
        #10;
        ins=32'h40a55533;
        #10;
        ins=32'h00a50533;
        #10;
        ins=32'h40a50533;
        #10;
        ins=32'h00a52533;
        #10;
        ins=32'h00a53533;
        #10;
        ins=32'h00a54533;
        #10;
        ins=32'h00a56533;
        #10;
        ins=32'h00a57533;
        #10;
        ins=32'h00005537;
        #10;
        ins=32'hf6a508e3;
        #10;
        ins=32'hf6a516e3;
        #10;
        ins=32'hf6a544e3;
        #10;
        ins=32'hf6a552e3;
        #10;
        ins=32'hf6a560e3;
        #10;
        ins=32'hf4a57ee3;
        #10;
        ins=32'h00050567;
        #10;
        ins=32'h0000056f;
        #10;

    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0,testbench);    
    end

endmodule