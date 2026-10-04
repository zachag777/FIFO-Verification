import uvm_pkg::*;
`include "uvm_macros.svh"

class FIFO_test_one #(
	parameter width = 8,
	parameter depth = 8
) extends FIFO_base_test #(width, depth);
	
	`uvm_component_param_utils(FIFO_test_one#(width, depth))

	function new(string name = "test", uvm_component parent = null);
		super.new(name, parent);
	endfunction
	
	task run_phase(uvm_phase phase);
		FIFO_sequence #(width) seq;

		phase.raise_objection(this);

		seq = FIFO_sequence #(width)::type_id::create("seq");

		seq.start(env.agent.sequencer);

		#15ns;		

		phase.drop_objection(this);

	endtask

endclass

class FIFO_test_one_8 extends FIFO_test_one #(8, 8);

	`uvm_component_utils(FIFO_test_one_8)

	function new(string name = "FIFO_test_one_8",
		uvm_component parent = null);
		super.new(name, parent);
	endfunction

endclass
