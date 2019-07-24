`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/27 10:28:55
// Design Name: 
// Module Name: LAB1_tb
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


module LAB1_tb();
    reg X_tb;
    reg CLK_tb,  RST_tb;
    wire S_tb, V_tb;
    LAB1 LAB1_tb(X_tb,CLK_tb,RST_tb,S_tb,V_tb);

    initial
    begin
        X_tb = 0;
        CLK_tb = 0;
        RST_tb = 1;   
        #7.5 X_tb = 1;
        #10 X_tb = 0;
        #10 X_tb = 1;
        #10 X_tb = 1;
        #10 X_tb = 0;
        #2.5 RST_tb = 0;
        #5 RST_tb = 1;
           #2.5 X_tb = 0;
        #10 X_tb = 0;
        #10 X_tb = 1;
        #10 X_tb = 1;
        #10 X_tb = 0;
        #2.5 RST_tb = 0;
        #5 RST_tb = 1;
          #2.5  X_tb = 1;
        #10 X_tb = 1;
        #10 X_tb = 0;
        #10 X_tb = 1;
        #10 X_tb = 0;  
         $finish;
    end
    
    always 
        #5 CLK_tb = ! CLK_tb;


endmodule
