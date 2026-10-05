import uvm_pkg::*;
`include "uvm_macros.svh"

class FIFO_base_test #(
	parameter width = 8,
	parameter depth = 8
) extends uvm_test;
	`uvm_component_param_utils(FIFO_base_test#(width, depth))
	FIFO_env #(width, depth) env;

	function new(string name = "test", uvm_component parent = null);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		env = FIFO_env #(width, depth)::type_id::create("env", this);
	endfunction
endclass
