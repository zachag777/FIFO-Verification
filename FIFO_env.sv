class FIFO_env extends uvm_env;

	function new(string name = "env", uvm_component parent);
		super.new(name, parent);
	endfunction

	FIFO_driver = driver;
	FIFO_sequencer = sequencer;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		driver = FIFO_driver::type_id::create("driver", this);
		sequencer = FIFO_sequencer::type_id::create("driver", this);
	endfunction

	function void connect_phase(uvm_phase phase);
		driver.seq_item_port.connect(sequencer.seq_item_export);
	endfunction
endclass
