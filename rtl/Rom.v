module Rom(input wire CLK,EN,
           input wire[31:0] ADDR,
           output wire[31:0] DOUT);

    reg[31:0] mem[255:0];
    reg[7:0] RGADDR;

    always @(posedge CLK)begin
        if(EN)RGADDR[7:0]<=ADDR[9:2];
    end

    assign DOUT=mem[RGADDR];

    initial begin
        mem[0] =32'h40000113;  //li sp,1024
        mem[1] =32'hfe010113;  //addi sp,sp,-32
        mem[2] =32'h00812e23;  //sw s0,28(sp)
        mem[3] =32'h02010413;  //addi s0,sp,32
        mem[4] =32'hfe042623;  //sw zero,-20(s0)
        mem[5] =32'hfe042423;  //sw zero,-24(s0)
        mem[6] =32'h0200006f;  //j 38<.L2>
        mem[7] =32'hfec42703;  //lw a4,-20(s0)
        mem[8] =32'hfe842783;  //lw a5,-24(s0)
        mem[9] =32'h00f707b3;  //add a5,a4,a5
        mem[10]=32'hfef42623;  //sw a5,-20(s0)
        mem[11]=32'hfe842783;  //lw a5,-24(s0)
        mem[12]=32'h00178793;  //addi a5,a5,1
        mem[13]=32'hfef42423;  //sw a5,-24(s0)
        mem[14]=32'hfe842703;  //lw a4,-24(s0)
        mem[15]=32'h00900793;  //li a5,9
        mem[16]=32'hfce7dee3;  //bge a5,a4,1c<.L3>
        mem[17]=32'h00000793;  //li a5,0
        mem[18]=32'h00078513;  //mv a0,a5
        mem[19]=32'h01c12403;  //lw s0,28(sp)
        mem[20]=32'h02010113;  //addi sp,sp,32
        mem[21]=32'h00000013;  //nop
        mem[22]=32'h00000013;  //nop
        mem[23]=32'h00000013;  //nop
        mem[24]=32'h00000013;  //nop
    end

endmodule