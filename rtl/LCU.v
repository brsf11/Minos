module LCU(input wire[1:0] LogicS,
           input wire[31:0] a,b,
           output wire[31:0] LogicRes);

    assign LogicRes=LogicS[1]?(LogicS[0]?(a&b):(a|b)):(a^b);

endmodule