module DFF #()(
	input logic data,
	input logic clk,
	input logic reset,
	output logic q,
	output logic q_not	
);

always_ff @ (posedge clk) begin
	// reset will enact on next clock cycle
	if(reset) begin
		q <= 1'b0;
	end
	
	else begin 
		q <= data;
	end
end


assign q_not = ~q;

endmodule : DFF
