module aludec(
    input        op5,
    input  [2:0] funct3,
    input        funct7b5,
    input  [1:0] ALUOp,
    output [3:0] ALUControl
);

    reg [3:0] ALUControl_reg;
    assign ALUControl = ALUControl_reg;

    wire RtypeSub;
    assign RtypeSub = funct7b5 & op5; // TRUE for R-type subtract instruction

    always @* begin
        case (ALUOp)
            2'b00: ALUControl_reg = 4'b0000; // addition
            2'b01: ALUControl_reg = 4'b0001; // subtraction
            default: begin // R-type or I-type ALU
                case (funct3)
                    3'b000: ALUControl_reg = (RtypeSub) ? 4'b0001 : 4'b0000; // sub or add/addi
                    3'b001: ALUControl_reg = 4'b0110; // sll, slli
                    3'b010: ALUControl_reg = 4'b0101; // slt, slti
                    3'b100: ALUControl_reg = 4'b0100; // xor, xori
                    3'b101: ALUControl_reg = (funct7b5) ? 4'b1000 : 4'b0111; // sra/srai or srl/srli
                    3'b110: ALUControl_reg = 4'b0011; // or, ori
                    3'b111: ALUControl_reg = 4'b0010; // and, andi
                    default: ALUControl_reg = 4'bxxxx; // ???
                endcase
            end
        endcase
    end

endmodule

