

// 
// Module: tb
// 
// Notes:
// - Top level simulation testbench.
//

//`timescale 1ns/1ns
//`define WAVES_FILE "./work/waves-rx.vcd"

module tb();
    
reg        clk          ; // Top level system clock input.
reg rst;
reg neg_clk; 
reg neg_rst ; 
reg        resetn       ;
reg        uart_rxd     ; // UART Recieve pin.

reg        uart_rx_en   ; // Recieve enable
//wire [8:0] res;
wire       uart_rx_break; // Did we get a BREAK message?
wire       uart_rx_valid; // Valid data recieved and available.
wire [7:0] uart_rx_data ; // The recieved data.
wire [31:0] inst ; 
wire [31:0] inst_mem ; 

reg rst_pin ; 
wire write_done ; 


// Bit rate of the UART line we are testing.
localparam BIT_RATE = 9600;
localparam BIT_P    = (1000000000/BIT_RATE);


// Period and frequency of the system clock.
localparam CLK_HZ   = 50000000;
localparam CLK_P    = 1000000000/ CLK_HZ;

reg slow_clk = 0;


// Make the clock tick.
always begin #(CLK_P/2) clk  = ~clk; end   
always begin #(CLK_P/2) neg_clk  = ~neg_clk; end     
always begin #(CLK_P*2) slow_clk <= !slow_clk;end



initial 
begin 
    $dumpfile("waveform.vcd");
    $dumpvars(0,tb);
end 

reg timer_in, Key_2, Key_1; 
wire [5:0] LED_count_1, LED_count_2; 
wire [2:0] pc ; 
wire buzzer ;
wire [2:0]instructions ;


