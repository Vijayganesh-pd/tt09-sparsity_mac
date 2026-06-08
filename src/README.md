# tt09-sparsity_mac

A hardware-efficient, **Sparsity-Aware Multiply-Accumulate (MAC) Unit** designed for AI accelerators and Digital Signal Processing (DSP) applications. This chip was completely implemented and verified using the open-source **OpenLane ASIC Flow** on **Linux Ubuntu**.

## 🚀 Project Overview
Standard MAC units process every single incoming operand, consuming unnecessary dynamic power even when multiplying by zero. This project implements a **sparsity-aware architecture** that automatically detects zero-value inputs (`A == 0` or `B == 0`) and skips the multiplication stage. 

### 🌟 Key Features:
- **Zero-Detection Logic:** Bypasses energy-heavy multiplier arrays when inputs are zero.
- **Dynamic Power Savings:** Significant reduction in switching activity tailored for sparse neural network inferences (CNNs/RNNs).
- **Automated ASIC Pipeline:** Fully hardened from RTL to GDSII using open-source EDA tools.

## 🛠️ ASIC Design Flow (OpenLane Pipeline)
The entire physical design cycle was automated and verified using the **OpenLane flow** with the following steps:
1. **RTL Synthesis:** Converted Verilog source logic into a gate-level netlist using *Yosys*.
2. **Floorplanning & PDN:** Fixed the core/die area and created the Power Distribution Network.
3. **Placement & CTS:** Optimized standard cell placements and minimized clock skew using *TritonCTS*.
4. **Routing:** Finished global and detailed routing with zero DRC/LVS violations using *OpenROAD*.
5. **Physical Verification:** Checked routing and layouts in **KLayout** to view final GDSII structures.
6. **Functional Simulation:** Monitored correct behavior via testbenches and analyzed waveform outputs.

## 📁 Repository Structure
- `/src` - Contains the main Verilog source code and architecture files.
- `/runs` - OpenLane signoff outputs, timing reports, and physical layout data.
- `config.json` - Configuration profile for the OpenLane automated implementation.

