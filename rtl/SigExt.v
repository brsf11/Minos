module SigExt #(parameter width=12) (input wire[width-1:0] x,
                                     output wire[31:0] y);
    
    wire[31:width] ext;

    assign ext=x[width-1]?(2**(32-width)-1):0;
    assign y={ext,x[width-1:0]};

endmodule