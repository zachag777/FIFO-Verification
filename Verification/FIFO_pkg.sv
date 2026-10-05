package FIFO_pkg;

	import uvm_pkg::*;
	`include "uvm_macros.svh"

	`include "FIFO_transaction.sv"

	`include "FIFO_driver.sv"
	`include "FIFO_sequencer.sv"
	`include "FIFO_monitor.sv"
	`include "FIFO_agent.sv"
	`include "FIFO_scoreboard.sv"
	`include "FIFO_coverage.sv"
	`include "FIFO_env.sv"

	`include "FIFO_sequence.sv"
	`include "FIFO_random_sequence.sv"
	`include "FIFO_directed_sequence.sv"

	`include "FIFO_basetest.sv"
	`include "FIFO_test_one.sv"
	`include "FIFO_random_test.sv"
	`include "FIFO_directed_test.sv"

endpackage