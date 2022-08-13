module RamUnit(input wire CLK,ENA,WEA,
               input wire[10:0] ADDRA,
               input wire[7:0] DINA,

               input wire ENB,WEB,
               input wire[10:0] ADDRB,
               input wire[7:0] DINB,

               output wire[7:0] DOUTB);

    reg[7:0] mem[2047:0];
    reg[10:0] raddra,raddrb;
    reg[7:0] rdina,rdinb;
    reg rwea,rweb;

    always @(posedge CLK)begin
        raddra<=ADDRA;
        raddrb<=ADDRB;
        rdina<=DINA;
        rdinb<=DINB;
        rwea<=WEA;
        rweb<=WEB;
    end

    always @(*)begin
        if(rwea&ENA) mem[raddra]<=rdina;
        if(rweb&ENB) mem[raddrb]<=rdinb;
    end

    assign DOUTB=mem[raddrb];

endmodule