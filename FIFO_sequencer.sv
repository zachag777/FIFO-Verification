class FIFO_sequencer extends uvm_sequencer #(FIFO_transaction);
	
	// uvm macro
	`uvm_component_utils(FIFO_sequencer)

	// constructor
	function new (string name = "sequencer");
		super.new(name);
	endfunction 
endclass
