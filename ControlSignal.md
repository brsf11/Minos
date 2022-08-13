|Instruction|funct7|funct3|opcode|RWE|MWE|BE[2:0]|RegMuxS[2:0]|ShMuxS|ShCtr[1:0]|ALUS|ALUMuxSB|ALUIMMMuxSA|ALUMuxSA|ALUIMMMuxSB|LogicS[1:0]|WWHBS[1:0]|LS |RWHBS[1:0]|FAMuxS|JMuxS|
|:---------:|:----:|:----:|:----:|:-:|:-:|:-----:|:----------:|:----:|:--------:|:-------:|:------:|:---------:|:------:|:---------:|:---------:|:--------:|:-:|:--------:|:----:|:---:|
|SLL|0000000|001|0110011|1|0|ddd|000|1|00|d|d|d|d|d|dd|dd|d|dd|d|d|
|SLLI|0000000|001|0010011|1|0|ddd|000|0|00|d|d|d|d|d|dd|dd|d|dd|d|d|
|SRL|0000000|101|0110011|1|0|ddd|000|1|01|d|d|d|d|d|dd|dd|d|dd|d|d|
|SRLI|0000000|101|0010011|1|0|ddd|000|0|01|d|d|d|d|d|dd|dd|d|dd|d|d|
|SRA|0100000|101|0110011|1|0|ddd|000|1|11|d|d|d|d|d|dd|dd|d|dd|d|d|
|SRAI|0100000|101|0010011|1|0|ddd|000|0|11|d|d|d|d|d|dd|dd|d|dd|d|d|
|ADD|0000000|000|0110011|1|0|ddd|001|d|dd|0|1|d|1|1|dd|dd|d|dd|d|d|
|ADDI|XXXXXXX|000|0010011|1|0|ddd|001|d|dd|0|1|d|1|0|dd|dd|d|dd|d|d|
|SUB|0100000|000|0110011|1|0|ddd|001|d|dd|1|1|d|1|1|dd|dd|d|dd|d|d|
|LUI|XXXXXXX|XXX|0110111|1|0|ddd|101|d|dd|d|d|d|d|d|dd|dd|d|dd|d|d|
|AUIPC|XXXXXXX|XXX|0010111|1|0|ddd|001|d|dd|0|0|0|0|d|dd|dd|d|dd|d|d|
|XOR|0000000|100|0110011|1|0|ddd|100|d|dd|d|d|d|d|d|00|dd|d|dd|d|d|
|XORI|XXXXXXX|100|0010011|1|0|ddd|100|d|dd|d|d|d|d|d|00|dd|d|dd|d|d|
|OR|0000000|110|0110011|1|0|ddd|100|d|dd|d|d|d|d|d|10|dd|d|dd|d|d|
|ORI|XXXXXXX|110|0010011|1|0|ddd|100|d|dd|d|d|d|d|d|10|dd|d|dd|d|d|
|AND|0000000|111|0110011|1|0|ddd|100|d|dd|d|d|d|d|d|11|dd|d|dd|d|d|
|ANDI|XXXXXXX|111|0010011|1|0|ddd|100|d|dd|d|d|d|d|d|11|dd|d|dd|d|d|
|SLT|0000000|010|0110011|1|0|ddd|010|d|dd|1|1|d|1|1|dd|dd|d|dd|d|d|
|SLTI|XXXXXXX|010|0010011|1|0|ddd|010|d|dd|1|1|d|1|0|dd|dd|d|dd|d|d|
|SLTU|0000000|011|0110011|1|0|ddd|011|d|dd|1|1|d|1|1|dd|dd|d|dd|d|d|
|SLTIU|XXXXXXX|011|0010011|1|0|ddd|011|d|dd|1|1|d|1|0|dd|dd|d|dd|d|d|
|BEQ|XXXXXXX|000|1100011|0|0|000|ddd|d|dd|d|d|d|d|d|dd|dd|d|dd|1|0|
|BNE|XXXXXXX|001|1100011|0|0|001|ddd|d|dd|d|d|d|d|d|dd|dd|d|dd|1|0|
|BLT|XXXXXXX|100|1100011|0|0|010|ddd|d|dd|d|d|d|d|d|dd|dd|d|dd|1|0|
|BGE|XXXXXXX|101|1100011|0|0|011|ddd|d|dd|d|d|d|d|d|dd|dd|d|dd|1|0|
|BLTU|XXXXXXX|110|1100011|0|0|110|ddd|d|dd|d|    d     |d|d|d|dd|dd|d|dd|1|0|
|BGEU|XXXXXXX|111|1100011|0|0|111|ddd|d|dd|d|d|d|d|d|dd|dd|d|dd|1|0|
|JAL|XXXXXXX|XXX|1101111|1|0|100|001|d|dd|0|0|1|0|d|dd|dd|d|dd|1|1|
|JALR|XXXXXXX|000|1100111|1|0|100|001|d|dd|0|0|1|0|d|dd|dd|d|dd|0|d|
|LB|XXXXXXX|000|0000011|1|0|ddd|110|d|dd|d|d|d|d|d|dd|dd|1|00|0|d|
|LH|XXXXXXX|001|0000011|1|0|ddd|110|d|dd|d|d|d|d|d|dd|dd|1|01|0|d|
|LBU|XXXXXXX|100|0000011|1|0|ddd|110|d|dd|d|d|d|d|d|dd|dd|0|00|0|d|
|LHU|XXXXXXX|101|0000011|1|0|ddd|110|d|dd|d|d|d|d|d|dd|dd|0|01|0|d|
|LW|XXXXXXX|010|0000011|1|0|ddd|110|d|dd|d|d|d|d|d|dd|dd|1|11|0|d|
|SB|XXXXXXX|000|0100011|0|1|ddd|ddd|d|dd|d|d|d|d|d|dd|00|d|dd|0|d|
|SH|XXXXXXX|001|0100011|0|1|ddd|ddd|d|dd|d|d|d|d|d|dd|01|d|dd|0|d|
|SW|XXXXXXX|010|0100011|0|1|ddd|ddd|d|dd|d|d|d|d|d|dd|11|d|dd|0|d|