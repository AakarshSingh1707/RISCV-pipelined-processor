module tb_top;

    reg clk;
    reg reset;
    wire [31:0] WriteData, DataAdrM;
    wire MemWriteM;

    // Instantiate the top module
    top uut (
        .clk(clk),
        .reset(reset),
        .WriteData(WriteData),
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
        #20;            // Hold reset high for 20ns
        reset = 0;
        
        // Run simulation for 1000ns (adjust as needed)
        #1000;
        $finish;
    end

    // Optional: Monitor outputs
    /*initial begin
        $monitor("Time=%0t, PC=%h, MemWrite=%b, Addr=%h, Data=%h", 
                  $time, uut.PCF, MemWriteM, DataAdrM, WriteDataM);
        $monitor("Time=%0t PCF=%h PCNextF=%h PCSrcSelE=%b PCPlus4F=%h PCTargetE=%h JALRTargetE=%h StallF=%b reset=%b",
    $time,
    uut.PCF,                // PCF from riscv (top-level output)
    uut.riscv.dp.PCNextF,         // PCNextF from datapath
    uut.riscv.c.PCSrcSelE,        // PCSrcSelE from controller
    uut.riscv.dp.PCPlus4F,        // PCPlus4F from datapath
    uut.riscv.dp.PCTargetE,       // PCTargetE from datapath
    uut.riscv.dp.JALRTargetE,     // JALRTargetE from datapath
    uut.riscv.dp.StallF,          // StallF from datapath or top
    uut.reset               // reset from top
);
$display("PCPlus4F = %h, bits = %b", uut.riscv.dp.PCPlus4F, uut.riscv.dp.PCPlus4F);
$display("PCF = %h, bits = %b", uut.PCF, uut.PCF);
    end*/
    
   
endmodule

