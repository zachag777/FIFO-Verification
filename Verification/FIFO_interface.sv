import uvm_pkg::*;
`include "uvm_macros.svh"

`timescale 1ns/1ps

interface FIFO_interface #(
	parameter width = 8
)(
	input logic clk
);
	// dut top level signals
	logic reset;
	logic [width-1:0] fifo_input;
	logic write_en;
	logic read_en;
	logic full;
	logic empty;
	logic [width-1:0] fifo_output;

	// clocking block

	clocking driver_cb @ (negedge clk);
		default input #1step output #0; // driver drives signals at the negedge (dut updates on posedge)
		input fifo_output, full, empty;
		output fifo_input, write_en, read_en, reset;
	endclocking

	clocking monitor_cb @ (posedge clk);
		default input #0 output #0; // monitor samples at posedge of the clk
		// monitor samples
		input fifo_output, full, empty;
		input fifo_input, write_en, read_en, reset;
	endclocking
	
endinterface
