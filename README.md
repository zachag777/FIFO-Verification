# Parameterized FIFO Data Buffer and UVM Verification Environment

Run it using the EDA Playground link: https://edaplayground.com/x/Rzq3

## Project Description

SystemVerilog implementation of a parameterized FIFO data buffer with a full UVM verification environment including functional coverage.
The FIFO data buffer has two operations with distinct input signals: read (read_en) and write (write_en).

## Implementation

The FIFO data buffer uses a generate loop to create a series of PIPO registers. The PIPO registers are created using a generate loop of D flip-flops. The FIFO takes two parameters, width and depth. Width determines the bit width of the PIPO registers, and depth determines the number of PIPO registers in the FIFO buffer.
Read and write pointers track the location the next read and write will be applied to.
The read pointer points to the oldest unread entry. The write pointer points to next available register. The FIFO is capable of simultaneous read and write operations.
The output of the FIFO is set to the oldest unread element.
The FIFO has status flags full and empty. Full is set to logic high if all PIPO registers contain unread data. Empty is set to logic high if all PIPO registers are empty and/or contain read data.
A read operation is ignored if the FIFO is flagged as empty, and a write operation is ignored if the FIFO is flagged as full. The contents of all PIPO registers are cleared and set to zero on a reset.
The FIFO updates on the positive clock edge. The monitor samples 2ns after the positive clock edge.


## Status Flags

The FIFO buffer has two status flags: full and empty.

| Flag | Definition |
|----|----|
| Full | All registers have unread data |
| Empty | All registers are empty or contain read data |

<img width="7289" height="2313" alt="Untitled diagram - Copy-2026-10-04-181920" src="https://github.com/user-attachments/assets/f48ad0b5-aa0a-444e-9c41-5b42396247f9" />


## Verification Environment

The sequences generate transactions that are sent to the sequencer. The sequencer routes the transactions from a sequence to the driver. The driver applies transactions to the DUT through a virtual interface. The monitor samples the inputs and outputs of the DUT through a virtual interface and broadcasts them as a transaction using an analysis port. The scoreboard receives transactions from the monitor, and uses the inputs to compare the actual outputs to expected outputs determined using a high-level reference model. The coverage subscriber receives the same transactions from the monitor, and samples the functional coverage model.

The agent creates the sequencer, driver, and monitor through the factory and connects the driver to the sequencer. The environment creates the agent, scoreboard, and coverage subscriber, and connects the monitor's analysis port to both. The test creates the environment, then starts a sequence on the sequencer and holds an objection until it completes.

## Scoreboard

The scoreboard uses a queue with a number of elements equal to the depth of the FIFO, with a bit width equal to the width of the FIFO. The scoreboard uses pop_front and push_back to simulate read and write operations, respectively. The empty and full flags used in the scoreboard to check if a read or write are valid are determined at the start of the write() function to mirror the logic of the DUT. State flags for the reference mode are determined using the size() function.
Whether the current state flags of the reference model match that of the DUT is checked at the end of the write() function. Because push and pop physically add and remove elements from the queue, the output of the transaction is checked against the [0] index element of the queue (which would be the oldest unread element).

## Coverage Model

The coverage model has one overarching covergroup, which is sampled with each transaction.

### Coverpoints
- `operation_cp`: idle (no read or write), read, write, simultaneous read and write
- `state_cp`: empty, full, partial

### Crosses
Each state is crossed with each operation to confirm that every operation was tested in every possible state.

## Tests

The verification environment implements two tests: a random test and a directed test. The random test sends uses a subroutine that sends 25 transactions with randomized input and operation, and then sends one reset transaction. This subroutine is repeated 50 times by a repeat block.
The directed test uses randomized inputs with set operations in every possible FIFO state to exercise full coverage.

## Simulating

The FIFO and verification environment were tested in EDA Playground because my university does not provide access to a license that can use UVM and functional coverage. To test this project in EDA Playground use the EDA Playground link at the top of this README.

