class FIFO_sequencer #(
	parameter width = 8
)extends uvm_sequencer #(FIFO_transaction #(width));
	
	// uvm macro
	`uvm_component_param_utils(FIFO_sequencer#(width))

	// constructor
	function new (string name = "sequencer", uvm_component parent = null);
		super.new(name, parent);
	endfunction 
endclass
