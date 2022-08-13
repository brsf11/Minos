module IF(input wire CLK,rst_n,PCS,Flush,FlushBack,
          input wire[31:0] JADDR,
          output wire[31:0] IFPC);

    wire[31:0] NextPC;
    reg[31:0] PC;

    always @(posedge CLK or negedge rst_n)begin
        if(!rst_n)PC<=32'b0;
        else PC<=NextPC;
    end

    assign NextPC=PCS?JADDR:((Flush|FlushBack)?PC:(PC+3'b100));
    assign IFPC=FlushBack?(PC-3'b100):PC;

endmodule