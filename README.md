# **Computation Storage Architecture Design**

## **1. Introduction**
In conventional CPU architectures, performing an arithmetic operation like `result = op1 (+/-/*/..) op2` on data saved in memory requires several steps:
- The host needs to:
  1. Send a **memory read** command to retrieve `op1`.
  2. Send a **memory read** command to retrieve `op2`.
  3. Send the **arithmetic command** (e.g., addition, subtraction, multiplication, etc.) for `op1` and `op2`.
  4. Send a **memory write** command to store the result at another memory address.

In **Computation Storage Architectures**, the process can be condensed into one command:
- The host sends a single command with:
  1. Address 1 to read `op1`.
  2. Address 2 to read `op2`.
  3. The operation to be performed (e.g., add, sub, etc.).
  4. A write address to store the result.
  
The **DUT (Design Under Test)** handles the entire operation internally.

## **2. Language & Platforms**
- **Language**: SystemVerilog.
- **Target Platforms**: 
  - Simulation.
  - Emulation.
  - FPGA.

## **3. Memory Preloading**
- **Initialization**: Memory can be initialized via `readmemh`.
- **Preloading**: Preload memory using a generated file from any script.

## **4. Testing**
- **Testing Framework**: 
  - **UVM (Universal Verification Methodology)** is preferred, though SystemVerilog is also acceptable.
  - Testing covers **four operations**.
  - Testing Tool: **Questa**.
- **Memory Comparison**: Compared final memory contents with the preloaded file using a python script.

## **5. Documentation**
- **Project Structure**: Proper documentation of the project structure is included.
