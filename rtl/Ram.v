module Ram(input wire CLK,WE,
           input wire[1:0] RWHBS,WWHBS,      //Word=3 HalfWord=1 Byte=0
           input wire[31:0] RADDR,WADDR,DIN,
           output wire[31:0] DOUT,
           output wire RUnalExc,WUnalExc);

    
    reg[1:0]   DOUTS0,DOUTS1,DOUTS2,DOUTS3;
    wire[1:0]  DINS0, DINS1, DINS2, DINS3;
    wire       WEA0,  WEA1,  WEA2,  WEA3;
    wire[7:0]  DOUTB[3:0];
    wire[7:0]  DINSEG[3:0];
    wire[31:0] DINA;

    //PortA write PortB read

    RamUnit ru0(.CLK(CLK),
                .ENA((!WUnalExc)&WE),
                .WEA(WEA0),
                .ADDRA(WADDR[12:2]),
                .DINA(DINA[7:0]),
                .ENB(!RUnalExc),
                .WEB(1'b0),
                .ADDRB(RADDR[12:2]),
                .DINB(8'b0),
                .DOUTB(DOUTB[0]));

    RamUnit ru1(.CLK(CLK),
                .ENA((!WUnalExc)&WE),
                .WEA(WEA1),
                .ADDRA(WADDR[12:2]),
                .DINA(DINA[15:8]),
                .ENB(!RUnalExc),
                .WEB(1'b0),
                .ADDRB(RADDR[12:2]),
                .DINB(8'b0),
                .DOUTB(DOUTB[1]));

    RamUnit ru2(.CLK(CLK),
                .ENA((!WUnalExc)&WE),
                .WEA(WEA2),
                .ADDRA(WADDR[12:2]),
                .DINA(DINA[23:16]),
                .ENB(!RUnalExc),
                .WEB(1'b0),
                .ADDRB(RADDR[12:2]),
                .DINB(8'b0),
                .DOUTB(DOUTB[2]));

    RamUnit ru3(.CLK(CLK),
                .ENA((!WUnalExc)&WE),
                .WEA(WEA3),
                .ADDRA(WADDR[12:2]),
                .DINA(DINA[31:24]),
                .ENB(!RUnalExc),
                .WEB(1'b0),
                .ADDRB(RADDR[12:2]),
                .DINB(8'b0),
                .DOUTB(DOUTB[3]));

    always @(posedge CLK)begin
        DOUTS0<=RADDR[1:0];
        DOUTS1<=RADDR[1:0]+2'b01;
        DOUTS2<=RADDR[1:0]+2'b10;
        DOUTS3<=RADDR[1:0]+2'b11;
    end
    

    assign DOUT={DOUTB[DOUTS3],DOUTB[DOUTS2],DOUTB[DOUTS1],DOUTB[DOUTS0]};

    assign WEA0=!(WADDR[1]|WADDR[0]);
    assign WEA1=(WWHBS[1]&WWHBS[0])|(WWHBS[0]&(!WADDR[1])&(!WADDR[0]))|((!WADDR[1])&WADDR[0]);
    assign WEA2=(WWHBS[1]&WWHBS[0])|(WADDR[1]&(!WADDR[0]));
    assign WEA3=(WWHBS[1]&WWHBS[0])|(WADDR[1]&WADDR[0])|(WWHBS[0]&WADDR[1]);

    assign DINS0=2'b00;
    assign DINS1=(WWHBS[1]|WWHBS[0])?2'b01:2'b00;
    assign DINS2=(WWHBS[1]&WWHBS[0])?2'b10:2'b00;
    assign DINS3=WWHBS[1:0];

    assign {DINSEG[3],DINSEG[2],DINSEG[1],DINSEG[0]}=DIN;
    assign DINA={DINSEG[DINS3],DINSEG[DINS2],DINSEG[DINS1],DINSEG[DINS0]};

    assign RUnalExc=(((!RWHBS[1])&RWHBS[0])&RADDR[0])|(RWHBS[1]&RWHBS[0]&(RADDR[1]|RADDR[0]));
    assign WUnalExc=((((!WWHBS[1])&WWHBS[0])&WADDR[0])|(WWHBS[1]&WWHBS[0]&(WADDR[1]|WADDR[0])))&WE;

endmodule