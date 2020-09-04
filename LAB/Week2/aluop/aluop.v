module aluop(switch, leds);

output reg[7:0] leds;
input [3:0] switch;
reg [7:0] w1,w2;

always @(*)
begin

w1 = 8'h22;
w2 = 8'h11;
    
	 case(switch)
		4'b0000: leds=w1+w2;
		4'b0001: leds=w1-w2;
		4'b0010: leds=w1&w2;
		4'b0011: leds=w1|w2;
		4'b0100: leds=w1^w2;
		4'b0101: leds=~w1;
		4'b0110: leds=w1;
		4'b0111: leds=w1+1;
		4'b1000: leds=w1-1;
		
		default: leds=0;
	endcase

end

endmodule