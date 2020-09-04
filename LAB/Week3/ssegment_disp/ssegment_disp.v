module ssegment_disp(ds, grounds, display);

output reg [6:0] display;
output reg [3:0] grounds;
input [3:0] ds;
reg [3:0] data;

always @(*)
	begin
		if(ds[0]==1)
			grounds[0]=0;
		else
			grounds[0]=1;
			
		if(ds[1]==1)
			grounds[1]=0;
		else
			grounds[1]=1;
			
		if(ds[2]==1)
			grounds[2]=0;
		else
			grounds[2]=1;
			
		if(ds[3]==1)
			grounds[3]=0;
		else
			grounds[3]=1;
	end

always @*
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
data[0] = 1'ha;
data[1] = 1'hb;
data[2] = 1'hc;
data[3] = 1'hd;
end

endmodule