module cpu( clk, data_out, data_in, address, memwt  );
    input clk;
    input [15:0] data_in;
    output [15:0] data_out;
    output reg [15:0] address;
    output wire memwt;
 
    reg [11:0] pc, ir;
 
    reg [4:0]  state;
    reg [15:0] regbank [7:0];
    reg [15:0] result;
 
 
     localparam   FETCH=5'b0000,
                  LDI=5'b0001,
                  LD=5'b0010,
                  ST=5'b0011,
                  JZ=5'b0100,
                  JMP=5'b0101,
                  ALU=5'b0111;
 
 
    wire intflag, zeroresult;
 
    always @(posedge clk)
        case(state)
 
            FETCH: 
            begin
                if ( data_in[15:12]==JZ) 
                    if (regbank[6][0])
                        state <= JUMP;
                    else
                        state <= FETCH;
                else
                    state <= data_in[15:12];
                ir<=data_in[11:0];
                pc<=pc+1;
            end
 
            LDI:
            begin
                regbank[ ir[2:0] ] <= data_in;
                pc<=pc+1;
                state <= FETCH;
            end
 
 
            LD:
                begin
                    regbank[ ir[2:0] ] <= data_in;
                    state <= FETCH;  
                end 
 
            ST:
                begin
                    dout <= regbank[ ir[8:6] ];
                    state <= FETCH;  
                end    
 
            JMP:
                begin
                    pc <= pc+ir;
                    state <= FETCH;  
                end          
 
            ALU:
                begin
                    regbank[ir[2:0]]<=result;
                    regbank[6][0]<=zeroresult;
                    state <= FETCH;
                end
 
        endcase
 
 
    always @*   
        case (state)
            LD:      address=regbank[ir[5:3]][11:0];
            ST:      address=regbank[ir[5:3]][11:0];
            default: address=pc;
         endcase
 
    assign data_out = regbank[ ir[8:6] ];
 
    assign memwt=(state==ST);
 
    always @*
        case (ir[11:9])
            3'h0: result = regbank[ir[8:6]]+regbank[ir[5:3]];
            3'h1: result = regbank[ir[8:6]]-regbank[ir[5:3]];
            3'h2: result = regbank[ir[8:6]]&amp;regbank[ir[5:3]];
            3'h3: result = regbank[ir[8:6]]|regbank[ir[5:3]];
            3'h4: result = regbank[ir[8:6]]^regbank[ir[5:3]];
            3'h7: case (ir[8:6])
                        3'h0: result = !regbank[ir[5:3]];
                        3'h1: result = regbank[ir[5:3]];
                        3'h2: result = regbank[ir[5:3]]+1;
                        3'h3: result = regbank[ir[5:3]]-1;
                        default: result=16'h0000;
                    endcase
            default: result=16'h0000;
        endcase
 
    assign zeroresult = ~|result;
 
 
    initial begin;
            state=FETCH;
            end                        
endmodule