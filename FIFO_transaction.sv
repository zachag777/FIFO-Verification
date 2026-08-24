class FIFO_transaction #(
	parameter width = 8

);
	// randomize operation and data input
	// control reset bit
	input bit reset;
	rand bit write_en;
	rand bit read_en;
	rand logic [width-1:0] fifo_input;

endclass
