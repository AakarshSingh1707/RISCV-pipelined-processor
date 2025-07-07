
module dmem(
    input clk, we,
    input  [1:0]  StoreType,
    input [31:0] a, wd,
    output [31:0] rd
 );

    reg [31:0] RAM[126:0];

    wire [31:0] old_word = RAM[a[31:2]];
    wire [1:0]  byte_offset = a[1:0];

    always @(posedge clk) begin
        if (we) begin
            case (StoreType)
                2'b01: begin // SB
                    case (byte_offset)
                        2'b00: RAM[a[31:2]] <= {old_word[31:8], wd[7:0]};
                        2'b01: RAM[a[31:2]] <= {old_word[31:16], wd[7:0], old_word[7:0]};
                        2'b10: RAM[a[31:2]] <= {old_word[31:24], wd[7:0], old_word[15:0]};
                        2'b11: RAM[a[31:2]] <= {wd[7:0], old_word[23:0]};
                    endcase
                end
                2'b10: begin // SH
                    case (byte_offset[1])
                        1'b0: RAM[a[31:2]] <= {old_word[31:16], wd[15:0]};
                        1'b1: RAM[a[31:2]] <= {wd[15:0], old_word[15:0]};
                    endcase
                end
                2'b11: begin // SW
                    RAM[a[31:2]] <= wd;
                end
            endcase
        end
    end

    assign rd = RAM[a[31:2]];
    


endmodule

   


