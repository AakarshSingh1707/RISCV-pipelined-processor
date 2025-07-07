module loadstoreunit(
    input  [6:0] opcode,
    input  [2:0] funct3,
    output reg [2:0] LoadType,   // 0: none, 1: LB, 2: LH, 3: LW, 4: LBU, 5: LHU
    output reg [1:0] StoreType   // 0: none, 1: SB, 2: SH, 3: SW
);
always @* begin
    LoadType  = 3'b000;
    StoreType = 2'b00;
    if (opcode == 7'b0000011) begin // LOAD
        case (funct3)
            3'b000: LoadType = 3'b001; // LB
            3'b001: LoadType = 3'b010; // LH
            3'b010: LoadType = 3'b011; // LW
            3'b100: LoadType = 3'b100; // LBU
            3'b101: LoadType = 3'b101; // LHU
            default: LoadType = 3'b000;
        endcase
    end else if (opcode == 7'b0100011) begin // STORE
        case (funct3)
            3'b000: StoreType = 2'b01; // SB
            3'b001: StoreType = 2'b10; // SH
            3'b010: StoreType = 2'b11; // SW
            default: StoreType = 2'b00;
        endcase
    end
end
endmodule
