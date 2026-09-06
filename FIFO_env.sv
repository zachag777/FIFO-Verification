import uvm_pkg::*;
`include "uvm_macros.svh"

class FIFO_env #(
	parameter width = 8
) extends uvm_env;
// constructor and factory registration
	function new(string name = "env", uvm_component parent);
		super.new(name, parent);
	endfunction

	`uvm_component_param_utils(FIFO_env#(width))

	// create driver and sequencer
	FIFO_driver #(width) driver;
	FIFO_sequencer #(width) sequencer;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		driver = FIFO_driver#(width)::type_id::create("driver", this);
		sequencer = FIFO_sequencer #(width)::type_id::create("sequencer", this);
	endfunction
// connect driver and sequencer
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		driver.seq_item_port.connect(sequencer.seq_item_export);
	endfunction
endclass
