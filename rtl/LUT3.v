module LUT3 #(parameter INIT=8'h00) (input wire I0,I1,I2,
                                     output wire O);

    assign O=INIT[{I2,I1,I0}];

endmodule