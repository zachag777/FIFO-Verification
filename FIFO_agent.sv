class FIFO_agent #(
	parameter width = 8
) extends uvm_agent;

	// factory registration and constructor
	`uvm_component_param_utils(FIFO_agent#(width))

	function new(string name = "agent", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	// create sequencer, driver, and monitor
	FIFO_driver #(width) driver;
	FIFO_monitor #(width) monitor;
	FIFO_sequencer #(width) sequencer;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		if(get_is_active()) begin
			sequencer = FIFO_sequencer #(width)::type_id::create("sequencer", this);
			driver = FIFO_driver #(width)::type_id::create("driver", this);
		end 

		monitor = FIFO_monitor #(width)::type_id::create("monitor", this);

	endfunction

	// connect driver and sequencer

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		if(get_is_active())
			driver.seq_item_port.connect(sequencer.seq_item_export);
		
	endfunction

endclass
