module JumpCtr(input wire BE,SLT,ZERO,SLTU,
               input wire[2:0] BS,
               output wire PCS);

    wire en;
    
    assign en=BS[2]&(~BS[1])&(~BS[0])|(BS[2]?(BS[1]?(BS[0]?(~SLTU):SLTU):1'b0):(BS[1]?(BS[0]?(~SLT):SLT):(BS[0]?(~ZERO):ZERO)));
    assign PCS=en&BE;

endmodule