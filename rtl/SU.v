module SU(input wire[1:0] ShCtr,
          input wire[4:0] shamt,
          input wire[31:0] x,
          output wire[31:0] ShiftRes);

    assign ShiftRes=ShCtr[1]?(x >>> shamt):(ShCtr[0]?(x >> shamt):(x << shamt));

endmodule