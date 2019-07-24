`timescale 1ns / 1ps

module cpu_tb();
    reg clk, rst;

    wire [31:0] pcnow;
    wire [31:0] dowire;
    wire [5:0] opwire;
    wire [5:0] funcwire;
    wire [4:0] rdwire, rtwire, rswire;
    wire [15:0] immwire;
    wire wregwire, m2regwire, wmemwire, aluimmwire;
    wire ewregwire, em2regwire, ewmemwire, ealuimmwire;
    wire mwregwire, mm2regwire, mwmemwire;
    wire wwregwire, wm2regwire;
    wire [3:0] alucwire, ealucwire;
    wire regrtwire;
    wire [31:0] longwire;
    wire [4:0] muxwire, emuxwire, mmuxwire, wmuxwire;
    wire [31:0] dwire;
    reg [31:0] PCAddress;
    wire [31:0] qawire, qbwire, mqbwire;
    wire [31:0] eqbwire, eqawire, Extenderwire;
    wire [31:0] bwire, rwire, mrwire;
    wire [31:0] mdowire;
    wire [31:0] wrwire, wdowire;
    
    
  
    PC pc(clk, rst, PCAddress, pcnow);
    InstMem instmem(pcnow, dowire);
    IFID ifid (clk, dowire, opwire, funcwire, rdwire, 
            rswire, rtwire, immwire);
    CtrUnit ctrunit(opwire, funcwire,
           wregwire, m2regwire, wmemwire,
           aluimmwire, regrtwire, alucwire);
    RegFile regfile(wwregwire, rswire, rtwire, wmuxwire,
           dwire, qawire, qbwire);
    CtrMux ctrmux(regrtwire, rdwire, rtwire,muxwire); 
    Extender extender(immwire, longwire);   
    IDEXE idexe(clk, wregwire, m2regwire,
           wmemwire, aluimmwire, alucwire, qawire, qbwire, muxwire,
           longwire, ewregwire, em2regwire, ewmemwire, ealuimmwire,
           ealucwire, eqawire, eqbwire, emuxwire, Extenderwire);
    ALUMux alumux(eqbwire, Extenderwire,ealuimmwire, bwire);
    ALU alu(eqawire, bwire, ealucwire, rwire);
    EXEMEM exemem(clk, ewregwire, em2regwire, ewmemwire, emuxwire, 
           eqbwire,rwire, mwregwire, mm2regwire, mwmemwire, mmuxwire,
           mqbwire, mrwire);
    DataMem datamem(mrwire, mqbwire, mwmemwire, mdowire);
    MEMWB memwb(clk, mwregwire, mm2regwire, mmuxwire, mrwire, mdowire,
           wwregwire, wm2regwire, wmuxwire, wrwire, wdowire);
    WriteBackMux writebackmux(wrwire, wdowire, wm2regwire,dwire);   
         
    initial 
    begin
        clk = 1;
        PCAddress = 100;
        rst = 1;
        #1 rst = 0;
    end
  
    always 
       #50 clk = ! clk;
endmodule
