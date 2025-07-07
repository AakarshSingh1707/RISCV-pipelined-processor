
module datapath(
    input clk, reset,
    // Fetch stage signals
    input StallF,
    output [31:0] PCF,
    input [31:0] InstrF,
    // Decode stage signals
    output [6:0] opD,
    output [2:0] funct3D,
    output funct7b5D,
    input StallD, FlushD,
    input [2:0] ImmSrcD,
    // Execute stage signals
    input FlushE,
    input [1:0] ForwardAE, ForwardBE,
    input PCSrcE,
    input [3:0] ALUControlE,
    input ALUSrcAE, // needed for lui
    input ALUSrcBE,
    input [1:0] PCSrcSelE, // for jalr
    output [3:0] FlagE,
    // Memory stage signals
    input MemWriteM,
    output [31:0] WriteData, ALUResultM,
    input [31:0] ReadDataM,
    // Writeback stage signals
    input RegWriteW,
    input [1:0] ResultSrcW,
    // Hazard Unit signals
    output [4:0] Rs1D, Rs2D, Rs1E, Rs2E,
    output [4:0] RdE, RdM, RdW,
    
    input [2:0] LoadType,
    input [1:0] StoreType
);

    // Fetch stage signals
    wire [31:0] PCNextF, PCPlus4F;
    
    // Decode stage signals
    wire [31:0] InstrD;
    wire [31:0] PCD, PCPlus4D;
    wire [31:0] RD1D, RD2D;
    wire [31:0] ImmExtD;
    wire [4:0] RdD;
    
    // Execute stage signals
    wire [31:0] RD1E, RD2E;
    wire [31:0] PCE, ImmExtE;
    wire [31:0] SrcAE, SrcBE;
    wire [31:0] SrcAEforward;
    wire [31:0] ALUResultE;
    wire [31:0] WriteDataE;
    wire [31:0] PCPlus4E;
    wire [31:0] PCTargetE;
    wire [31:0] JALRTargetE;
    
    // Memory stage signals
    wire [31:0] PCPlus4M;
    wire [31:0] LoadDataM;
    wire [31:0] MaskedWriteDataM;
    wire [31:0] WriteDataM;
    wire [2:0] LoadTypeM;
    wire [1:0] StoreTypeM;
    wire [1:0] addr_offset;
    
    // Writeback stage signals
    wire [31:0] ALUResultW;
    wire [31:0] ReadDataW;
    wire [31:0] PCPlus4W;
    wire [31:0] ResultW;
    wire [31:0] LoadDataW;

    // Fetch stage pipeline register and logic
   mux3 #(32) pcmux3(
    PCPlus4F,             // 0: sequential
    PCTargetE,            // 1: branch or JAL
    JALRTargetE,          // 2: JALR
    PCSrcSelE,             // control: 0=seq, 1=branch/JAL, 2=JALR
    PCNextF
);
    flopenr #(32) pcreg(clk, reset, ~StallF, PCNextF, PCF);
    adder pcadd(PCF, 32'h4, PCPlus4F);

    // Decode stage pipeline register and logic
    flopenrc #(96) regD(clk, reset, FlushD, ~StallD,
                        {InstrF, PCF, PCPlus4F},
                        {InstrD, PCD, PCPlus4D});
    
    assign opD = InstrD[6:0];
    assign funct3D = InstrD[14:12];
    assign funct7b5D = InstrD[30];
    assign Rs1D = InstrD[19:15];
    assign Rs2D = InstrD[24:20];
    assign RdD = InstrD[11:7];
    
    regfile rf(clk, RegWriteW, Rs1D, Rs2D, RdW, ResultW, RD1D, RD2D);
    extend ext(InstrD[31:7], ImmSrcD, ImmExtD);

    // Execute stage pipeline register and logic
    floprc #(175) regE(clk, reset, FlushE,
                       {RD1D, RD2D, PCD, Rs1D, Rs2D, RdD, ImmExtD, PCPlus4D},
                       {RD1E, RD2E, PCE, Rs1E, Rs2E, RdE, ImmExtE, PCPlus4E});
    
    mux3 #(32) faemux(RD1E, ResultW, ALUResultM, ForwardAE, SrcAEforward);
    mux2 #(32) srcamux(SrcAEforward, PCE, ALUSrcAE, SrcAE); // for lui
    mux3 #(32) fbemux(RD2E, ResultW, ALUResultM, ForwardBE, WriteDataE);
    mux2 #(32) srcbmux(WriteDataE, ImmExtE, ALUSrcBE, SrcBE);
    alu alu(SrcAE, SrcBE, ALUControlE, ALUResultE, FlagE);
    assign JALRTargetE = ALUResultE & ~32'b1;// for jalr
    adder branchadd(ImmExtE, PCE, PCTargetE);

    // Memory stage pipeline register
    flopr #(101) regM(clk, reset,
                      {ALUResultE, WriteDataE, RdE, PCPlus4E},
                      {ALUResultM, WriteDataM, RdM, PCPlus4M});
                      
    assign LoadTypeM=LoadType;
    assign StoreTypeM=StoreType;
    
    // Load extension (for loads)
    loadextender lext (
    .LoadType(LoadTypeM),
    .ReadData(ReadDataM),
    .addr_offset(ALUResultM[1:0]),
    .LoadData(LoadDataM)
    );
    
    // Store masking (for stores)
    storemasker smask (
    .StoreType(StoreTypeM),
    .WriteData(WriteDataM),
    .MaskedWriteData(MaskedWriteDataM)
    );
   
    assign WriteData = MaskedWriteDataM;
    // Writeback stage pipeline register and logic
    flopr #(133) regW(clk, reset,
                      {ALUResultM, ReadDataM, RdM, PCPlus4M, LoadDataM},
                      {ALUResultW, ReadDataW, RdW, PCPlus4W, LoadDataW});

    mux3 #(32) resultmux(ALUResultW, LoadDataW, PCPlus4W, ResultSrcW, ResultW);

endmodule