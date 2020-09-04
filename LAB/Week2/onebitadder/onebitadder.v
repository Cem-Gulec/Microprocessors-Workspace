module onebitadder(sw1, sw2, leds);

input wire sw1, sw2;
output reg [1:0] leds;

/* option 1 to do it

assign leds[0] = sw1^sw2;
assign leds[1] = sw1&sw2;

*/

always @(*)
begin
    leds[0] = sw1^sw2;
	 leds[1] = sw1&sw2;
end

endmodule