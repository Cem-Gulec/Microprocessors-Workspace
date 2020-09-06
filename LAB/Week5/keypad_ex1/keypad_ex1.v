module keypad_ex1 (
		output reg [3:0] rowwrite,
		input [3:0] colread,
		input clk,
		output reg [3:0] data 
);

reg [25:0] clk1;
reg [3:0] keyread;
reg rowpressed;

always @(posedge clk)
	clk1 <= clk+1;
	
always @(posedge clk1[18])
	rowwrite <= {rowwrite[2:0], rowwrite[3]};

always @(*)
	if (rowwrite == 4'b1110 && colread == 4'b1110)
		begin
			keyread = 4'h1;
			rowpressed = 1'b1;
		end
	else if (rowwrite == 4'b1110 && colread == 4'b1101)
		begin
			keyread = 4'h2;
			rowpressed = 1'b1;
		end
	else if (rowwrite == 4'b1110 && colread == 4'b1011)
		begin
			keyread = 4'h3;
			rowpressed = 1'b1;
		end
	else if (rowwrite == 4'b1110 && colread == 4'b0111)
		begin
			keyread = 4'hA;
			rowpressed = 1'b1;
		end
	else if (rowwrite == 4'b1101 && colread == 4'b1110)
		begin
			keyread = 4'h4;
			rowpressed = 1'b1;
		end
	else if (rowwrite == 4'b1101 && colread == 4'b1101)
		begin
			keyread = 4'h5;
			rowpressed = 1'b1;
		end
	else if (rowwrite == 4'b1101 && colread == 4'b1011)
		begin
			keyread = 4'h6;
			rowpressed = 1'b1;
		end
	else if (rowwrite == 4'b1101 && colread == 4'b0111)
		begin
			keyread = 4'hb;
			rowpressed = 1'b1;
		end
	else if (rowwrite == 4'b1011 && colread == 4'b1110)
		begin
			keyread = 4'h7;
			rowpressed = 1'b1;
		end
	else if (rowwrite == 4'b1011 && colread == 4'b1101)
		begin
			keyread = 4'h8;
			rowpressed = 1'b1;
		end
	else if (rowwrite == 4'b1011 && colread == 4'b1011)
		begin
			keyread = 4'h9;
			rowpressed = 1'b1;
		end
	else if (rowwrite == 4'b1011 && colread == 4'b0111)
		begin
			keyread = 4'hc;
			rowpressed = 1'b1;
		end
	else if (rowwrite == 4'b0111 && colread == 4'b1110)
		begin
			keyread = 4'he;
			rowpressed = 1'b1;
		end
	else if (rowwrite == 4'b0111 && colread == 4'b1101)
		begin
			keyread = 4'h0;
			rowpressed = 1'b1;
		end
	else if (rowwrite == 4'b0111 && colread == 4'b1011)
		begin
			keyread = 4'hf;
			rowpressed = 1'b1;
		end
	else if (rowwrite == 4'b0111 && colread == 4'b0111)
		begin
			keyread = 4'hd;
			rowpressed = 1'b1;
		end
	else 
		begin
			keyread = 4'hf;
			rowpressed = 1'b0;
		end

always @(posedge clk1[18])
	if(rowpressed==1)
		data <= keyread;
	
initial rowwrite = 4'b1110;

endmodule