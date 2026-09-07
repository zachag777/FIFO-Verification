package FIFO_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    `include "transactions/FIFO_transaction.sv"

    `include "components/FIFO_driver.sv"
    `include "components/FIFO_sequencer.sv"
    `include "components/FIFO_monitor.sv"
    `include "components/FIFO_agent.sv"
    `include "components/FIFO_scoreboard.sv"
    `include "components/FIFO_env.sv"

    `include "sequences/FIFO_sequence.sv"

    `include "tests/FIFO_basetest.sv"
    `include "tests/FIFO_test_one.sv"

endpackage