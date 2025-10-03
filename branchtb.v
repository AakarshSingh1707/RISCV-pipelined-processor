module branchtb;

    reg clk;
    reg reset;
    wire [31:0] WriteDataM, DataAdrM;
    wire MemWriteM;

    // Instantiate the top module
    top uut (
        .clk(clk),
        .reset(reset),
        .WriteDataM(WriteDataM),
        .DataAdrM(DataAdrM),
        .MemWriteM(MemWriteM)
    );

    // Clock generation: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset logic and simulation control
    initial begin
        reset = 1;
        #20;
        reset = 0;
        #1000; // Run long enough for your program
        $finish;
    end

    // Debug monitor for branch-related signals
    /*initial begin
        $display("Time\tPCF\tInstrF\tBranchE\tfunct3E\tFlagE\tTakenE\tPCSrcE");
        $monitor("%0t\t%h\t%h\t%b\t%b\t%b\t%b\t%b",
            $time,
            uut.PCF, // Program Counter
            uut.InstrF, // Current fetched instruction
            uut.riscv.c.BranchE, // Branch control in EX stage
            uut.riscv.c.funct3E, // funct3 in EX stage
            uut.riscv.dp.FlagE, // ALU flags in EX stage
            uut.riscv.c.takenE, // Branch taken signal
            uut.riscv.c.PCSrcE // PC source select
        );
    end*/
    initial begin
    $monitor("Time=%0t, BranchD=%b, BranchE=%b, floprc_q=%b, FlushE=%b", 
        $time, uut.riscv.c.BranchD, uut.riscv.c.BranchE, uut.riscv.c.controlregE.q[4], uut.riscv.FlushE);
end


endmodule
