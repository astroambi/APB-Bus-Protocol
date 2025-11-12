#🧠 APB Slave FSM – UVM Verification Project
📘 Overview

This project implements an APB (Advanced Peripheral Bus) Slave Finite State Machine (FSM) in SystemVerilog, designed to perform and verify read/write transactions on an APB bus.
The goal is to simulate real-world APB slave behavior, including wait states, address validation, and error responses — while verifying the DUT using UVM (Universal Verification Methodology).

⚙️ Key Features

🧩 8 Memory-Mapped Registers:
Supports 8 registers (8-bit each) for read/write operations.

⏱️ Wait-State Insertion:
Simulates delayed slave responses to emulate realistic peripheral behavior.

🚫 Error Detection:
Performs address boundary checks and asserts error signals on invalid accesses.

🔁 Protocol Compliance:
Generates PREADY and PSLVERR signals following APB protocol timing.

🧠 Synthesizable Design:
Can be synthesized for FPGA or ASIC targets if required.

🧪 UVM Verification Environment

This design is verified using a UVM-based testbench, which includes the following components:

Component	Description
Sequencer	Generates APB read/write transactions.
Driver	Drives APB signals according to UVM sequences.
Monitor	Observes bus activity and reports transactions.
Scoreboard	Compares expected vs actual DUT responses for verification.
Environment	Connects all UVM components and manages simulation flow.
Test	Configures stimulus, environment, and DUT for simulation.

This setup enables functional verification of:

Protocol compliance

Wait-state handling

Error signaling

Data integrity during transactions
