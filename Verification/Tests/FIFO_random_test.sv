class FIFO_random_test #(
	parameter width = 8,
	parameter depth = 8
) extends FIFO_base_test #(width, depth);

	//constructor
	function new(string name = "rand_test", uvm_component parent = null);
		super.new(name, parent);
	endfunction
	//factory reg macro
	`uvm_component_param_utils(FIFO_random_test #(width, depth))

	task run_phase (uvm_phase phase);
		//sequence handle
		FIFO_random_sequence #(width) seq;
		// raise obj
		phase.raise_objection(this);
		// create w factory
		seq = FIFO_random_sequence #(width)::type_id::create("seq");
		// connect to sequencer thru agent and env
		seq.start(env.agent.sequencer);	

		phase.drop_objection(this);

	endtask
endclass

class FIFO_random_test_8 extends FIFO_random_test #(8,8);
	`uvm_component_utils(FIFO_random_test_8)

	function new(string name = "rand_test_8", uvm_component parent = null);
		super.new(name, parent);
	endfunction
endclass