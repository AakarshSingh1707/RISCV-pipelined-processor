module storemasker(
    input  [1:0] StoreType,
    input  [31:0] WriteData,
    output reg [31:0] MaskedWriteData
);
always @* begin
    case (StoreType)
        2'b01: MaskedWriteData = {24'b0, WriteData[7:0]};   // SB
        2'b10: MaskedWriteData = {16'b0, WriteData[15:0]};  // SH
        2'b11: MaskedWriteData = WriteData[31:0];           // SW
        default: MaskedWriteData = 32'bx;
    endcase
end
endmodule
