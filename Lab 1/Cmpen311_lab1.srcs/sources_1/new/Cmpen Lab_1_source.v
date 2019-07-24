`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/27 08:44:33
// Design Name: 
// Module Name: LAB1
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


module LAB1(X,CLK,RST,S,V);
input X;
input CLK; input RST;
output S;
output V;
reg S,V;
reg[2:0] CurrentState;
parameter  S0 = 3'b000, S1 = 3'b010, S2 = 3'b001, S3 = 3'b101, S4 = 3'b011, S5 = 3'b100,S6=3'b111, SI=3'b110;
initial begin
CurrentState = SI;
end
always@(negedge RST)begin
CurrentState = S0;
end
always@(negedge CLK)begin
    if(RST == 1'b0)begin
     CurrentState = SI;
     S=0;V=0;
    end
    case(CurrentState)
        S0:if(X==0)begin
        CurrentState = S1;
        S=1;V=0;
        end else begin
        CurrentState = S2;
        S=0;V=0;
        end
        S1:if(X==0)begin
        CurrentState = S3;
        S=1;V=0;
        end else begin
        CurrentState = S4;
        S=0;V=0;
        end
        S2:if(X==0)begin
        CurrentState = S4;
        S=0;V=0;
        end else begin
        CurrentState = S4;
        S=1;V=0;
        end
        S3:if(X==0)begin
        CurrentState = S5;
        S=0;V=0;
        end else begin
        CurrentState = S5;
        S=1;V=0;
        end
        S4:if(X==0)begin
        CurrentState = S5;
        S=1;V=0;
        end else begin
        CurrentState = S6;
        S=0;V=0;
        end
        S5:if(X==0)begin
        CurrentState = S0;
        S=0;V=0;
        end else begin
        CurrentState = S0;
        S=1;V=0;
        end
        S6:if(X==0)begin
        CurrentState = S0;
        S=1;V=0;
        end else begin
        CurrentState = S0;
        S=0;V=1;
        end
        default begin 
        CurrentState = S0;
        S=0;V=0;
        end
    endcase
end
endmodule
