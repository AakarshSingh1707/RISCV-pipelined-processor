Demo Video  
[Watch the project demo here](https://drive.google.com/file/d/1yRITuGxDKUnmVvOb6AkxgjBrZaRl-SAa/view?usp=drive_link) 

RV32I 5‑Stage Pipelined CPU (Basys‑3)
A classic 5‑stage RV32I pipeline (IF, ID, EX, MEM, WB) with forwarding, load‑use stall, and branch flush, validated via self‑checking testbenches and FPGA bring‑up.

Overview
Five pipeline stages with hazard detection and forwarding units.

Branch resolved in EX; taken branches/jumps flush earlier stages.

Hardware demo on Basys‑3: Fibonacci on 7‑segment/LEDs; logic inspected during bring‑up.

Repository layout
src/: RTL (alu, regfile, control, imem, dmem, hazard_unit, forwarding_unit, if_id/id_ex/ex_mem/mem_wb regs, top_pipeline).

Features
Data hazards: EX/MEM→ID/EX forwarding; load‑use stall insertion.

Control hazards: pipeline flush on taken branch/jump; PC select logic.

ALU ops and loads/stores per RV32I; memory alignment enforced.

Quick start — Simulation
Prereqs: <Icarus/Verilator/Questa>, <Make>.

Example (Icarus):

iverilog -g2012 -o build/pipe_tb tb/pipe_tb.sv src/*.sv

vvp build/pipe_tb # expect “ALL TESTS PASS”

make test # runs hazard and ISA regressions, logs in logs/*.log

Quick start — FPGA (Basys‑3)
Tools: Vivado <20XX.X>, Board: Basys‑3, Top: <top_pipeline.sv>, XDC: fpga/basys3.xdc.

vivado -mode tcl -source fpga/build.tcl

Program bitstream; verify Fibonacci on 7‑seg; LEDs can trace state/hazard signals.

Hazard handling
Forwarding paths: EX/MEM results bypassed to dependent instructions in ID/EX.

Stall conditions: load‑use when ID consumes MEM read; inserts a bubble.

Flush: on taken branch/jump, IF/ID invalidated; PC updated to target.

Verification
Self‑checking TBs compare architectural state and memory traces.

Corner cases: branch‑after‑load, back‑to‑back branches, sign‑ext loads.

Waveforms captured for forwarding/stall events.

Results
Regression passing on commit <hash>; observed correct forwarding/stall in waves.

Basys‑3 bring‑up validated via LEDs/logic inspection.

Notes and limits
RV32I subset only; no CSR/interrupts yet; memory system simplified for FPGA demo.

Roadmap
Add CSR/interrupts, simple cache/MMIO, AXI‑Lite wrapper for Zynq integration.

License
<MIT/BSD/Apache‑2.0>

Maintainer
Aakarsh Singh — contact in profile.



