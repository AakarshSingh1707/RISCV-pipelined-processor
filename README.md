

# RV32I CPU —  5-Stage Pipeline (Basys-3)

FPGA‑proven RV32I cores with self‑checking verification; implements forwarding, stall, and flush; runs a demo program on hardware.

## Overview
- Classic 5‑stage pipeline: IF, ID, EX, MEM, WB.
- Hazard handling: data forwarding, load‑use stall, branch/jump flush; branch resolved in EX.
- Hardware demo on Basys‑3: Fibonacci displayed on 7‑segment/LEDs.

## Repository layout
- src/: RTL (alu, regfile, control/decoder, imem, dmem, hazard_unit, forwarding_unit, pipeline_regs).
- tb/: Self‑checking testbenches and ISA‑level tests.
- sim/: Scripts and wave configs (e.g., Icarus/Verilator/Questa).
- fpga/: Top module, XDC constraints, board files, build Tcl.
- sw/asm/: Minimal RISC‑V programs (fib.S, branches.S, loads.S).

## Features
- ALU ops: add, sub, and, or, xor, slt, sltu, sll, srl, sra; byte/half/word loads/stores.
- Branches/jumps with PC select and pipeline flush on taken control transfers.
- Self‑checking verification for ALU, branch, and load/store paths.

## Quick start — FPGA (Basys‑3)
Tools: Vivado <2025.1>. Board: Basys‑3. Top: <top_basys3.sv>. Constraints: fpga/basys3.xdc.
- Open project or run: vivado -mode tcl -source fpga/build.tcl
- Generate bitstream and program board.
- Demo I/O: 7‑segment shows Fibonacci; LEDs indicate <state/hazard/debug>. Pin map in XDC.

## Design details
- Datapath: PC, imem, dmem, regfile, ALU, branch unit, pipeline regs.
- Control: instruction decoder, hazard detection, forwarding, PC select/flush logic.
- Branch resolution: in EX; flush IF/ID when taken; PC mux chooses target vs PC+4.

## Hazards
- Data hazards: EX/MEM→ID/EX forwarding; stall on load‑use when ID consumes MEM read.
- Control hazards: flush on taken branch/jump; signals: flush_ifid, stall_idex (documented in code).

## Verification
- Self‑checking TBs compare architectural state (regs/mem) to expected outputs.
- Directed + ISA tests for branch‑after‑load, back‑to‑back branches, sign‑extended loads.
- Run: make test; logs in logs/*.log; expect “ALL TESTS PASS”.

## Results
- Hardware: Basys‑3 run shows Fibonacci sequence on 7‑seg/LEDs.

## Requirements
- Tools: Vivado <20XX.X>, <Icarus/Verilator/Questa>.
- Hardware: Basys‑3; optional ZC702 for AXI demo.

## How to reproduce
- make clean && make sim  # expect PASS logs in logs/
- make fpga               # bitstream at fpga/build/<top>.bit
- Known limits: RV32I subset only; no CSR/interrupts yet.

## License
- <MIT/BSD/Apache‑2.0>

## Maintainer
- Aakarsh Singh — contact: <>.


