module FIFO #(
	// bit width of registers
	parameter width = 8,
	// number of registers in the fifo buffer
	parameter depth = 8
)(
	input logic clk,
	input logic [width-1:0] fifo_input,
	input logic reset, //clear fifo buffer
	input logic write_en, //if write_en is high then the write action is taken
	input logic read_en, //same logic for read_en
	output logic full, //high if there is no space
	output logic empty, //high if nothing is stored in the buffer
	output logic [width-1:0] fifo_output //output is oldest data currently in the buffer
);

	//internal signals for ptrs
logic [$clog2(depth)-1:0]read_ptr; //tracks oldest piece of data in buffer
logic [$clog2(depth)-1:0]write_ptr; //tracks next available spot in buffer
logic [width-1:0] out_register [0:depth-1]; // to store register contents
logic [$clog2(depth):0] entry_counter; //counting how many entries for full/empty flags

genvar i;

//generate i registers where i is the depth
generate
	for(i = 0; i < depth; i++) begin : gen_reg
		PIPO_Register #(
			.width(width)
		) u_reg (
			.clk(clk),
			.reset(reset),
			.enable(write_en && write_ptr == i), // can only write if write is enabled and youre in the right register
			.data_input(fifo_input),
			.data_output(out_register[i]) // store register contents in array
		);
	
	end
	
endgenerate

	// always_ff block
	// increment ptrs

always_ff @ (posedge clk) begin
// print signals. inputs are what its receiving and the other signals are what it currently has before updating (current state)
	$display(
		"@%0t FIFO receiving: reset=%0b write=%0b read=%0b | FIFO current(b4update): wptr=%0d rptr=%0d count=%0d | reg0=%0h reg1=%0h | output=%0h",
		$time,
		reset,
		write_en,
		read_en,
		write_ptr,
		read_ptr,
		entry_counter,
		out_register[0],
		out_register[1],
		fifo_output
		);

	if (reset) begin

	// initialize values to zero
		write_ptr <= '0;
		read_ptr <= '0;
		entry_counter <= '0;
	end
	else begin

		// increment and decrement entry counter
		case({write_en && !full, read_en && !empty}) // cant increment if full and cant decrement if empty
			2'b10: entry_counter <= entry_counter + 1'b1;
			2'b01: entry_counter <= entry_counter - 1'b1;
		endcase
		// increment read_ptr when read enable if its not empty
		if (read_en && !empty) begin
			// if everything has been read then wrap
			if (read_ptr == depth-1) begin
				read_ptr <= '0;
			end
			else begin
				read_ptr <= read_ptr + 1'b1;
			end
		end
		// increment write_ptr if write enable and if its not full
		if (write_en && !full) begin
			// if everything has been written then wrap
			if (write_ptr == depth-1) begin
				write_ptr <= '0;
			end
			else begin
				write_ptr <= write_ptr + 1'b1;
			end
		end
	end
end

assign fifo_output = out_register[read_ptr]; // output is oldest unread element (but can be stale so fifo output is only meaningful if not empty)
assign full = (entry_counter == depth);
assign empty = (entry_counter == 0);

endmodule : FIFO
