# OpenLane Project

ASIC implementation of a 5-part digital design project using OpenLane and the Sky130 PDK. Each part builds upon the previous, culminating in a fully integrated half-CPU system with peripheral I/O.

---

## Project Overview

| Part | Module | Description |
|------|--------|-------------|
| Part 1 | `alu` | 8-bit ALU with 8 operations |
| Part 2 | `alu_flags` | 8-bit ALU with carry, overflow, zero, sign flags |
| Part 3 | `register_file` | 16-bit register file with read/write |
| Part 4 | `cpu_top` | Half CPU: ALU + register file + instruction decoder |
| Part 5 | `full_system` | Half CPU + button debouncer + 7-segment display |

---

## Tools & Technology

- **OpenLane** v1.0.2 — RTL-to-GDS flow
- **Sky130A** — SkyWater 130nm open-source PDK
- **Standard Cell Library** — `sky130_fd_sc_hd`
- **Simulator** — Verilator (linting), Yosys (synthesis)
- **Layout Viewer** — KLayout

---

## Part 1 — 8-bit ALU

### Description
A purely combinational 8-bit ALU supporting 8 operations. The output is 16-bit to accommodate the full range of the multiplication result.

### Operations

| `op[2:0]` | Operation |
|-----------|-----------|
| `000` | Addition |
| `001` | Subtraction |
| `010` | Multiplication |
| `011` | Division (divide-by-zero protected) |
| `100` | Bitwise AND |
| `101` | Bitwise OR |
| `110` | Bitwise NOT (unary, uses A only) |
| `111` | Bitwise XOR |

### Ports
| Port | Width | Direction | Description |
|------|-------|-----------|-------------|
| `A` | 8-bit | Input | Operand A |
| `B` | 8-bit | Input | Operand B |
| `op` | 3-bit | Input | Operation select |
| `Y` | 16-bit | Output | Result |

---

## Part 2 — 8-bit ALU with Flag Bits

### Description
Extends Part 1 with four status flag outputs for use in control flow and condition checking.

### Flag Bits

| Flag | Description |
|------|-------------|
| `carry` | Carry out from addition/subtraction |
| `overflow` | Signed overflow for addition/subtraction |
| `zero` | High when output is zero |
| `sign` | High when result is negative (bit 7) |

### Ports
Same as Part 1, with additional outputs: `carry`, `overflow`, `zero`, `sign`.

---

## Part 3 — 16-bit Register File

### Description
A synchronous register file with 16 general-purpose 16-bit registers. Supports simultaneous read and write. Write is synchronous (clock-edge triggered); read is asynchronous.

### Ports
| Port | Width | Direction | Description |
|------|-------|-----------|-------------|
| `clk` | 1-bit | Input | Clock |
| `rst` | 1-bit | Input | Synchronous reset |
| `we` | 1-bit | Input | Write enable |
| `address` | 16-bit | Input | Register address (lower 4 bits used) |
| `data_in` | 16-bit | Input | Data to write |
| `data_out` | 16-bit | Output | Data read |

---

## Part 4 — Half CPU

### Description
A simple single-cycle CPU integrating the ALU, register file, and instruction decoder. Uses two register file instances: one as instruction memory and one as a data/register file.

### Instruction Format

```
[15:12] opcode
[11:8]  Ra (source A)
[7:4]   Rb (source B)
[3:0]   Rd (destination)
```

### ALU Operations

| Opcode | Operation |
|--------|-----------|
| `0000` | ADD |
| `0001` | SUB |
| `0010` | SHL |
| `0011` | SHR |
| `0100` | AND |
| `0101` | OR |
| `0110` | NOT |
| `0111` | XOR |
| `1111` | HALT |

### Architecture

```
Instruction Memory → Decoder → Register File (Ra, Rb) → ALU → Register File (Rd)
                                                                      ↑
                                                               PC counter
```

### Ports
| Port | Width | Direction | Description |
|------|-------|-----------|-------------|
| `clk` | 1-bit | Input | Clock |
| `rst` | 1-bit | Input | Reset |
| `result` | 8-bit | Output | ALU result |
| `pc_out` | 16-bit | Output | Current program counter |

---

## Part 5 — Full System

### Description
Integrates the half CPU from Part 4 with a button debouncer, one-pulse generator, and a 7-segment display multiplexer. The CPU result is displayed on the 7-segment display in hexadecimal.

### Submodules

| Module | Description |
|--------|-------------|
| `cpu_top` | Half CPU from Part 4 |
| `debounce` | Synchronizes and debounces button input |
| `one_pulse` | Converts debounced button to single-cycle pulse |
| `sevenseg_mux` | Multiplexed 2-digit 7-segment display driver |

### Ports
| Port | Width | Direction | Description |
|------|-------|-----------|-------------|
| `clk` | 1-bit | Input | Clock |
| `rst` | 1-bit | Input | Reset |
| `btn_step` | 1-bit | Input | Step button input |
| `seg` | 7-bit | Output | 7-segment cathode signals |
| `dp` | 1-bit | Output | Decimal point |
| `an` | 2-bit | Output | Digit anode select |

---

## Directory Structure

```
designs/
├── part1_alu/
│   ├── src/alu.v
│   ├── config.json
│   └── pin_order.cfg
├── part2_alu_flags/
│   ├── src/alu_flags.v
│   ├── config.json
│   └── pin_order.cfg
├── part3_regfile/
│   ├── src/
│   │   ├── register_file.v
│   │   └── register_file.sdc
│   ├── config.json
│   └── pin_order.cfg
├── part4_halfcpu/
│   ├── src/
│   │   ├── alu.v
│   │   ├── register_file.v
│   │   ├── decoder.v
│   │   ├── cpu_top.v
│   │   └── cpu_top.sdc
│   ├── config.json
│   └── pin_order.cfg
└── part5_full/
    ├── src/
    │   ├── alu.v
    │   ├── register_file.v
    │   ├── decoder.v
    │   ├── cpu_top.v
    │   ├── debouncer.v
    │   ├── seven_seg.v
    │   ├── full_system.v
    │   └── full_system.sdc
    ├── config.json
    └── pin_order.cfg
```

---

## Running the Flow

### Using Make

Run from the project root without entering the Docker container:

```bash
make part1        # Run Part 1 only
make part2        # Run Part 2 only
make part3        # Run Part 3 only
make part4        # Run Part 4 only
make part5        # Run Part 5 only
make all          # Run all 5 parts sequentially
make gds          # Show GDS output paths for all parts
make clean        # Remove all run directories
make clean_part3  # Remove runs for a specific part
make help         # Show all available commands
```

### Manually (inside Docker container)

```bash
cd ~/user/projects/OpenLane
make mount

# Inside the container:
./flow.tcl -design part1_alu
./flow.tcl -design part2_alu_flags
./flow.tcl -design part3_regfile
./flow.tcl -design part4_halfcpu
./flow.tcl -design part5_full
```

### Viewing GDS Output

```bash
open -a KLayout designs/part1_alu/runs/RUN_.../results/final/gds/alu.gds
```

---

## Notes

- All designs target the **Sky130A** PDK with the `sky130_fd_sc_hd` standard cell library
- Timing optimization steps are disabled for combinational designs (Parts 1 & 2)
- `GRT_ALLOW_CONGESTION` is enabled for Parts 3–5 due to the complexity of the register file
- `initial` blocks and Xilinx-specific primitives have been removed for ASIC compatibility
- Memory arrays are implemented as flip-flop banks (not SRAM macros) for compatibility with the OpenLane flow

---

## Course Information

**Course:** CSE224 — Digital Design  
**University:** Yeditepe University  
