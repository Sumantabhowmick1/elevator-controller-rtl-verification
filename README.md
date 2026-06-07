# Elevator Controller RTL Design and Verification

## Overview

This project implements a Finite State Machine (FSM) based Elevator Controller using Verilog HDL and verifies its functionality using SystemVerilog. The controller supports four floors: Ground Floor (0), First Floor (1), Second Floor (2), and Third Floor (3).

The design processes floor requests, controls elevator movement, handles emergency conditions, and transitions between states based on user requests and current floor position.

---

## Project Objectives

* Design an FSM-based Elevator Controller using Verilog HDL.
* Implement floor request handling logic.
* Control upward and downward elevator movement.
* Implement emergency stop functionality.
* Verify the design using SystemVerilog testbench.
* Analyze simulation waveforms and state transitions.

---

## FSM States

| State     | Encoding | Description                                 |
| --------- | -------- | ------------------------------------------- |
| IDLE      | 2'b00    | Elevator waits for floor requests           |
| MOVE_UP   | 2'b01    | Elevator moves towards a higher floor       |
| MOVE_DOWN | 2'b10    | Elevator moves towards a lower floor        |
| EMERGENCY | 2'b11    | Elevator stops immediately during emergency |

---

## State Transition Logic

### IDLE State

* If `request_floor > current_floor` → MOVE_UP
* If `request_floor < current_floor` → MOVE_DOWN
* If `request_floor == current_floor` → Remain in IDLE
* If `emergency = 1` → EMERGENCY

### MOVE_UP State

* Elevator increments floor count.
* If `current_floor == request_floor` → IDLE
* If `emergency = 1` → EMERGENCY

### MOVE_DOWN State

* Elevator decrements floor count.
* If `current_floor == request_floor` → IDLE
* If `emergency = 1` → EMERGENCY

### EMERGENCY State

* Elevator remains stopped.
* If `emergency = 0` → IDLE

---

## Features

* FSM-based RTL Design
* Four-Floor Elevator Control
* Emergency Handling Logic
* Floor Request Processing
* Verilog HDL Implementation
* SystemVerilog Functional Verification
* Simulation Waveform Analysis
* GitHub Project Documentation

---

## Directory Structure

```text
elevator-controller-rtl-verification
│
├── rtl
│   └── elevator_controller.v
│
├── tb
│   └── elevator_controller_tb.sv
│
├── docs
│   ├── fsm_diagram.png
│   └── waveform.png
│
└── README.md
```

## RTL Design

The RTL design is implemented in Verilog HDL using a three-process FSM architecture:

1. State Register
2. Next State Logic
3. Floor Update Logic

The controller starts at Ground Floor (0) after reset and processes floor requests based on the current elevator position.

---

## Verification Methodology

The design is verified using a SystemVerilog testbench.

### Test Cases

### Test 1: Ground Floor to Third Floor

* Request Floor = 3
* Expected State: MOVE_UP
* Expected Result: Elevator reaches Third Floor

### Test 2: Third Floor to First Floor

* Request Floor = 1
* Expected State: MOVE_DOWN
* Expected Result: Elevator reaches First Floor

### Test 3: Emergency Condition

* Emergency signal asserted during operation
* Expected State: EMERGENCY
* Expected Result: Elevator stops immediately

### Test 4: First Floor to Ground Floor

* Request Floor = 0
* Expected State: MOVE_DOWN
* Expected Result: Elevator reaches Ground Floor

### Test 5: Same Floor Request

* Request Floor = Current Floor
* Expected State: IDLE
* Expected Result: No movement

---

## FSM Diagram

![FSM Diagram](docs/fsm_diagram.png)

---

## Simulation Waveform

![Simulation Waveform](docs/waveform.png)

---

## Tools Used

* Verilog HDL
* SystemVerilog
* EDA Playground
* EPWave
* GitHub

---

## Learning Outcomes

Through this project, the following concepts were implemented and verified:

* Finite State Machine (FSM) Design
* RTL Design Methodology
* Sequential Logic Design
* State Transition Analysis
* Functional Verification
* Testbench Development
* Waveform Debugging
* Verilog HDL Coding
* SystemVerilog Verification

---

## Author

**Sumanta Bhowmick**

B.Tech in Electronics and Communication Engineering
Institute of Engineering and Management (IEM), Kolkata

Interested in:

* RTL Design
* Functional Verification
* VLSI Frontend Design
* ASIC Design
* Semiconductor Engineering
