//==============================================================================
// Author: Erik Anderson
// Description: <> 
// Naming conventions:
//    signals => snake_case
//    Parameters (aliasing signal values) => SNAKE_CASE with all caps
//    Parameters (not aliasing signal values) => CamelCase 
//==============================================================================

`timescale 1ns/1ps
`default_nettype none

module uart_led_top (
    i_clk_p, 
    i_clk_n, 
    i_rst, 
    o_led, 
    o_uart_tx, 
    i_uart_rx,
    o_uart_rts_n,
    i_uart_cts_n,
    o_fmc_debug_0,
    o_fmc_debug_1
);

//-----------------------------------------------------------------------------------
// Parameters 
//-----------------------------------------------------------------------------------
parameter BaudRate = 9600;
parameter SystemClockFrequency = 156250000;
//-----------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------
// I/O 
//-----------------------------------------------------------------------------------
input wire i_clk_p;
input wire i_clk_n;
input wire i_rst;
output reg [7:0] o_led;
output wire o_uart_tx;
input wire i_uart_rx;
output wire o_uart_rts_n; // Request to send (set this to high if ready to accept data)
input wire i_uart_cts_n; // Clear to send (if high then it is okay to send data)
output wire o_fmc_debug_0;
output wire o_fmc_debug_1;
//-----------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------
// Signals
//-----------------------------------------------------------------------------------
wire clk;
wire transmit, received;
wire [7:0] tx_byte, rx_byte;
wire is_receiving, is_transmitting;
wire recv_error;
wire uart_mm_rst;
//-----------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------
// Diff to single ended clock conversion (FPGA dependent) 
//-----------------------------------------------------------------------------------
IBUFGDS #(
    .DIFF_TERM("FALSE"), // Differential termination
    .IBUF_LOW_PWR("TRUE"), // Low power="TRUE", High performance="FALSE"
    .IOSTANDARD("DEFAULT") // Specify input IO standard
) IBUFGDS_inst (
    .O(clk), // Clock output buffer
    .I(i_clk_p), // Diff_p clock buffer input (connect directly to top-level port)
    .IB(i_clk_n) // Diff_n clock buffer input (connect directly to top-level port)
);
//-----------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------
// Simple UART to led test 
//-----------------------------------------------------------------------------------
//wire rx_valid;
//wire [7:0] rx_data;
//
//uart #(
//    .BaudRate(BaudRate),
//    .SystemClockFrequency(SystemClockFrequency)
//) uart_inst (
//    .i_clk(clk),
//    .i_rst(i_rst),
//    
//    .o_tx(o_uart_tx),
//    .i_rx(i_uart_rx),
//    .o_rts_n(o_uart_rts_n),
//    .i_cts_n(i_uart_cts_n),
//    
//    .o_tx_ready(),
//    .i_tx_valid(1'b0),
//    .i_tx_data(8'h55),
//    
//    .i_rx_ready(1'b1),
//    .o_rx_valid(rx_valid),
//    .o_rx_data(rx_data)
//);
//
//always @(*) begin
//    if (i_rst) o_led <= 8'd0;
//    else if (rx_valid) o_led <= rx_data;
//end

// For debug
assign o_fmc_debug_0 = i_uart_rx;
assign o_fmc_debug_1 = o_uart_tx;
//-----------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------
// UART LED Mem mapped
//-----------------------------------------------------------------------------------
uart_led #(
    .BaudRate(BaudRate),
    .SystemClockFrequency(SystemClockFrequency)
) uart_led_inst (
    .i_clk(clk),
    .i_rst(i_rst),
    .o_uart_tx(o_uart_tx),
    .i_uart_rx(i_uart_rx),
    .o_uart_rts_n(o_uart_rts_n),
    .i_uart_cts_n(i_uart_cts_n),
    .o_uart_rx_error(), // unused
    .o_mem_leds(o_led),
    .o_mem_reset(uart_mm_rst)
);
//-----------------------------------------------------------------------------------

////-----------------------------------------------------------------------------------
//// Simple UART 
////-----------------------------------------------------------------------------------
// Set high so PC can always send data 
//assign o_uart_rts_n = 1'b0;
//
//uart_old #(
//    .baud_rate(BaudRate),               // default is 9600
//    .sys_clk_freq(SystemClockFrequency) // default is 100000000
//) uart_inst (
//    .clk(clk),                          // The master clock for this module
//    .rst(i_rst),                        // Synchronous reset
//    .rx(i_uart_rx),                     // Incoming serial line
//    .tx(o_uart_tx),                     // Outgoing serial line
//    .transmit(transmit),                // Signal to transmit
//    .tx_byte(tx_byte),                  // Byte to transmit
//    .received(received),                // Indicated that a byte has been received
//    .rx_byte(rx_byte),                  // Byte received
//    .is_receiving(is_receiving),        // Low when receive line is idle
//    .is_transmitting(is_transmitting),  // Low when transmit line is idle
//    .recv_error(recv_error)             // Indicates error in receiving packet.
//);
////-----------------------------------------------------------------------------------
//
////-----------------------------------------------------------------------------------
//// Connect LEDs to UART
////-----------------------------------------------------------------------------------
//always @(posedge clk or posedge i_rst) begin
//    if (i_rst) o_led <= 8'd0;
//    else if (received) o_led <= rx_byte;
//end
////-----------------------------------------------------------------------------------

endmodule 

`default_nettype wire 
