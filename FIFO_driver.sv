import uvm_pkg::*;
`include "uvm_macros.svh"

class FIFO_driver #(
	parameter width = 8
) extends uvm_driver #(FIFO_transaction#(width));
	
	// uvm macro
	`uvm_component_param_utils(FIFO_driver#(width))

	// constructor
	function new(string name = "driver", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	
	// create vif and get handle

	virtual FIFO_interface#(width) fifoif;
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if (!uvm_config_db #(virtual FIFO_interface#(width))::get(this, "", "fifoif", fifoif)) begin
		`uvm_fatal(get_type_name(), "handle error")
		end
	endfunction

	task run_phase(uvm_phase phase);
		FIFO_transaction#(width) trans;
		forever begin
		// get next
			seq_item_port.get_next_item(trans);
			// drive signals
			@(fifoif.cb);
			fifoif.cb.reset <= trans.reset;
			fifoif.cb.write_en <= trans.write_en;
			fifoif.cb.read_en <= trans.read_en;
			fifoif.cb.fifo_input<= trans.fifo_input;
			
			seq_item_port.item_done();
		end
	endtask
endclass
