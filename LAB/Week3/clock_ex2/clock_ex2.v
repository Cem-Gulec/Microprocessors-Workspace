module clock_ex2(leds, pb1, pb2, clk);

input clk;
input pb1, pb2;
output reg [7:0] leds;
reg [1:0] state;
wire [1:0] buttons;
//reg [25:0] clock2;

assign buttons = {pb1, pb2};

always @(posedge clk)
	//clock2 <= clock2+1;

//always @(posedge clock2[24])
begin
	/*if(buttons == 2'b10)
		leds <= {leds[6:0], 1'b1};
	else if (buttons == 2'b01)
		leds <= {1'b0, leds[7:1]};*/
		
		case(state)
			
			2'b00:
				begin
					case(buttons)
						2'b01:
							begin
								state <= 2'b01;
								leds <= {leds[6:0], 1'b1};
							end
						2'b10:
							begin
								state <= 2'b10;
								leds <= {1'b0, leds[7:1]};
							end
						
					endcase
				 end
			
			2'b01:
				begin
					if (buttons == 2'b00)
						state <= 2'b00;
				end
			
			2'b10:
				begin
					if (buttons == 2'b00)
						state <= 2'b00;
				end
			
		endcase
end
		

initial
	begin
	leds  = 8'b111;
	state = 2'b00;
	end

endmodule