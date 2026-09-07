import uvm_pkg::*;
`include "uvm_macros.svh"

class FIFO_sequence #(
	parameter width = 8
) extends uvm_sequence #(FIFO_transaction#(width));
	
	// factory registration
	`uvm_object_param_utils(FIFO_sequence#(width))
	
	// constructor
	function new(string name = "seq");
		super.new(name);
	endfunction

	virtual task body();
		FIFO_transaction#(width) trans; // declare transaction

		trans = FIFO_transaction#(width)::type_id::create("trans"); // create w factory

		start_item(trans); // start handshake
		trans.write_en = 0;
		trans.read_en = 0;
		trans.fifo_input = 0; 
		trans.reset = 1; //reset to initialize fifo register contents to zero
		finish_item(trans); // finish handshake

		trans = FIFO_transaction#(width)::type_id::create("trans"); // create w factory

		start_item(trans); // start handshake
		trans.write_en = 1; // write 55
		trans.read_en = 0;
		trans.fifo_input = 8'h55;
		trans.reset = 0; 
		finish_item(trans); // finish handshake

		trans = FIFO_transaction#(width)::type_id::create("trans"); // create w factory

		start_item(trans);
		trans.reset = 0; // write aa
		trans.write_en = 1;
		trans.read_en = 0;
		trans.fifo_input = 8'hAA;
		finish_item(trans);

		trans = FIFO_transaction#(width)::type_id::create("trans"); // create w factory
		
    start_item(trans); // read
		trans.reset = 0;
		trans.write_en = 0;
		trans.read_en = 1;
		trans.fifo_input = 0;
		finish_item(trans);

	endtask
endclass
