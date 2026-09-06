import uvm_pkg::*;
`include "uvm_macros.svh"

class FIFO_monitor #(
	parameter width = 8
) extends uvm_monitor;
	// constructor and factory registration
	`uvm_component_param_utils(FIFO_monitor#(width))
	
	function new(string name = "monitor", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	// interface and analysis port
	virtual FIFO_interface#(width) fifoif;
	uvm_analysis_port #(FIFO_transaction#(width)) mon_analysis_port;
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		mon_analysis_port = new("mon_analysis_port", this);

	// handle error
		if(!uvm_config_db #(virtual FIFO_interface#(width))::get(this, "", "fifoif", fifoif)) begin
			`uvm_fatal(get_type_name(), "handle error")
		end

	endfunction	

	task run_phase(uvm_phase phase);
		FIFO_transaction #(width) trans;
		
		forever begin
		// populate transaction with interface signals
			@(fifoif.cb);
			trans = FIFO_transaction#(width)::type_id::create("trans");

			// inputs
			trans.reset = fifoif.cb.reset;
			trans.read_en = fifoif.cb.read_en;
			trans.write_en = fifoif.cb.write_en;
			trans.fifo_input = fifoif.cb.fifo_input;

			// outputs
			trans.full = fifoif.cb.full;
			trans.empty = fifoif.cb.empty;
			trans.fifo_output = fifoif.cb.fifo_output;

			mon_analysis_port.write(trans);
		end

	endtask

endclass
