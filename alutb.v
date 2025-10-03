module tb_alu;
    reg [31:0] a, b;
    reg [3:0] alucontrol;
    wire [31:0] result;
    wire [3:0] flags;

    alu uut(.a(a), .b(b), .alucontrol(alucontrol), .result(result), .flags(flags));

    initial begin
        a = 32'd5; b = 32'd5; alucontrol = 4'b0000; // add
        #10;
        $display("ADD: result=%d flags=%b", result, flags);

        a = 32'd5; b = 32'd5; alucontrol = 4'b0001; // sub
        #10;
        $display("SUB: result=%d flags=%b", result, flags);

        a = 32'd5; b = 32'd5; alucontrol = 4'b0010; // and
        #10;
        $display("AND: result=%d flags=%b", result, flags);

        // Add more cases as needed
        $finish;
    end
endmodule

