import uvm_pkg::*;
`include "uvm_macros.svh"

class FIFO_random_sequence #(
	parameter width = 8
) extends uvm_sequence #(FIFO_transaction #(width));

	//constructor
	function new(string name = "rand_test");
		super.new(name);
	endfunction

	//factory registration
	`uvm_object_param_utils(FIFO_random_sequence #(width))

	//task
	task body();
		// create transaction handle
		FIFO_transaction #(width) trans;
		//repeat x
		repeat(100) begin
			//repeat 25
			repeat(25) begin
				// create transaction w factory
				trans = FIFO_transaction #(width)::type_id::create("trans");
				// start handshake
				start_item(trans);
				// randomize, reset = 0
				assert(trans.randomize());		
				// finish handshake
				finish_item(trans);
			end
			//create transaction w factory
			trans = FIFO_transaction #(width)::type_id::create("trans");
			//start handshake
			start_item(trans);
			//reset
			trans.reset = 1;
			// finish handshake
			finish_item(trans);
		end
	endtask


endclass
