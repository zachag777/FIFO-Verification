import uvm_pkg::*;
`include "uvm_macros.svh"

class FIFO_sequence #(
  parameter width = 8
) extends uvm_sequence #(FIFO_transaction#(width));
  
// factory registration
  `uvm_object_param_utils(FIFO_sequence#(width))
  
// constructor
  function new(string name = "seq");
    super.new(name);
  endfunction

  virtual task body();
    FIFO_transaction#(width) trans; // declare transaction
    trans = FIFO_transaction#(width)::type_id::create("trans"); // create w factory
    start_item(trans); // start handshake
    trans.write_en = 1;
    trans.read_en = 0;
    trans.fifo_input = 8'h55;// randomize every bit except reset
    trans.reset = 0; // hold reset low
    finish_item(trans); // finish handshake
    
  endtask
endclass
