# FIFO
synchronous FIFO(First In First Out)  Design using Verilog

Project Description
A FIFO (First-In, First-Out) buffer is a widely used memory structure in digital systems.
It works like a queue: the first data written is the first data read, preserving order.

FIFO is commonly used in:

Data buffering between producer and consumer modules

Bridging modules working at different speeds

Communication protocols (UART, SPI, AXI stream, etc.)

🔹 Features

Configurable data width and depth (parameterized)

Synchronous FIFO design (single clock)

Implements read/write pointers

Provides status flags:

full → FIFO is full, cannot write

empty → FIFO is empty, cannot read

count → Tracks number of stored elements

🔹 How It Works

Write Operation

Data is written when write_en is high and FIFO is not full.

Write pointer increments after each write.

Read Operation

Data is read when read_en is high and FIFO is not empty.

Read pointer increments after each read.

Status Signals

full goes high when FIFO reaches max depth.

empty goes high when no data is available.

count keeps track of how many entries are stored.

🔹 Usage

Modify parameters (DATA_WIDTH, DEPTH) as per requirement.

Integrate into your design as a buffer between modules.

Use with a testbench to verify functionality.

🔹 Simulation

To simulate 
vlog fifo.v
vlog tb.v
vlog tb

Output Waveform:
![fifo waveform](https://github.com/user-attachments/assets/7ff1e037-4841-423a-9ae5-e98bafe05b6b)

