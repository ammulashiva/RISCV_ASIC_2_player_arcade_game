

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

reg [2:0] input_wires; 
wire [11:0] output_wires ; 
wire [2:0] pc ; 
wire buzzer ;
wire [2:0]instructions ;


reg [7:0] to_send;
always begin
#1000 input_wires[2] = ~input_wires[2] ;
end
always begin
#50 input_wires[1] = ~input_wires[1];
end
always begin
#200 input_wires[0] = ~input_wires[0];
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
    input_wires[2] = 0 ;
    input_wires[1:0] = 2'b00;
    #4000
    resetn = 1'b1;
    rst=0;
    neg_rst = 0; 
    rst_pin = 0 ; 
  

    uart_rx_en = 1'b0;
  
    #100000
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
.input_gpio_pins(input_wires), 
.output_gpio_pins(output_wires), 
.write_done(write_done),
.instructions(instructions),
.buzzer(buzzer)); 



endmodule
