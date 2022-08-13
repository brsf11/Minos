module Decoder(input wire[6:0] funct7,
               input wire[2:0] funct3,
               input wire[6:0] opcode,
               output wire[2:0] BS,RegMuxS,
               output wire[1:0] ShCtr,LogicS,WWHBS,RWHBS,
               output wire RWE,MWE,BE,MRE,ShMuxS,ALUS,ALUMuxSB,ALUIMMMuxSA,ALUMuxSA,ALUIMMMuxSB,LS,FAMuxS,JMuxS,SLMuxS);

    wire[3:0] OpcodeType;
    wire[1:0] RegStoreType;
    wire[2:0] RegMuxS0,RegMuxS1;
    wire valid;
    wire RWEl,MWEl;

    assign valid=opcode[0]&opcode[1]&(|OpcodeType);
    assign RWE=RWEl&valid;
    assign MWE=MWEl&valid;
    assign BE=opcode[6];
    assign MRE=~(|opcode[6:2]);
    assign BS[0]=funct3[0]&(~opcode[2]);
    assign BS[1]=funct3[2]&(~opcode[2]);
    assign BS[2]=funct3[1]|opcode[2];
    
    assign RegMuxS0[0]=RegStoreType[1]^RegStoreType[0];
    assign RegMuxS0[1]=~RegMuxS0[0];
    assign RegMuxS0[2]=(~RegStoreType[1])&(~RegStoreType[0])|RegStoreType[1]&(~RegStoreType[0]);

    assign RegMuxS1[0]=(~funct3[2])&(~funct3[1])&(~funct3[0])|(~funct3[2])&funct3[1]&funct3[0];
    assign RegMuxS1[1]=(~funct3[2])&funct3[1];
    assign RegMuxS1[2]=funct3[2]&(~funct3[0])|funct3[2]&funct3[1];

    assign RegMuxS=(RegStoreType[1]&RegStoreType[0])?RegMuxS1:RegMuxS0;

    assign ShMuxS=opcode[5];
    assign ShCtr[1]=funct7[5];
    assign ShCtr[0]=funct3[2];
    assign ALUS=RegStoreType[1]&(funct3[1]|(opcode[5]&funct7[5]))|((~OpcodeType[3])&OpcodeType[2]&OpcodeType[1]&OpcodeType[0]);
    assign ALUMuxSB=RegStoreType[1]|((~OpcodeType[3])&OpcodeType[2]&OpcodeType[1]&OpcodeType[0]);
    assign ALUIMMMuxSA=OpcodeType[3];
    assign ALUMuxSA=RegStoreType[1]|((~OpcodeType[3])&OpcodeType[2]&OpcodeType[1]&OpcodeType[0]);
    assign ALUIMMMuxSB=opcode[5];
    assign LogicS=funct3[1:0];
    assign WWHBS[0]=funct3[1]|funct3[0];
    assign WWHBS[1]=funct3[1];
    assign LS=~funct3[2];
    assign RWHBS[0]=funct3[1]|funct3[0];
    assign RWHBS[1]=funct3[1];
    assign FAMuxS=(|OpcodeType[3:1])&OpcodeType[0];
    assign JMuxS=OpcodeType[3];
    assign SLMuxS=opcode[5];

    LUT6_2 #(.INIT(64'd72_092_984_719_446_049)) OpcodeTypeLut0(
        .O5(OpcodeType[0]),
        .O6(OpcodeType[1]),
        .I0(opcode[2]),
        .I1(opcode[3]),
        .I2(opcode[4]),
        .I3(opcode[5]),
        .I4(opcode[6]),
        .I5(1'b1)
    );

    LUT6_2 #(.INIT(64'd720_575_940_396_069_120)) OpcodeTypeLut1(
        .O5(OpcodeType[2]),
        .O6(OpcodeType[3]),
        .I0(opcode[2]),
        .I1(opcode[3]),
        .I2(opcode[4]),
        .I3(opcode[5]),
        .I4(opcode[6]),
        .I5(1'b1)
    );

    LUT3 #(.INIT(8'd111)) RWELut(
        .O(RWEl),
        .I0(OpcodeType[0]),
        .I1(OpcodeType[1]),
        .I2(OpcodeType[2])
    );
    
    LUT3 #(.INIT(8'd16)) MWELut(
        .O(MWEl),
        .I0(OpcodeType[0]),
        .I1(OpcodeType[1]),
        .I2(OpcodeType[2])
    );

    LUT6_2 #(.INIT(64'd429_496_730_412)) RegStoreTypeLut(
        .O5(RegStoreType[0]),
        .O6(RegStoreType[1]),
        .I0(OpcodeType[0]),
        .I1(OpcodeType[1]),
        .I2(OpcodeType[2]),
        .I3(OpcodeType[3]),
        .I4(1'b0),
        .I5(1'b1)
    );

    
endmodule