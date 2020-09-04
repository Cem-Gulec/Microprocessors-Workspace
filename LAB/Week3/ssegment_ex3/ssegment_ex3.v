module ssegment_ex3(grounds, display,clk, keys);

output reg [3:0] grounds;
output reg [6:0] display;
input [1:0] keys;
input clk;

reg [3:0] data [3:0]; //number to be printed
reg [1:0] count;
reg [25:0] clk1;
reg [15:0] number;
wire [1:0] buttons;
reg[1:0] state;

assign buttons = {~keys[1], ~keys[0]};

always @(posedge clk1[15])
begin
	grounds <= {grounds[2:0], grounds[3]};
	count <= count+1;
end

always @(posedge clk)
	begin
		case(state)
			2'b00:
				begin
					case(buttons)
						2'b01:
							begin
								state <= 2'b01;
								number <= number+1;
							end
						2'b10:
							begin
								state <= 2'b10;
								number <= number+10;
							end
					endcase
				end
			
			2'b01:
				begin
					if(buttons==2'b00)
						state <= 2'b00;
				end
			2'b10:
				begin
					if(buttons==2'b00)
						state <= 2'b00;
				end
			endcase
	end
	

always @(posedge clk)
	clk1 <= clk1+1;

always @(*)
		case(data[count])	
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
	
	always @(*)
		begin
			data[0] = number[15:12];
			data[1] = number[11:8];
			data[2] = number[7:4];
			data[3] = number[3:0];
		end
		
initial begin
	number = 0;
	count = 2'b00;
	grounds =4'b1110;
	clk1=0;
end

endmodule