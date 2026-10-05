import uvm_pkg::*;
`include "uvm_macros.svh"

class FIFO_coverage #(
	parameter width = 8
) extends uvm_subscriber #(FIFO_transaction #(width));
	`uvm_component_param_utils(FIFO_coverage #(width))
	FIFO_transaction #(width) trans;

	bit was_full;
	bit was_empty;
	covergroup FIFO_cg;
		// all valid fifo operations including simultaneous read and write
		// fifo.sv allows 00 but does not change the ptrs or register contents
		operation_cp: coverpoint {trans.read_en, trans.write_en} {
			bins idle = {2'b00};
			bins read = {2'b10};
			bins write = {2'b01};
			bins read_write = {2'b11};
		}

		// all possible states 
		// declare simultaneous full and empty as illegal
		state_cp: coverpoint {was_full, was_empty} {
			bins empty = {2'b01};
			bins full = {2'b10};
			bins partial = {2'b00};
			illegal_bins full_empty = {2'b11};
		}
		
		// cross operation and state to see if we are testing all operations under all conditions
		operation_state: cross operation_cp, state_cp;

	endgroup	

	function new(string name = "coverage", uvm_component parent = null);
		super.new(name, parent);
		FIFO_cg = new();
	endfunction

	function void write(FIFO_transaction #(width) t);
		trans = t;
		FIFO_cg.sample();
		was_full = t.full;
		was_empty = t.empty;
	endfunction

	function void report_phase(uvm_phase phase);
		super.report_phase(phase);
		`uvm_info("COVERAGE", $sformatf("Functional coverage: %0.2f%%", FIFO_cg.get_coverage()), UVM_LOW)
	endfunction

endclass
