class FIFO_test_one #(
	parameter width = 8
) extends FIFO_basetest #(width);
	
	`uvm_component_param_utils(FIFO_test_one#(width))

	function new(string name = "test", uvm_component parent = null);
		super.new(name, parent);
	endfunction
	
	task run_phase(uvm_phase phase);
		FIFO_sequence #(width) seq;

		phase.raise_objection(this);

		seq = FIFO_sequence #(width)::type_id::create("seq");

		seq.start(env.sequencer);
		phase.drop_objection(this);

	endtask

endclass
