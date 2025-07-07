module top(
    input clk, reset,
    output [31:0] WriteData, DataAdrM,
    output MemWriteM
);

    wire [31:0] PCF, InstrF, ReadDataM;
    wire [1:0] StoreType;

    // instantiate processor and memories
    riscv riscv(clk, reset, PCF, InstrF, MemWriteM, DataAdrM, WriteData, ReadDataM,StoreType);
    imem imem(PCF, InstrF);
    dmem dmem(clk, MemWriteM, StoreType, DataAdrM, WriteData, ReadDataM);

endmodule
