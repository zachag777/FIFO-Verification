import uvm_pkg::*;
`include "uvm_macros.svh"

class FIFO_env #(
	parameter width = 8,
	parameter depth = 8
) extends uvm_env;
	// constructor and factory registration
	function new(string name = "env", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	`uvm_component_param_utils(FIFO_env#(width, depth))

	FIFO_agent #(width) agent;
	FIFO_scoreboard #(width, depth) scoreboard;

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		agent = FIFO_agent#(width)::type_id::create("agent", this);
		scoreboard = FIFO_scoreboard #(width, depth)::type_id::create("scoreboard", this);
	endfunction
	// connect monitor and scoreboard
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		agent.monitor.mon_analysis_port.connect(scoreboard.ap_imp);
	endfunction
endclass
