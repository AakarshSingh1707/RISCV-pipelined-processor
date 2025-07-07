module imem(
    input [31:0] a,
    output [31:0] rd
);

    reg [31:0] RAM[126:0];

    initial begin
       /*//$readmemh("riscvtest.txt", RAM);
        RAM[0] = 32'h00500093;
        // 1: addi x2, x0, 5
        RAM[1] = 32'h00500113;
        // 2: addi x3, x0, 3
        RAM[2] = 32'h00300193;
        // 3: addi x4, x0, -1
        RAM[3] = 32'hfff00213;
        // 4: addi x5, x0, 10
        RAM[4] = 32'h00a00293;

        // BEQ: x1 == x2 (should branch)
        // 5: beq x1, x2, +8 (to 8)
         RAM[5] = 32'h00208463;   // beq x1, x2, +8 (was 0020a463)
        // 6: addi x10, x0, 100   (should be skipped)
        RAM[6] = 32'h06400513;
        // 7: addi x10, x0, 1     (should execute)
        RAM[7] = 32'h00100513;

        // BEQ: x1 == x3 (should not branch)
        // 8: beq x1, x3, +8 (to 11)
        RAM[8] = 32'h00308463;   // beq x1, x3, +8 (was 0030a863)
        // 9: addi x11, x0, 2     (should execute)
        RAM[9] = 32'h00200593;
        // 10: addi x11, x0, 200  (should be skipped)
        RAM[10] = 32'h0c805593;

        // BNE: x1 != x3 (should branch)
        // 11: bne x1, x3, +8 (to 14)
        RAM[11] = 32'h00309463;  // bne x1, x3, +8 (was 0030b463)
        // 12: addi x12, x0, 300  (should be skipped)
        RAM[12] = 32'h12c00613;
        // 13: addi x12, x0, 3    (should execute)
        RAM[13] = 32'h00300613;

        // BNE: x1 != x2 (should not branch)
        // 14: bne x1, x2, +8 (to 17)
       RAM[14] = 32'h00209463;  // bne x1, x2, +8 (was 0020b863)
        // 15: addi x13, x0, 4    (should execute)
        RAM[15] = 32'h00400693;
        // 16: addi x13, x0, 400  (should be skipped)
        RAM[16] = 32'h19000693;

        // BLT: x3 < x5 (3 < 10, should branch)
        // 17: blt x3, x5, +8 (to 20)
        RAM[17] = 32'h0051c463;
        // 18: addi x14, x0, 500  (should be skipped)
        RAM[18] = 32'h1f400713;
        // 19: addi x14, x0, 5    (should execute)
        RAM[19] = 32'h00500713;

        // BLT: x5 < x3 (10 < 3, should not branch)
        // 20: blt x5, x3, +8 (to 23)
        RAM[20] = 32'h0032c463;
        // 21: addi x15, x0, 6    (should execute)
        RAM[21] = 32'h00600793;
        // 22: addi x15, x0, 600  (should be skipped)
        RAM[22] = 32'h25800793;

        // BGE: x5 >= x3 (10 >= 3, should branch)
        // 23: bge x5, x3, +8 (to 26)
        RAM[23] = 32'h0032d463;
        // 24: addi x16, x0, 700  (should be skipped)
        RAM[24] = 32'h2bc00813;
        // 25: addi x16, x0, 7    (should execute)
        RAM[25] = 32'h00700813;

        // BGE: x3 >= x5 (3 >= 10, should not branch)
        // 26: bge x3, x5, +8 (to 29)
        RAM[26] = 32'h0051d463;
        // 27: addi x17, x0, 8    (should execute)
        RAM[27] = 32'h00800893;
        // 28: addi x17, x0, 800  (should be skipped)
        RAM[28] = 32'h32000893;

        // BLTU: x3 < x4 (3 < 0xFFFFFFFF, unsigned, should branch)
        // 29: bltu x3, x4, +8 (to 32)
        RAM[29] = 32'h0041e463;
        // 30: addi x18, x0, 900  (should be skipped)
        RAM[30] = 32'h38400913;
        // 31: addi x18, x0, 9    (should execute)
        RAM[31] = 32'h00900913;

        // BLTU: x4 < x3 (0xFFFFFFFF < 3, unsigned, should not branch)
        // 32: bltu x4, x3, +8 (to 35)
        RAM[32] = 32'h00326463;
        // 33: addi x19, x0, 10   (should execute)
        RAM[33] = 32'h00a00993;
        // 34: addi x19, x0, 1000 (should be skipped)
        RAM[34] = 32'h3e800993;

        // BGEU: x4 >= x3 (0xFFFFFFFF >= 3, unsigned, should branch)
        // 35: bgeu x4, x3, +8 (to 38)
        RAM[35] = 32'h00327463;
        // 36: addi x20, x0, 1100 (should be skipped)
        RAM[36] = 32'h44c00a13;
        // 37: addi x20, x0, 11   (should execute)
        RAM[37] = 32'h00b00a13;

        // BGEU: x3 >= x4 (3 >= 0xFFFFFFFF, unsigned, should not branch)
        // 38: bgeu x3, x4, +8 (to 41)
        RAM[38] = 32'h0041f463;
        // 39: addi x21, x0, 12   (should execute)
        RAM[39] = 32'h00c00a93;
        // 40: addi x21, x0, 1200 (should be skipped)
        RAM[40] = 32'h4b000a93;

        // 41: nop (addi x0, x0, 0)
        RAM[41] = 32'h00000013;*/
        
    /*RAM[0] = 32'h00500213;  // addi x4, x0, 5
    RAM[1] = 32'h00300313;  // addi x6, x0, 3  
    RAM[2] = 32'hfff00393;  // addi x7, x0, -1
    RAM[3] = 32'h00a00413;  // addi x8, x0, 10
    
    // BLT test: 3 < 10? YES
    RAM[4] = 32'h00834463;  // blt x6, x8, 8
    RAM[5] = 32'h00000013;  // nop (skipped)
    RAM[6] = 32'h00100513;  // addi x10, x0, 1
    
    // BGE test: 3 >= -1? YES  
    RAM[7] = 32'h00735463;  // bge x6, x7, 8
    RAM[8] = 32'h00000013;  // nop (skipped)
    RAM[9] = 32'h00200513;  // addi x10, x0, 2
    
    // BLTU test: 3 < 0xFFFFFFFF? YES
    RAM[10] = 32'h00736463; // bltu x6, x7, 8
    RAM[11] = 32'h00000013; // nop (skipped)
    RAM[12] = 32'h00300513; // addi x10, x0, 3
    
    // BGEU test: 3 >= 10? NO
    RAM[13] = 32'h00837463; // bgeu x6, x8, 8
    RAM[14] = 32'h00400513; // addi x10, x0, 4 (should execute)
    RAM[15] = 32'h00000013; // nop*/
   
    /*RAM[0] = 32'h12345237;  // lui x4, 0x12345     
    RAM[1] = 32'h00001297;  // auipc x5, 1         
    
    // Test basic arithmetic
    RAM[2] = 32'h00500313;  // addi x6, x0, 5      
    RAM[3] = 32'h00300393;  // addi x7, x0, 3      
    
    // Test JAL - jump exactly to RAM[6]
    RAM[4] = 32'h008000ef;  // jal x1, 8           (PC=0x10, target=0x18=RAM[6])
    RAM[5] = 32'h00100413;  // addi x8, x0, 1      (skipped, executed later via JALR)
    
    // JAL target
    RAM[6] = 32'h00300513;  // addi x10, x0, 3     (x10 = 3)
    
    // JALR back to RAM[5] 
    RAM[7] = 32'h00008067;  // jalr x0, x1, 0      (jump to x1=0x14=RAM[5])
    
    RAM[8] = 32'h00000013;*/
    
    RAM[0] = 32'h00000093; // addi x1, x0, 0
    RAM[1] = 32'h00100113; // addi x2, x0, 1

    // Store first two numbers to memory 0(x0) and 4(x0)
    RAM[2] = 32'h00102023; // sw x1, 0(x0) = 0
    RAM[3] = 32'h00202223; // sw x2, 4(x0) = 1

    // Generate Fibonacci numbers (fully unrolled, storing each result to memory)
    RAM[4]  = 32'h002081B3; // add x3, x1, x2 => 0+1=1
    RAM[5]  = 32'h00302423; // sw x3, 8(x0) => 1
    RAM[6]  = 32'h002000B3; // add x1, x0, x2 => x1=1
    RAM[7]  = 32'h00300133; // add x2, x0, x3 => x2=1

    RAM[8]  = 32'h002081B3; // add x3, x1, x2 => 1+1=2
    RAM[9]  = 32'h00302623; // sw x3, 12(x0) => 2
    RAM[10] = 32'h002000B3; // add x1, x0, x2 => x1=1
    RAM[11] = 32'h00300133; // add x2, x0, x3 => x2=2

    RAM[12] = 32'h002081B3; // add x3, x1, x2 => 1+2=3
    RAM[13] = 32'h00302823; // sw x3, 16(x0) => 3
    RAM[14] = 32'h002000B3; // add x1, x0, x2 => x1=2
    RAM[15] = 32'h00300133; // add x2, x0, x3 => x2=3

    RAM[16] = 32'h002081B3; // add x3, x1, x2 => 2+3=5
    RAM[17] = 32'h00302A23; // sw x3, 20(x0) => 5
    RAM[18] = 32'h002000B3; // add x1, x0, x2 => x1=3
    RAM[19] = 32'h00300133; // add x2, x0, x3 => x2=5

    RAM[20] = 32'h002081B3; // add x3, x1, x2 => 3+5=8
    RAM[21] = 32'h00302C23; // sw x3, 24(x0) => 8
    RAM[22] = 32'h002000B3; // add x1, x0, x2 => x1=5
    RAM[23] = 32'h00300133; // add x2, x0, x3 => x2=8

    RAM[24] = 32'h002081B3; // add x3, x1, x2 => 5+8=13
    RAM[25] = 32'h00302E23; // sw x3, 28(x0) => 13
    RAM[26] = 32'h002000B3; // add x1, x0, x2 => x1=8
    RAM[27] = 32'h00300133; // add x2, x0, x3 => x2=13

    RAM[28] = 32'h002081B3; // add x3, x1, x2 => 8+13=21
    RAM[29] = 32'h003020A3; // sw x3, 32(x0) => 21
    RAM[30] = 32'h002000B3; // add x1, x0, x2 => x1=13
    RAM[31] = 32'h00300133; // add x2, x0, x3 => x2=21

    RAM[32] = 32'h002081B3; // add x3, x1, x2 => 13+21=34
    RAM[33] = 32'h003022A3; // sw x3, 36(x0) => 34
    RAM[34] = 32'h002000B3; // add x1, x0, x2 => x1=21
    RAM[35] = 32'h00300133; // add x2, x0, x3 => x2=34

    RAM[36] = 32'h002081B3; // add x3, x1, x2 => 21+34=55
    RAM[37] = 32'h003024A3; // sw x3, 40(x0) => 55
    RAM[38] = 32'h002000B3; // add x1, x0, x2 => x1=34
    RAM[39] = 32'h00300133; // add x2, x0, x3 => x2=55

    RAM[40] = 32'h002081B3; // add x3, x1, x2 => 34+55=89
    RAM[41] = 32'h003026A3; // sw x3, 44(x0) => 89
    RAM[42] = 32'h002000B3; // add x1, x0, x2 => x1=55
    RAM[43] = 32'h00300133; // add x2, x0, x3 => x2=89

    RAM[44] = 32'h002081B3; // add x3, x1, x2 => 55+89=144
    RAM[45] = 32'h003028A3; // sw x3, 48(x0) => 144
    RAM[46] = 32'h002000B3; // add x1, x0, x2 => x1=89
    RAM[47] = 32'h00300133; // add x2, x0, x3 => x2=144

    RAM[48] = 32'h002081B3; // add x3, x1, x2 => 89+144=233
    RAM[49] = 32'h00302AA3; // sw x3, 52(x0) => 233
    RAM[50] = 32'h002000B3; // add x1, x0, x2 => x1=144
    RAM[51] = 32'h00300133; // add x2, x0, x3 => x2=233

    RAM[52] = 32'h002081B3; // add x3, x1, x2 => 144+233=377
    RAM[53] = 32'h00302CA3; // sw x3, 56(x0) => 377
    RAM[54] = 32'h002000B3; // add x1, x0, x2 => x1=233
    RAM[55] = 32'h00300133; // add x2, x0, x3 => x2=377

    RAM[56] = 32'h002081B3; // add x3, x1, x2 => 233+377=610
    RAM[57] = 32'h00302EA3; // sw x3, 60(x0) => 610
    RAM[58] = 32'h002000B3; // add x1, x0, x2 => x1=377
    RAM[59] = 32'h00300133; // add x2, x0, x3 => x2=610

    RAM[60] = 32'h002081B3; // add x3, x1, x2 => 377+610=987
    RAM[61] = 32'h00302023; // sw x3, 64(x0) => 987
    RAM[62] = 32'h002000B3; // add x1, x0, x2 => x1=610
    RAM[63] = 32'h00300133; // add x2, x0, x3 => x2=987

    RAM[64] = 32'h002081B3; // add x3, x1, x2 => 610+987=1597
    RAM[65] = 32'h00302223; // sw x3, 68(x0) => 1597
    RAM[66] = 32'h002000B3; // add x1, x0, x2 => x1=987
    RAM[67] = 32'h00300133; // add x2, x0, x3 => x2=1597

    RAM[68] = 32'h002081B3; // add x3, x1, x2 => 987+1597=2584
    RAM[69] = 32'h00302423; // sw x3, 72(x0) => 2584
    RAM[70] = 32'h002000B3; // add x1, x0, x2 => x1=1597
    RAM[71] = 32'h00300133; // add x2, x0, x3 => x2=2584

    RAM[72] = 32'h002081B3; // add x3, x1, x2 => 1597+2584=4181
    RAM[73] = 32'h00302623; // sw x3, 76(x0) => 4181
    RAM[74] = 32'h002000B3; // add x1, x0, x2 => x1=2584
    RAM[75] = 32'h00300133; // add x2, x0, x3 => x2=4181
    
    RAM[76] = 32'h002081B3; // add x3, x1, x2 => 2584+4181=6765
    RAM[77] = 32'h00302423; // sw x3, 80(x0) => 6765
    RAM[78] = 32'h00000093; // addi x1, x0, 0
    RAM[79] = 32'h00100113; // addi x2, x0, 1
    RAM[80] = 32'hEC1FF0EF; // jal x0, -320 (go back to RAM[0])
      
     /*RAM[0] = 32'h00000137;   // lui x2, 0x0      - Load upper immediate (base address)
RAM[1] = 32'h10010113;   // addi x2, x2, 256 - x2 = 256 (base address)
RAM[2] = 32'h00100193;   // addi x3, x0, 1   - x3 = 1
RAM[3] = 32'h00200213;   // addi x4, x0, 2   - x4 = 2
RAM[4] = 32'h00300293;   // addi x5, x0, 3   - x5 = 3
RAM[5] = 32'h00400313;   // addi x6, x0, 4   - x6 = 4
RAM[6] = 32'h00500393;   // addi x7, x0, 5   - x7 = 5
RAM[7] = 32'h00600413;   // addi x8, x0, 6   - x8 = 6
RAM[8] = 32'h00312023;   // sw x3, 0(x2)     - Store x3 at address x2
RAM[9] = 32'h00412223;   // sw x4, 4(x2)     - Store x4 at address x2 + 4
RAM[10] = 32'h00512423;  // sw x5, 8(x2)     - Store x5 at address x2 + 8
RAM[11] = 32'h00612623;  // sw x6, 12(x2)    - Store x6 at address x2 + 12
RAM[12] = 32'h00712823;  // sw x7, 16(x2)    - Store x7 at address x2 + 16
RAM[13] = 32'h00812a23;  // sw x8, 20(x2)    - Store x8 at address x2 + 20
RAM[14] = 32'h00012483;  // lw x9, 0(x2)     - Load word from x2 into x9
RAM[15] = 32'h00412503;  // lw x10, 4(x2)    - Load word from x2 + 4 into x10
RAM[16] = 32'h00812583;  // lw x11, 8(x2)    - Load word from x2 + 8 into x11
RAM[17] = 32'h00c12603;  // lw x12, 12(x2)   - Load word from x2 + 12 into x12
RAM[18] = 32'h01012683;  // lw x13, 16(x2)   - Load word from x2 + 16 into x13
RAM[19] = 32'h01412703;  // lw x14, 20(x2)   - Load word from x2 + 20 into x14
RAM[20] = 32'h00310023;  // sb x3, 0(x2)     - Store byte from x3 at x2
RAM[21] = 32'h004100a3;  // sb x4, 1(x2)     - Store byte from x4 at x2 + 1
RAM[22] = 32'h00510123;  // sb x5, 2(x2)     - Store byte from x5 at x2 + 2
RAM[23] = 32'h00010783;  // lb x15, 0(x2)    - Load byte from x2 into x15
RAM[24] = 32'h00110803;  // lb x16, 1(x2)    - Load byte from x2 + 1 into x16
RAM[25] = 32'h00210883;  // lb x17, 2(x2)    - Load byte from x2 + 2 into x17
RAM[26] = 32'h00311023;  // sh x3, 0(x2)     - Store half-word from x3 at x2
RAM[27] = 32'h00411123;  // sh x4, 2(x2)     - Store half-word from x4 at x2 + 2
RAM[28] = 32'h00011903;  // lh x18, 0(x2)    - Load half-word from x2 into x18
RAM[29] = 32'h00211983;  // lh x19, 2(x2)    - Load half-word from x2 + 2 into x19
RAM[30] = 32'h0000006f;  // jal x0, 0        - Jump to self (infinite loop)*/


      end
    assign rd = RAM[a[31:2]]; // word aligned

endmodule
