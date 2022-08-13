module LUT6 #(parameter INIT=64'h0000000000000000) (input wire I0,I1,I2,I3,I4,I5,
                           output wire O);

    assign O=INIT[{I5,I4,I3,I2,I1,I0}];
endmodule