reg [7:0] to_send;
always begin
#100 timer_in = ~timer_in ;
end
always begin
#500 Key_1 = ~Key_1;
end
always begin
#7000 Key_2 = ~Key_2;
end
initial begin
    rst=1;
    rst_pin=1; 
    neg_rst = 1; 
    resetn  = 1'b0;
    clk     = 1'b0;
    neg_clk = 1; 
    neg_rst = ~clk ;
    uart_rxd = 1'b1;
    neg_clk = 1'b1;
    timer_in = 0 ;
    Key_1 = 1'b0;
    Key_2 = 1'b0 ;
    #4000
    resetn = 1'b1;
    rst=0;
    neg_rst = 0; 
    rst_pin = 0 ; 
  

     /*   uart_rx_en = 1'b1;
    @(posedge slow_clk);write_instruction(32'h00000000); 
    @(posedge slow_clk);write_instruction(32'h00000000); 
    @(posedge slow_clk);write_instruction(32'hfd010113); 
    @(posedge slow_clk);write_instruction(32'h02112623); 
    @(posedge slow_clk);write_instruction(32'h02812423); 
    @(posedge slow_clk);write_instruction(32'h03010413); 
    @(posedge slow_clk);write_instruction(32'h00100793); 
    @(posedge slow_clk);write_instruction(32'hfef42623); 
    @(posedge slow_clk);write_instruction(32'h00100793); 
    @(posedge slow_clk);write_instruction(32'hfef42423); 
    @(posedge slow_clk);write_instruction(32'hfe042223); 
    @(posedge slow_clk);write_instruction(32'h03300793); 
    @(posedge slow_clk);write_instruction(32'hfef42023); 
    @(posedge slow_clk);write_instruction(32'h00100513); 
    @(posedge slow_clk);write_instruction(32'h310000ef); 
    @(posedge slow_clk);write_instruction(32'hfca42e23); 
    @(posedge slow_clk);write_instruction(32'h00200513); 
    @(posedge slow_clk);write_instruction(32'h304000ef); 
    @(posedge slow_clk);write_instruction(32'hfca42c23); 
    @(posedge slow_clk);write_instruction(32'hfe442783); 
    @(posedge slow_clk);write_instruction(32'hfcf42a23); 
    @(posedge slow_clk);write_instruction(32'hfe042783); 
    @(posedge slow_clk);write_instruction(32'hfcf42823); 
    @(posedge slow_clk);write_instruction(32'hfdc42783); 
    @(posedge slow_clk);write_instruction(32'h12078263); 
    @(posedge slow_clk);write_instruction(32'hfd842783); 
    @(posedge slow_clk);write_instruction(32'h10078e63); 
    @(posedge slow_clk);write_instruction(32'hfec42703); 
    @(posedge slow_clk);write_instruction(32'h00100793); 
    @(posedge slow_clk);write_instruction(32'h04f71a63); 
    @(posedge slow_clk);write_instruction(32'hfe842703); 
    @(posedge slow_clk);write_instruction(32'h00100793); 
    @(posedge slow_clk);write_instruction(32'h04f71463); 
    @(posedge slow_clk);write_instruction(32'hfe042703); 
    @(posedge slow_clk);write_instruction(32'hfe442783); 
    @(posedge slow_clk);write_instruction(32'h40f70733); 
    @(posedge slow_clk);write_instruction(32'h00100793); 
    @(posedge slow_clk);write_instruction(32'h02e7f463); 
    @(posedge slow_clk);write_instruction(32'hfe042783); 
    @(posedge slow_clk);write_instruction(32'hfff78793); 
    @(posedge slow_clk);write_instruction(32'hfef42023); 
    @(posedge slow_clk);write_instruction(32'hfe042423); 
    @(posedge slow_clk);write_instruction(32'hfe442783); 
    @(posedge slow_clk);write_instruction(32'h00178793); 
    @(posedge slow_clk);write_instruction(32'hfef42223); 
    @(posedge slow_clk);write_instruction(32'hfe042623); 
    @(posedge slow_clk);write_instruction(32'h0c80006f); 
    @(posedge slow_clk);write_instruction(32'hfe042623); 
    @(posedge slow_clk);write_instruction(32'hfe042423); 
    @(posedge slow_clk);write_instruction(32'h0bc0006f); 
    @(posedge slow_clk);write_instruction(32'hfec42783); 
    @(posedge slow_clk);write_instruction(32'h04079c63); 
    @(posedge slow_clk);write_instruction(32'hfe842703); 
    @(posedge slow_clk);write_instruction(32'h00100793); 
    @(posedge slow_clk);write_instruction(32'h04f71663); 
    @(posedge slow_clk);write_instruction(32'hfe042703); 
    @(posedge slow_clk);write_instruction(32'hfe442783); 
    @(posedge slow_clk);write_instruction(32'h40f70733); 
    @(posedge slow_clk);write_instruction(32'h00100793); 
    @(posedge slow_clk);write_instruction(32'h00e7fc63); 
    @(posedge slow_clk);write_instruction(32'hfe042783); 
    @(posedge slow_clk);write_instruction(32'hfff78793); 
    @(posedge slow_clk);write_instruction(32'hfef42023); 
    @(posedge slow_clk);write_instruction(32'hfe042423); 
    @(posedge slow_clk);write_instruction(32'h0800006f); 
    @(posedge slow_clk);write_instruction(32'hfe042783); 
    @(posedge slow_clk);write_instruction(32'hfff78793); 
    @(posedge slow_clk);write_instruction(32'hfef42023); 
    @(posedge slow_clk);write_instruction(32'hfe042423); 
    @(posedge slow_clk);write_instruction(32'hfe442783); 
    @(posedge slow_clk);write_instruction(32'hfff78793); 
    @(posedge slow_clk);write_instruction(32'hfef42223); 
    @(posedge slow_clk);write_instruction(32'h0600006f); 
    @(posedge slow_clk);write_instruction(32'hfec42703); 
    @(posedge slow_clk);write_instruction(32'h00100793); 
    @(posedge slow_clk);write_instruction(32'h12f71e63); 
    @(posedge slow_clk);write_instruction(32'hfe842783); 
    @(posedge slow_clk);write_instruction(32'h12079a63); 
    @(posedge slow_clk);write_instruction(32'hfe042703); 
    @(posedge slow_clk);write_instruction(32'hfe442783); 
    @(posedge slow_clk);write_instruction(32'h40f70733); 
    @(posedge slow_clk);write_instruction(32'h00100793); 
    @(posedge slow_clk);write_instruction(32'h00e7fc63); 
    @(posedge slow_clk);write_instruction(32'hfe442783); 
    @(posedge slow_clk);write_instruction(32'h00178793); 
    @(posedge slow_clk);write_instruction(32'hfef42223); 
    @(posedge slow_clk);write_instruction(32'hfe042623); 
    @(posedge slow_clk);write_instruction(32'h10c0006f); 
    @(posedge slow_clk);write_instruction(32'hfe442783); 
    @(posedge slow_clk);write_instruction(32'h00178793); 
    @(posedge slow_clk);write_instruction(32'hfef42223); 
    @(posedge slow_clk);write_instruction(32'hfe042623); 
    @(posedge slow_clk);write_instruction(32'hfe042783); 
    @(posedge slow_clk);write_instruction(32'h00178793); 
    @(posedge slow_clk);write_instruction(32'hfef42023); 
    @(posedge slow_clk);write_instruction(32'h0ec0006f); 
    @(posedge slow_clk);write_instruction(32'h0e80006f); 
    @(posedge slow_clk);write_instruction(32'hfdc42783); 
    @(posedge slow_clk);write_instruction(32'h06078263); 
    @(posedge slow_clk);write_instruction(32'hfd842783); 
    @(posedge slow_clk);write_instruction(32'h04079e63); 
    @(posedge slow_clk);write_instruction(32'h00100793); 
    @(posedge slow_clk);write_instruction(32'hfef42423); 
    @(posedge slow_clk);write_instruction(32'hfec42783); 
    @(posedge slow_clk);write_instruction(32'h0c078663); 
    @(posedge slow_clk);write_instruction(32'hfe042703); 
    @(posedge slow_clk);write_instruction(32'hfe442783); 
    @(posedge slow_clk);write_instruction(32'h40f70733); 
    @(posedge slow_clk);write_instruction(32'h00100793); 
    @(posedge slow_clk);write_instruction(32'h00e7fc63); 
    @(posedge slow_clk);write_instruction(32'hfe442783); 
    @(posedge slow_clk);write_instruction(32'h00178793); 
    @(posedge slow_clk);write_instruction(32'hfef42223); 
    @(posedge slow_clk);write_instruction(32'hfe042623); 
    @(posedge slow_clk);write_instruction(32'h0a40006f); 
    @(posedge slow_clk);write_instruction(32'hfe442783); 
    @(posedge slow_clk);write_instruction(32'h00178793); 
    @(posedge slow_clk);write_instruction(32'hfef42223); 
    @(posedge slow_clk);write_instruction(32'hfe042623); 
    @(posedge slow_clk);write_instruction(32'hfe042783); 
    @(posedge slow_clk);write_instruction(32'h00178793); 
    @(posedge slow_clk);write_instruction(32'hfef42023); 
    @(posedge slow_clk);write_instruction(32'h0840006f); 
    @(posedge slow_clk);write_instruction(32'hfdc42783); 
    @(posedge slow_clk);write_instruction(32'h06079263); 
    @(posedge slow_clk);write_instruction(32'hfd842783); 
    @(posedge slow_clk);write_instruction(32'h04078e63); 
    @(posedge slow_clk);write_instruction(32'h00100793); 
    @(posedge slow_clk);write_instruction(32'hfef42623); 
    @(posedge slow_clk);write_instruction(32'hfe842783); 
    @(posedge slow_clk);write_instruction(32'h06078263); 
    @(posedge slow_clk);write_instruction(32'hfe042703); 
    @(posedge slow_clk);write_instruction(32'hfe442783); 
    @(posedge slow_clk);write_instruction(32'h40f70733); 
    @(posedge slow_clk);write_instruction(32'h00100793); 
    @(posedge slow_clk);write_instruction(32'h00e7fc63); 
    @(posedge slow_clk);write_instruction(32'hfe042783); 
    @(posedge slow_clk);write_instruction(32'hfff78793); 
    @(posedge slow_clk);write_instruction(32'hfef42023); 
    @(posedge slow_clk);write_instruction(32'hfe042423); 
    @(posedge slow_clk);write_instruction(32'h03c0006f); 
    @(posedge slow_clk);write_instruction(32'hfe042783); 
    @(posedge slow_clk);write_instruction(32'hfff78793); 
    @(posedge slow_clk);write_instruction(32'hfef42023); 
    @(posedge slow_clk);write_instruction(32'hfe042423); 
    @(posedge slow_clk);write_instruction(32'hfe442783); 
    @(posedge slow_clk);write_instruction(32'hfff78793); 
    @(posedge slow_clk);write_instruction(32'hfef42223); 
    @(posedge slow_clk);write_instruction(32'h01c0006f); 
    @(posedge slow_clk);write_instruction(32'h00100793); 
    @(posedge slow_clk);write_instruction(32'hfef42623); 
    @(posedge slow_clk);write_instruction(32'h00100793); 
    @(posedge slow_clk);write_instruction(32'hfef42423); 
    @(posedge slow_clk);write_instruction(32'h0080006f); 
    @(posedge slow_clk);write_instruction(32'h00000013); 
    @(posedge slow_clk);write_instruction(32'hfe442703); 
    @(posedge slow_clk);write_instruction(32'h03200793); 
    @(posedge slow_clk);write_instruction(32'h00e7e663); 
    @(posedge slow_clk);write_instruction(32'hfe042783); 
    @(posedge slow_clk);write_instruction(32'h0a079063); 
    @(posedge slow_clk);write_instruction(32'h00100513); 
    @(posedge slow_clk);write_instruction(32'h104000ef); 
    @(posedge slow_clk);write_instruction(32'h1f400513); 
    @(posedge slow_clk);write_instruction(32'h130000ef); 
    @(posedge slow_clk);write_instruction(32'h00000513); 
    @(posedge slow_clk);write_instruction(32'h0f4000ef); 
    @(posedge slow_clk);write_instruction(32'h3e800513); 
    @(posedge slow_clk);write_instruction(32'h120000ef); 
    @(posedge slow_clk);write_instruction(32'hfe042223); 
    @(posedge slow_clk);write_instruction(32'h03300793); 
    @(posedge slow_clk);write_instruction(32'hfef42023); 
    @(posedge slow_clk);write_instruction(32'hfe442503); 
    @(posedge slow_clk);write_instruction(32'h174000ef); 
    @(posedge slow_clk);write_instruction(32'hfe042503); 
    @(posedge slow_clk);write_instruction(32'h1ac000ef); 
    @(posedge slow_clk);write_instruction(32'h00100513); 
    @(posedge slow_clk);write_instruction(32'h0c8000ef); 
    @(posedge slow_clk);write_instruction(32'h19000513); 
    @(posedge slow_clk);write_instruction(32'h0f4000ef); 
    @(posedge slow_clk);write_instruction(32'h00000513); 
    @(posedge slow_clk);write_instruction(32'h0b8000ef); 
    @(posedge slow_clk);write_instruction(32'h25800513); 
    @(posedge slow_clk);write_instruction(32'h0e4000ef); 
    @(posedge slow_clk);write_instruction(32'h00100513); 
    @(posedge slow_clk);write_instruction(32'h0a8000ef); 
    @(posedge slow_clk);write_instruction(32'h19000513); 
    @(posedge slow_clk);write_instruction(32'h0d4000ef); 
    @(posedge slow_clk);write_instruction(32'h00000513); 
    @(posedge slow_clk);write_instruction(32'h098000ef); 
    @(posedge slow_clk);write_instruction(32'h25800513); 
    @(posedge slow_clk);write_instruction(32'h0c4000ef); 
    @(posedge slow_clk);write_instruction(32'h00100513); 
    @(posedge slow_clk);write_instruction(32'h088000ef); 
    @(posedge slow_clk);write_instruction(32'h19000513); 
    @(posedge slow_clk);write_instruction(32'h0b4000ef); 
    @(posedge slow_clk);write_instruction(32'h00000513); 
    @(posedge slow_clk);write_instruction(32'h078000ef); 
    @(posedge slow_clk);write_instruction(32'h25800513); 
    @(posedge slow_clk);write_instruction(32'h0a4000ef); 
    @(posedge slow_clk);write_instruction(32'hfd442703); 
    @(posedge slow_clk);write_instruction(32'hfe442783); 
    @(posedge slow_clk);write_instruction(32'h00f70663); 
    @(posedge slow_clk);write_instruction(32'hfe442503); 
    @(posedge slow_clk);write_instruction(32'h0f8000ef); 
    @(posedge slow_clk);write_instruction(32'hfd042703); 
    @(posedge slow_clk);write_instruction(32'hfe042783); 
    @(posedge slow_clk);write_instruction(32'hcef70ee3); 
    @(posedge slow_clk);write_instruction(32'hfe042503); 
    @(posedge slow_clk);write_instruction(32'h124000ef); 
    @(posedge slow_clk);write_instruction(32'hcf1ff06f); 
    @(posedge slow_clk);write_instruction(32'hfd010113); 
    @(posedge slow_clk);write_instruction(32'h02812623); 
    @(posedge slow_clk);write_instruction(32'h03010413); 
    @(posedge slow_clk);write_instruction(32'hfca42e23); 
    @(posedge slow_clk);write_instruction(32'hfdc42783); 
    @(posedge slow_clk);write_instruction(32'h00479793); 
    @(posedge slow_clk);write_instruction(32'hfef42623); 
    @(posedge slow_clk);write_instruction(32'hfec42783); 
    @(posedge slow_clk);write_instruction(32'h000f0e93); 
    @(posedge slow_clk);write_instruction(32'h00fef7b3); 
    @(posedge slow_clk);write_instruction(32'hfef42423); 
    @(posedge slow_clk);write_instruction(32'hfe842783); 
    @(posedge slow_clk);write_instruction(32'h00078513); 
    @(posedge slow_clk);write_instruction(32'h02c12403); 
    @(posedge slow_clk);write_instruction(32'h03010113); 
    @(posedge slow_clk);write_instruction(32'h00008067); 
    @(posedge slow_clk);write_instruction(32'hfd010113); 
    @(posedge slow_clk);write_instruction(32'h02812623); 
    @(posedge slow_clk);write_instruction(32'h03010413); 
    @(posedge slow_clk);write_instruction(32'hfca42e23); 
    @(posedge slow_clk);write_instruction(32'hfdc42783); 
    @(posedge slow_clk);write_instruction(32'h00279793); 
    @(posedge slow_clk);write_instruction(32'hfef42623); 
    @(posedge slow_clk);write_instruction(32'hfec42783); 
    @(posedge slow_clk);write_instruction(32'h00ff6f33); 
    @(posedge slow_clk);write_instruction(32'h00000013); 
    @(posedge slow_clk);write_instruction(32'h02c12403); 
    @(posedge slow_clk);write_instruction(32'h03010113); 
    @(posedge slow_clk);write_instruction(32'h00008067); 
    @(posedge slow_clk);write_instruction(32'hfd010113); 
    @(posedge slow_clk);write_instruction(32'h02812623); 
    @(posedge slow_clk);write_instruction(32'h03010413); 
    @(posedge slow_clk);write_instruction(32'hfca42e23); 
    @(posedge slow_clk);write_instruction(32'hfe042623); 
    @(posedge slow_clk);write_instruction(32'hfe042423); 
    @(posedge slow_clk);write_instruction(32'h000f0e93); 
    @(posedge slow_clk);write_instruction(32'h040ef793); 
    @(posedge slow_clk);write_instruction(32'hfef42223); 
    @(posedge slow_clk);write_instruction(32'hfe842703); 
    @(posedge slow_clk);write_instruction(32'hfe442783); 
    @(posedge slow_clk);write_instruction(32'h00f70c63); 
    @(posedge slow_clk);write_instruction(32'hfe442783); 
    @(posedge slow_clk);write_instruction(32'hfef42423); 
    @(posedge slow_clk);write_instruction(32'hfec42783); 
    @(posedge slow_clk);write_instruction(32'h00178793); 
    @(posedge slow_clk);write_instruction(32'hfef42623); 
    @(posedge slow_clk);write_instruction(32'hfec42783); 
    @(posedge slow_clk);write_instruction(32'hfdc42703); 
    @(posedge slow_clk);write_instruction(32'h00f70463); 
    @(posedge slow_clk);write_instruction(32'hfc9ff06f); 
    @(posedge slow_clk);write_instruction(32'h00000013); 
    @(posedge slow_clk);write_instruction(32'h00000013); 
    @(posedge slow_clk);write_instruction(32'h02c12403); 
    @(posedge slow_clk);write_instruction(32'h03010113); 
    @(posedge slow_clk);write_instruction(32'h00008067); 
    @(posedge slow_clk);write_instruction(32'hfd010113); 
    @(posedge slow_clk);write_instruction(32'h02812623); 
    @(posedge slow_clk);write_instruction(32'h03010413); 
    @(posedge slow_clk);write_instruction(32'hfca42e23); 
    @(posedge slow_clk);write_instruction(32'hfc0007b7); 
    @(posedge slow_clk);write_instruction(32'h07078793); 
    @(posedge slow_clk);write_instruction(32'hfef42623); 
    @(posedge slow_clk);write_instruction(32'hfdc42783); 
    @(posedge slow_clk);write_instruction(32'hfec42703); 
    @(posedge slow_clk);write_instruction(32'h01479513); 
    @(posedge slow_clk);write_instruction(32'h00ef7f33); 
    @(posedge slow_clk);write_instruction(32'h00af6f33); 
    @(posedge slow_clk);write_instruction(32'h00000013); 
    @(posedge slow_clk);write_instruction(32'h02c12403); 
    @(posedge slow_clk);write_instruction(32'h03010113); 
    @(posedge slow_clk);write_instruction(32'h00008067); 
    @(posedge slow_clk);write_instruction(32'hfd010113); 
    @(posedge slow_clk);write_instruction(32'h02812623); 
    @(posedge slow_clk);write_instruction(32'h03010413); 
    @(posedge slow_clk);write_instruction(32'hfca42e23); 
    @(posedge slow_clk);write_instruction(32'h03f007b7); 
    @(posedge slow_clk);write_instruction(32'h07078793); 
    @(posedge slow_clk);write_instruction(32'hfef42623); 
    @(posedge slow_clk);write_instruction(32'hfdc42783); 
    @(posedge slow_clk);write_instruction(32'hfec42703); 
    @(posedge slow_clk);write_instruction(32'h01a79593); 
    @(posedge slow_clk);write_instruction(32'h00ef7f33); 
    @(posedge slow_clk);write_instruction(32'h00bf6f33); 
    @(posedge slow_clk);write_instruction(32'h00000013); 
    @(posedge slow_clk);write_instruction(32'h02c12403); 
    @(posedge slow_clk);write_instruction(32'h03010113); 
    @(posedge slow_clk);write_instruction(32'h00008067); 
    @(posedge slow_clk);write_instruction(32'hffffffff); 
    @(posedge slow_clk);write_instruction(32'hffffffff); 

     $display("Test Results:");
     $display("    PASSES: %d", passes);
     $display("    FAILS : %d", fails); */

    #2000000
    $display("Finish simulation at time %d", $time);
    $finish;
end

 wrapper dut (
.clk        (clk          ), // Top level system clock input.
.resetn       (resetn       ), // Asynchronous active low reset.
.uart_rxd     (uart_rxd     ), // UART Recieve pin.
.uart_rx_en   (uart_rx_en   ), // Recieve enable
.uart_rx_break(uart_rx_break), // Did we get a BREAK message?
.uart_rx_valid(uart_rx_valid), // Valid data recieved and available.
.uart_rx_data (uart_rx_data ), 
.timer_in(timer_in),
.Key_2(Key_2),
.Key_1(Key_1), 
.LED_count_1(LED_count_1),
.LED_count_2(LED_count_2), 
.write_done(write_done),
.instructions(instructions),
.buzzer(buzzer)); 



endmodule
