module floprc #(parameter WIDTH = 8) (
    input               clk,
    input               reset,
    input               clear,
    input  [WIDTH-1:0]  d,
    output [WIDTH-1:0]  q
);

    reg [WIDTH-1:0] q_reg;
    assign q = q_reg;

    always @(posedge clk or posedge reset) begin
        if (reset)
            q_reg <= {WIDTH{1'b0}};
        else if (clear)
            q_reg <= {WIDTH{1'b0}};
        else
            q_reg <= d;
    end

endmodule

