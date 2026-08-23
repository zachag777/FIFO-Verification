module PIPO_Register #(
	parameter width = 8
)(
	input logic [width-1:0]data_input,
	input logic reset,
	input logic enable,
	input logic clk,
	output logic [width-1:0] data_output
);
	// genvar dffs according to bit width
	// feed clk to all of them
	// feed data input to them in bit indices
	// output == enable && data_input[i]

genvar i;
generate

	for(i = 0; i < width; i++) begin : gen_dff
	
		DFF u_dff (
			.clk(clk),
			.reset(reset),
			.data(enable ? data_input[i] : data_output[i]),
			.q(data_output[i]),
			.q_not()
		);
	
	end
endgenerate
endmodule : PIPO_Register

