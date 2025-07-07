
module loadextender(
    input  [2:0] LoadType,
    input  [31:0] ReadData,
    input  [1:0]  addr_offset, // a[1:0] from the memory address
    output reg [31:0] LoadData
);
always @* begin
    case (LoadType)
        3'b001: // LB
            case (addr_offset)
                2'b00: LoadData = {{24{ReadData[7]}},  ReadData[7:0]};
                2'b01: LoadData = {{24{ReadData[15]}}, ReadData[15:8]};
                2'b10: LoadData = {{24{ReadData[23]}}, ReadData[23:16]};
                2'b11: LoadData = {{24{ReadData[31]}}, ReadData[31:24]};
            endcase
        3'b010: // LH
            case (addr_offset[1])
                1'b0: LoadData = {{16{ReadData[15]}}, ReadData[15:0]};
                1'b1: LoadData = {{16{ReadData[31]}}, ReadData[31:16]};
            endcase
        3'b011: LoadData = ReadData; // LW
        3'b100: // LBU
            case (addr_offset)
                2'b00: LoadData = {24'b0, ReadData[7:0]};
                2'b01: LoadData = {24'b0, ReadData[15:8]};
                2'b10: LoadData = {24'b0, ReadData[23:16]};
                2'b11: LoadData = {24'b0, ReadData[31:24]};
            endcase
        3'b101: // LHU
            case (addr_offset[1])
                1'b0: LoadData = {16'b0, ReadData[15:0]};
                1'b1: LoadData = {16'b0, ReadData[31:16]};
            endcase
        default: LoadData = 32'bx;
    endcase
end
endmodule
