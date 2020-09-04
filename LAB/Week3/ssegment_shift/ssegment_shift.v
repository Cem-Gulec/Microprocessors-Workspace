module ssegment_shift(keys, grounds, display, clk);

output reg [6:0] display;
output reg [3:0] grounds;
input [1:0] keys;
input clk;
wire [1:0] buttons;
reg [3:0] data;
reg [1:0] state;

assign buttons = {~keys[1], ~keys[0]};

always @(posedge clk)
	begin
		case(state)
		
		2'b00:
			begin
				case(buttons)
					2'b01:
						begin
							state <= 2'b01;
							grounds <= {grounds[2:0], grounds[3]};
						end
					
					2'b10:
						begin
							state <= 2'b10;
							grounds <= {grounds[0], grounds[3:1]};
						end
					endcase
		
			end
		
		2'b01:
			begin
				if(buttons == 2'b00)
					state <= 2'b00;
			end
		
		2'b10:
			begin
				if(buttons == 2'b00)
					state <= 2'b00;
			end
		endcase
end

always @(*)
begin
		case(data)	
			0:display=7'b1111110; //starts with a, ends with g
			1:display=7'b0110000;
			2:display=7'b1101101;
			3:display=7'b1111001;
			4:display=7'b0110011;
			5:display=7'b1011011;
			6:display=7'b1011111;
			7:display=7'b1110000;
			8:display=7'b1111111;
			9:display=7'b1111011;
			'ha:display=7'b1110111;
			'hb:display=7'b0011111;
			'hc:display=7'b1001110;
			'hd:display=7'b0111101;
			'he:display=7'b1001111;
			'hf:display=7'b1000111;
			default display=7'b1111111;
		endcase
end

initial begin
data = 4'hb;
state = 2'b00;
grounds = 4'b1110;
end

endmodule


