import uvm_pkg::*;
`include "uvm_macros.svh"

class FIFO_scoreboard #(
	parameter width = 8,
	parameter depth = 8
) extends uvm_scoreboard;
	
	logic [width-1:0] q[$:depth-1]; // reference model data member

	// factory registration and constructor
	`uvm_component_param_utils(FIFO_scoreboard #(width))
	
	function new(string name = "scoreboard", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	// create transaction for analysis
	uvm_analysis_imp #(FIFO_transaction #(width), FIFO_scoreboard #(width)) ap_imp;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ap_imp = new("ap_imp", this);
	endfunction

	// transaction representing inputs driven by driver and outputs from dut
	function void write(FIFO_transaction #(width) trans);

		// printing inputs from driver and the updated dut outputs
		// (because we sample after the dut updates on posedge)
		`uvm_info("FIFO_SB",
			$sformatf(
				"Received: write=%0b read=%0b input=%0h output=%0h full=%0b empty=%0b",
				trans.write_en,
				trans.read_en,
				trans.fifo_input,
				trans.fifo_output,
				trans.full,
				trans.empty
			),
			UVM_LOW)

		// monitor samples dut output after the posedge update, so we need to
		// push/pop (updating our expected output) before comparing with the dut output
		if (trans.write_en && !trans.full)
			q.push_back(trans.fifo_input);

		if (trans.read_en && !trans.empty)
			q.pop_front();

		// check sampled output vs expected output
		// (determined using the reference model) and output potential error msg
		if (q.size() > 0) begin
			if (q[0] != trans.fifo_output)
				`uvm_error("FIFO_SB",
					$sformatf(
						"Output mismatch: expected=%0h actual=%0h",
						q[0],
						trans.fifo_output
					))
		end

		// add uvm errors for full and empty using queue.size()

	endfunction

endclass
