module dipswitch_ex1(
	input [3:0] ds,
	input clk,
	output reg [7:0] leds
);

//assign leds = ds;
//wire ds0;
//assign ds0 = ds[0];
reg state; //check dipswitch if on or off
reg ds0;
reg [7:0] check;

always @(posedge clk)
begin
	check<={check[6:0], ds[0]};
	if (check == 8'b11111111)
		ds0 <= 1;
	else
		ds0 <= 0;
end

always @(posedge clk)
begin
	case(state)
		1'b0:
			begin
				if(ds0==1)
					begin
						state<=1;
						leds<={leds[6:0], leds[7]};
					end
			end
			
		1'b1:
			begin
				if(ds0==0)
					state<=0;
			end
	endcase
end
	
	
initial begin
state = 0;
leds<=8'b00000001;
check = 0;
end



endmodule