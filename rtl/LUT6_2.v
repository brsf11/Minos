module LUT6_2 #(parameter INIT=64'h0000000000000000) (input wire I0,I1,I2,I3,I4,I5,
                                                      output wire O5,O6);

    assign O6=INIT[{I5,I4,I3,I2,I1,I0}];
    assign O5=INIT[{1'b0,I4,I3,I2,I1,I0}];

endmodule