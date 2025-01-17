module fpga_counter (leds, pb1);

output reg[7:0] leds;
input pb1;

always @ (posedge pb1)
	begin
		if (leds == 8'hFF) // 1111 1111
			leds <= 8'h00;
		else
			leds <= (leds << 1) + 1; // 0001 111 -> 001 1111
	end

	
initial begin
leds = 8'h00;
end

endmodule