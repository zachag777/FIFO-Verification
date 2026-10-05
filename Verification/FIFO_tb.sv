`timescale 1ns/1ps
import uvm_pkg::*;
import FIFO_pkg::*;
`include "uvm_macros.svh"

module FIFO_tb #(
	parameter width = 8
)();

	logic clk;
	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end

	FIFO_interface #(width) fifoif(clk);

	FIFO #(
		.width(width)
	) u_fifo (
		.clk(clk),
		.reset(fifoif.reset),
		.fifo_input(fifoif.fifo_input),
		.write_en(fifoif.write_en),
		.read_en(fifoif.read_en),
		.full(fifoif.full),
		.empty(fifoif.empty),
		.fifo_output(fifoif.fifo_output)
	);

	initial begin
	
		uvm_config_db #(virtual FIFO_interface #(width))::set(
			null,
			"*",
			"fifoif",
			fifoif
		);
	
		run_test("FIFO_directed_test_8");
	end
	

endmodule

