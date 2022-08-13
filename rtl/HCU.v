module HCU(input wire CLK,rst_n,
           input wire DEBranchFlush,EXWMRWE,WRRWE,
           input wire[4:0] DErs1,EXWMrs2,EXWMrd,WRrd,
           output wire IFFlush,DEFlush,DErs1MuxS,EXWMrs1MuxS,EXWMrs2MuxS,IFFlushBack);

    reg EXWMBranchFlush,WRBranchFlush,WRDEBranchFlush;
    reg[4:0] EXWMrs1;
    wire BranchFlushState,DEEXWMrs1HZ,DEWRrs1HZ,EXWMWRrs1HZ,EXWMWRrs2HZ;

    always @(posedge CLK or negedge rst_n) begin
        if(!rst_n) begin
            EXWMBranchFlush<=1'b0;
            WRBranchFlush<=1'b0;
            WRDEBranchFlush<=1'b0;
            EXWMrs1<=5'b00000;
        end
        else begin
            EXWMBranchFlush<=DEBranchFlush&(~BranchFlushState)&(~DEEXWMrs1HZ);
            WRBranchFlush<=EXWMBranchFlush;
            WRDEBranchFlush<=WRBranchFlush;
            EXWMrs1<=DErs1;
        end
    end
    
    assign IFFlush=DEBranchFlush&(~BranchFlushState)|EXWMBranchFlush|WRBranchFlush;
    assign DEFlush=BranchFlushState|(DEEXWMrs1HZ&(~BranchFlushState));
    assign BranchFlushState=EXWMBranchFlush|WRBranchFlush|WRDEBranchFlush;
    assign IFFlushBack=DEEXWMrs1HZ&(~BranchFlushState);
    assign DEEXWMrs1HZ=(DErs1==EXWMrd)&EXWMRWE;
    assign DEWRrs1HZ=(DErs1==WRrd)&WRRWE;
    assign EXWMWRrs1HZ=(EXWMrs1==WRrd)&WRRWE;
    assign EXWMWRrs2HZ=(EXWMrs2==WRrd)&WRRWE;
    assign DErs1MuxS=DEWRrs1HZ;
    assign EXWMrs1MuxS=EXWMWRrs1HZ;
    assign EXWMrs2MuxS=EXWMWRrs2HZ;

endmodule