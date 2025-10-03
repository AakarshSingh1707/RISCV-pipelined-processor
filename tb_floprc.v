module tb_floprc;
    reg clk, reset, clear;
    reg [13:0] d;
    wire [13:0] q;

    floprc #(14) dut(.clk(clk), .reset(reset), .clear(clear), .d(d), .q(q));

    initial begin
        clk = 0; reset = 1; clear = 0; d = 14'b0;
        #10 reset = 0;
        #10 d = 14'b00001000000000; // Only BranchD = 1
        #10 clk = 1; #10 clk = 0;
        #10 $display("q = %b", q); // Should show BranchE = 1 at q[4]
        $finish;
    end
endmodule
