
module maindec(
    input  [6:0] op,
    output [1:0] ResultSrc,
    output       MemWrite,
    output       Branch,
    output       ALUSrcA, // for lui
    output       ALUSrcB,
    output       RegWrite,
    output       Jump,
    output       JALR,
    output [2:0] ImmSrc,
    output [1:0] ALUOp
);
    
    reg jalr_reg;
    assign JALR = jalr_reg;
    
    reg [12:0] controls;
    assign {RegWrite, ImmSrc, ALUSrcA, ALUSrcB, MemWrite,
            ResultSrc, Branch, ALUOp, Jump} = controls;

    always @* begin
        case(op)
            // RegWrite_ImmSrc_ALUSrcA_ALUSrcB_MemWrite_ResultSrc_Branch_ALUOp_Jump
            7'b0000011: begin controls = 13'b1_000_0_1_0_01_0_00_0;jalr_reg = 0 ; end // lw
            7'b0100011: begin controls = 13'b0_001_0_1_1_00_0_00_0;jalr_reg = 0 ; end // sw
            7'b0110011: begin controls = 13'b1_xxx_0_0_0_00_0_10_0;jalr_reg = 0 ; end// R-type
            7'b1100011: begin controls = 13'b0_010_0_0_0_00_1_01_0;jalr_reg = 0 ; end // B-type
            7'b0010011: begin controls = 13'b1_000_0_1_0_00_0_10_0;jalr_reg = 0 ; end // I-type ALU
            7'b1100111: begin controls = 13'b1_000_0_1_0_10_0_00_1;jalr_reg = 1; end // jalr
            7'b1101111: begin controls = 13'b1_011_0_0_0_10_0_00_1;jalr_reg = 0 ; end // jal
            7'b0110111: begin controls = 13'b1_100_1_1_0_00_0_00_0;jalr_reg = 0 ; end // lui
            7'b0010111: begin controls = 13'b1_100_1_1_0_00_0_00_0;jalr_reg = 0 ; end // auipc
            7'b0000000: begin controls = 13'b0_000_0_0_0_00_0_00_0;jalr_reg = 0 ; end // reset
            default:    begin controls = 13'bx_xxx_x_x_x_xx_x_xx_x;jalr_reg = 0 ; end // non-implemented
        endcase
    end

endmodule

