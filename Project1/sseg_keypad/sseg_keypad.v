module sseg_keypad (  output wire [3:0] rowwrite,
						input [3:0] colread,
						input clk,
						output wire [3:0] data,
						
						output wire [3:0] grounds,
						output wire [6:0] display
					);

reg [15:0] data_all;
wire [3:0] keyout;
reg [25:0] clk1;
reg [1:0] ready_buffer;
reg ack;
wire ready;

reg [15:0] total;
reg [1:0] state;
reg [15:0] howmany_match;

assign data=keyout;
	
sevensegment ss1 (.datain(data_all), .grounds(grounds), .display(display), .clk(clk));

keypad_ex  kp1(.rowwrite(rowwrite),.colread(colread),.clk(clk),.keyout(keyout),.ready(ready),.ack(ack));

always @(posedge clk)
	ready_buffer<= {ready_buffer[0],ready}; //

always @(posedge clk)
	if (ready_buffer==2'b01)
		begin
			if(keyout==4'hF)
				data_all<=data_all-total;
			else if(keyout==4'hE)
				data_all<=data_all;
			else
				data_all<={data_all[11:0],keyout};
			ack<=1;
		end
	else
			ack<=0;

always @(posedge clk)
	begin
		case(state)
			2'b00:
				begin
					case(keyout)
						4'hE: 
							begin
								total <= data_all;
								state <= 2'b01;
							end
					endcase
				end
			
			2'b01:
				begin
					case(keyout)
						4'h1: 
							begin
								howmany_match <= 16'b01;
								state <= 2'b01;
							end
						4'h2: 
							begin
								howmany_match <= 16'b10;
								state <= 2'b01;
							end
						4'h3: 
							begin
								howmany_match <= 16'b11;
								state <= 2'b01;
							end
						4'hF:
							begin
								total <= total - howmany_match;
								state <= 2'b10;
							end
					endcase		
				end
				
			2'b10:
				begin
					case(keyout)
						4'h1: 
							begin
								howmany_match <= 16'b01;
								state <= 2'b10;
							end
						4'h2: 
							begin
								howmany_match <= 16'b10;
								state <= 2'b10;
							end
						4'h3: 
							begin
								howmany_match <= 16'b11;
								state <= 2'b10;
							end
						4'hF:
							begin
								total <= total - howmany_match;
								state <= 2'b01;
							end
					endcase		
				end
				
			
				
				
			default: state <= state;
		endcase
	end
			

initial 	
	begin
		data_all=0;
		ack=0;
		state=2'b0;
	end

endmodule






