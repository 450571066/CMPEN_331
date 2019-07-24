`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/27 15:27:08
// Design Name: 
// Module Name: Lab1_source
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Lab1_source(
    input X,
    input CLK,
    input RST,
    output S,
    output V
    );
    reg  [2:0] state;
    reg S, V;
    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101, S6 =3'b110, S7 = 3'b111;
    initial begin
        state = S7; 
        S = 0;
        V = 0;
    end
    
   always @(negedge RST)
    begin 
            state = S0;
            S = 0;
            V = 0;
    end 
       
    always @(negedge CLK)
      begin
      if (state == S0)
             begin
                 S = 0;
                 V = 0;
             end

        case (state)
            S0: begin
                if (X == 0) begin
                    S = 1;
                    V = 0;
                    state = S1;
                    end
                else begin
                    S = 0;
                    V = 0;
                    state = S2;
                    end
            end
            S1: begin
                 if (X == 0) begin
                      S = 1;
                      V = 0;
                      state = S3;
                 end
                 else begin
                       S = 0;
                       V = 0;
                       state = S4;
                 end
            end
            S2: begin 
                if (X == 0) begin
                      S = 0;
                      V = 0;
                      state = S4;
                end
                else begin
                     S = 1;
                     V = 0;
                     state = S4;
               end
           end
           S3: begin 
                if (X == 0) begin
                      S = 0;
                      V = 0;
                      state = S5;
                end
                else begin
                     S = 1;
                     V = 0;
                     state = S5;
               end
            end
            S4: begin 
                 if (X == 0) begin
                       S = 1;
                       V = 0;
                       state = S5;
                 end
                 else begin
                      S = 0;
                      V = 0;
                      state = S6;
                end
           end
           S5: begin 
               if (X == 0) begin
                   S = 0;
                   V = 0;
                    state = S0;
               end
               else begin
                    S = 1;
                    V = 0;
                    state = S0;
                end
           end             
           S6: begin 
               if (X == 0) begin
                   S = 1;
                   V = 0;
                   state = S0;
               end
               else begin
                   S = 0;
                   V = 1;
                   state = S0;
               end
           end 
           default: begin
              S = 0;
              V = 0;
              state = S0;
           end
      endcase

       end

endmodule
