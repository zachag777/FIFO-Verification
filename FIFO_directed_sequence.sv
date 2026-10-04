import uvm_pkg::*;
`include "uvm_macros.svh"

class FIFO_directed_sequence #(
	parameter width = 8
) extends uvm_sequence #(FIFO_transaction #(width));
	// constructor
	function new(string name = "dir_seq");
		super.new(name);
	endfunction

	//factory registration
	`uvm_object_param_utils(FIFO_directed_sequence #(width))

	task body();
		// transaction handle
		FIFO_transaction #(width) trans;

		//initial reset
		trans = FIFO_transaction #(width)::type_id::create("trans");
		start_item(trans);
		assert(trans.randomize() with {
			write_en == 0;
			read_en == 0;
		});
		trans.reset = 1;
		finish_item(trans);
		// write read and idle while empty (at start)
		//idle
		trans = FIFO_transaction #(width)::type_id::create("trans");
		start_item(trans);
		assert(trans.randomize() with {
			write_en == 0;
			read_en == 0;
		});
		finish_item(trans);

		//read
		trans = FIFO_transaction #(width)::type_id::create("trans");
		start_item(trans);
		assert(trans.randomize() with {
			write_en == 0;
			read_en == 1;
		});
		finish_item(trans);
		// simultaneous read and write
		trans = FIFO_transaction #(width)::type_id::create("trans");
		start_item(trans);
		assert(trans.randomize() with {
			write_en == 1;
			read_en == 1;
		});
		finish_item(trans);

		// repeat to empty
		repeat(3) begin
			trans = FIFO_transaction #(width)::type_id::create("trans");
			start_item(trans);
			assert(trans.randomize() with {
				write_en == 0;
				read_en == 1;
			});
		finish_item(trans);

		end

		// write
		trans = FIFO_transaction #(width)::type_id::create("trans");
		start_item(trans);
		assert(trans.randomize() with {
			write_en == 1;
			read_en == 0;
		});
		finish_item(trans);

		// simultaneous read and write
		trans = FIFO_transaction #(width)::type_id::create("trans");
		start_item(trans);
		assert(trans.randomize() with {
			write_en == 1;
			read_en == 1;
		});
		finish_item(trans);

		// repeat to partial fill

		repeat(3) begin
			trans = FIFO_transaction #(width)::type_id::create("trans");
			start_item(trans);
			assert(trans.randomize() with {
				write_en == 1;
				read_en == 0;
			});
			finish_item(trans);
		end
	

		// write read and idle while partially full
		//idle
		trans = FIFO_transaction #(width)::type_id::create("trans");
		start_item(trans);
		assert(trans.randomize() with {
			write_en == 0;
			read_en == 0;
		});
		finish_item(trans);

		//read
		trans = FIFO_transaction #(width)::type_id::create("trans");
		start_item(trans);
		assert(trans.randomize() with {
			write_en == 0;
			read_en == 1;
		});
		finish_item(trans);

		// write
		trans = FIFO_transaction #(width)::type_id::create("trans");
		start_item(trans);
		assert(trans.randomize() with {
			write_en == 1;
			read_en == 0;
		});
		finish_item(trans);

		// simultaneous read and write
		trans = FIFO_transaction #(width)::type_id::create("trans");
		start_item(trans);
		assert(trans.randomize() with {
			write_en == 1;
			read_en == 1;
		});
		finish_item(trans);
		// repeat to fill

		repeat(10) begin
			trans = FIFO_transaction #(width)::type_id::create("trans");
			start_item(trans);
			assert(trans.randomize() with {
				write_en == 1;
				read_en == 0;
			});
			finish_item(trans);
		end

		// write read and idle while full
		//idle
		trans = FIFO_transaction #(width)::type_id::create("trans");
		start_item(trans);
		assert(trans.randomize() with {
			write_en == 0;
			read_en == 0;
		});
		finish_item(trans);

		// write
		trans = FIFO_transaction #(width)::type_id::create("trans");
		start_item(trans);
		assert(trans.randomize() with {
			write_en == 1;
			read_en == 0;
		});
		finish_item(trans);
		//read
		trans = FIFO_transaction #(width)::type_id::create("trans");
		start_item(trans);
		assert(trans.randomize() with {
			write_en == 0;
			read_en == 1;
		});
		finish_item(trans);
		// write
		trans = FIFO_transaction #(width)::type_id::create("trans");
		start_item(trans);
		assert(trans.randomize() with {
			write_en == 1;
			read_en == 0;
		});
		finish_item(trans);

		// simultaneous read and write
		trans = FIFO_transaction #(width)::type_id::create("trans");
		start_item(trans);
		assert(trans.randomize() with {
			write_en == 1;
			read_en == 1;
		});
		finish_item(trans);

	endtask
endclass