class FIFO_sequencer extends uvm_sequencer #(FIFO_transaction);
	
	// uvm macro
	`uvm_component_utils(FIFO_sequencer)

	// constructor
	function new (string name = "sequencer", uvm_component parent);
		super.new(name, parent);
	endfunction 
endclass
