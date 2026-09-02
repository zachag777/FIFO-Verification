class FIFO_transaction #(
	parameter width = 8

) extends uvm_sequence_item;
	// factory registration
	`uvm_object_param_utils(FIFO_transaction#(width))
	
	// randomize operation and data input
	// control reset bit
	bit reset;
	rand bit write_en;
	rand bit read_en;
	rand logic [width-1:0] fifo_input;

	// constructor with default name
	function new(string name = "trans");
		super.new(name);
	endfunction

endclass
