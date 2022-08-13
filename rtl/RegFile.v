module RegFile(input wire CLK,WE,
               input wire[4:0] RADDR1,RADDR2,WADDR,
               input wire[31:0] DIN,
               output wire[31:0] DOUT1,DOUT2);

    reg[31:0] regi[31:0];

    always @(posedge CLK)begin
        regi[0]<=32'b0;
        if(WE&(|WADDR))regi[WADDR]<=DIN;
    end

    assign DOUT1=regi[RADDR1];
    assign DOUT2=regi[RADDR2];

endmodule