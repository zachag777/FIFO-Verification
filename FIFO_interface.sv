interface FIFO_interface #(
parameter width = 8
)(
  // clock and reset
  input logic clk,
);
// dut top level signals
  logic reset;
  logic [width-1:0] fifo_input;
  logic write_en;
  logic read_en;
  logic full;
  logic empty;
  logic [width-1:0] fifo_output;

// clocking block

  clocking cb @ (posedge clk);
    default input #1step output #2ns;
    // monitor samples
    input fifo_output, full, empty;
    // driver writes
    output fifo_input, write_en, read_en, reset;
  endclocking
  
endinterface
