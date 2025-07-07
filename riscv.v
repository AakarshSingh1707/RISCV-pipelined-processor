
module riscv(
    input clk, reset,
    output [31:0] PCF,
    input [31:0] InstrF,
    output MemWriteM,
    output [31:0] ALUResultM, WriteData,
    input [31:0] ReadDataM,
    output [1:0]StoreType
);

    wire [6:0] opD;
    wire [2:0] funct3D;
    wire funct7b5D;
    wire [2:0] ImmSrcD;
    wire [3:0] FlagE;
    wire PCSrcE;
    wire [1:0] PCSrcSelE;    
    wire [3:0] ALUControlE;
    wire ALUSrcAE, ALUSrcBE;
    wire ResultSrcEb0;
    wire RegWriteM;
    wire [1:0] ResultSrcW;
    wire RegWriteW;
    wire [1:0] ForwardAE, ForwardBE;
    wire StallF, StallD, FlushD, FlushE;
    wire [4:0] Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW;
    wire [2:0]LoadType;
    
    
    controller c(
        .clk(clk), .reset(reset),
        .opD(opD), .funct3D(funct3D), .funct7b5D(funct7b5D), .ImmSrcD(ImmSrcD),
        .FlushE(FlushE), .FlagE(FlagE), .PCSrcE(PCSrcE), .ALUControlE(ALUControlE),
        .ALUSrcAE(ALUSrcAE), .ALUSrcBE(ALUSrcBE),.PCSrcSelE(PCSrcSelE), .ResultSrcEb0(ResultSrcEb0),
        .MemWriteM(MemWriteM), .RegWriteM(RegWriteM),
        .RegWriteW(RegWriteW), .ResultSrcW(ResultSrcW), .LoadType(LoadType), .StoreType(StoreType)
    );

    datapath dp(
        .clk(clk), .reset(reset),
        .StallF(StallF), .PCF(PCF), .InstrF(InstrF),
        .opD(opD), .funct3D(funct3D), .funct7b5D(funct7b5D), .StallD(StallD), .FlushD(FlushD), .ImmSrcD(ImmSrcD),
        .FlushE(FlushE), .ForwardAE(ForwardAE), .ForwardBE(ForwardBE), .PCSrcE(PCSrcE), .ALUControlE(ALUControlE),
        .ALUSrcAE(ALUSrcAE), .ALUSrcBE(ALUSrcBE), .PCSrcSelE(PCSrcSelE), .FlagE(FlagE),
        .MemWriteM(MemWriteM), .WriteData(WriteData), .ALUResultM(ALUResultM), .ReadDataM(ReadDataM),
        .RegWriteW(RegWriteW), .ResultSrcW(ResultSrcW),
        .Rs1D(Rs1D), .Rs2D(Rs2D), .Rs1E(Rs1E), .Rs2E(Rs2E), .RdE(RdE), .RdM(RdM), .RdW(RdW), .LoadType(LoadType), .StoreType(StoreType)
    );

    hazard hu(
        .Rs1D(Rs1D), .Rs2D(Rs2D), .Rs1E(Rs1E), .Rs2E(Rs2E), .RdE(RdE), .RdM(RdM), .RdW(RdW),
        .PCSrcE(PCSrcE), .ResultSrcEb0(ResultSrcEb0), .RegWriteM(RegWriteM), .RegWriteW(RegWriteW),
        .ForwardAE(ForwardAE), .ForwardBE(ForwardBE), .StallF(StallF), .StallD(StallD), .FlushD(FlushD), .FlushE(FlushE)
    );

endmodule
