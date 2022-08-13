module ALU(input wire ALUS,
           input wire[31:0] a,b,
           output wire[31:0] ALURes,
           output wire SLT,ZERO,SLTU);

    assign ALURes=ALUS?(a-b):(a+b);
    assign ZERO=~(|ALURes);
    assign SLT=((~a[31])&(~b[31])&ALURes[31])|(a[31]&b[31]&ALURes[31])|(a[31]&(~b[31]));
    assign SLTU=((~a[31])&(~b[31])&ALURes[31])|(a[31]&b[31]&ALURes[31])|((~a[31])&b[31]);

endmodule