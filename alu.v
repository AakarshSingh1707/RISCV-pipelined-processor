module alu(
    input  [31:0] a,
    input  [31:0] b,
    input  [3:0]  alucontrol, 
    output  [31:0]  result,
    output  [3:0]   flags       // for blt and other branches
);

    wire [31:0] condinvb, sum;
    wire v, c, n, z;          // flags: overflow, carry out, negative, zero
    wire cout;                // carry out of adder
    wire isAddSub;            // true if is an add or subtract operation
    reg  [31:0] result_reg;

    assign condinvb = alucontrol[0] ? ~b : b;
    assign {cout, sum} = a + condinvb + alucontrol[0];

    assign isAddSub = (~alucontrol[3] & ~alucontrol[2] & ~alucontrol[1]) |
                      (~alucontrol[3] & ~alucontrol[1] & alucontrol[0]);

    always @* begin
        case (alucontrol)
            4'b0000: result_reg = sum;                        // add
            4'b0001: result_reg = sum;                        // subtract
            4'b0010: result_reg = a & b;                      // and
            4'b0011: result_reg = a | b;                      // or
            4'b0100: result_reg = a ^ b;                      // xor
            4'b0101: result_reg = sum[31] ^ v;                // slt
            4'b0110: result_reg = a << b[4:0];                // sll
            4'b0111: result_reg = a >> b[4:0];                // srl
            4'b1000: result_reg = $signed(a) >>> b[4:0];      // sra
            4'b1001: result_reg = (a < b) ? 1 : 0;            // sltu
            default: result_reg = 32'bx;
        endcase
     
    end

    assign z = (result_reg == 32'b0);
    assign n = result_reg[31];
    assign c = cout & isAddSub;
    assign v = ~(alucontrol[0] ^ a[31] ^ b[31]) & (a[31] ^ sum[31]) & isAddSub;
    assign flags = {v, c, n, z};
    assign result = result_reg;
    

endmodule

