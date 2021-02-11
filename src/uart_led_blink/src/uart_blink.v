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

module uart_blink (
    i_clk_p, 
    i_clk_n, 
    i_rst, 
    o_led, 
    o_uart_tx, 
    i_uart_rx
);

//-----------------------------------------------------------------------------------
// Parameters 
//-----------------------------------------------------------------------------------
parameter BaudRate = 9600;
parameter SystemClockFrequency = 100000000;
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
//-----------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------
// Signals
//-----------------------------------------------------------------------------------
wire clk;
wire transmit, received;
wire [7:0] tx_byte, rx_byte;
wire is_receiving, is_transmitting;
wire recv_error;
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
// Simple UART 
//-----------------------------------------------------------------------------------
uart #(
    .baud_rate(BaudRate),               // default is 9600
    .sys_clk_freq(SystemClockFrequency) // default is 100000000
) uart_inst (
    .clk(clk),                          // The master clock for this module
    .rst(i_rst),                        // Synchronous reset
    .rx(i_uart_rx),                     // Incoming serial line
    .tx(o_uart_tx),                     // Outgoing serial line
    .transmit(transmit),                // Signal to transmit
    .tx_byte(tx_byte),                  // Byte to transmit
    .received(received),                // Indicated that a byte has been received
    .rx_byte(rx_byte),                  // Byte received
    .is_receiving(is_receiving),        // Low when receive line is idle
    .is_transmitting(is_transmitting),  // Low when transmit line is idle
    .recv_error(recv_error)             // Indicates error in receiving packet.
);
//-----------------------------------------------------------------------------------

//-----------------------------------------------------------------------------------
// Connect LEDs to UART
//-----------------------------------------------------------------------------------
always @(posedge clk or posedge i_rst) begin
    if (i_rst) o_led <= 8'd0;
    else if (received) o_led <= rx_byte;
end
//-----------------------------------------------------------------------------------

endmodule 

`default_nettype wire 
