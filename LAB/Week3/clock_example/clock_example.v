module clock_example(leds, pb1, pb2, clk);

input clk;
input pb1, pb2;
output reg [7:0] leds;
reg [25:0] clock2;

always @(posedge clk)
   /*clock2 <= clock2+1;

always @(posedge clock2[25])*/
	begin
		if((pb1==0)&&(pb2==1))
			leds[7] <= 1;
		else if((pb1==1)&&(pb2==0))
			leds[0] <= 1;
		else
			leds <= 8'b0;
	end
	
initial
	begin
		leds = 8'b1;
	end
	
endmodule